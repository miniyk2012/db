UPDATE hr_holiday_allot_rule set python_code='# 年假发假规则：
# *按月发放规则，折算档期的工龄计算方式
# 这里的年假的工龄类型是公司工龄跟社会工龄一起使用

result = 0      # 假期额度
# 从界面读取参数
init_num = rule.init_num    # 初始值
precision = rule.graininess    # 颗粒度
round_rule = rule.carry_rule     # 进位规则
is_increase_with_work_age = rule.is_increase_with_work_age    # 是否随工龄增长
growth_type = rule.growth_type      # 增长类型为"工龄定档"
frequency = rule.frequency    # 按年或按月发假,(month/year)
is_entry_convert_enable = rule.is_entry_convert_enable    # 启用入职折算
work_age_count_rule = rule.work_age_count_rule  # 工龄计算规则
legal_work_age_type = rule.legal_work_age_type  # 法定工龄类型
company_work_age_type = rule.company_work_age_type  # 公司工龄类型

is_resignation_convert_enable = rule.is_resignation_convert_enable  # 启用离职折算
yos = rule.yos
legal_yos = rule.legal_yos
company_yos = rule.company_yos
is_enable_complex_yos = rule.is_enable_complex_yos

# 指定只发法定,公司,或者两则都发
is_enable_legal_annual = rule.is_enable_legal_annual
is_enable_company_annual = rule.is_enable_company_annual
if is_enable_complex_yos:
    is_enable_legal_annual = False

period_start_date = datetime.datetime.strptime(current_period.start_date, "%Y-%m-%d")
period_end_date = datetime.datetime.strptime(current_period.end_date, "%Y-%m-%d")

if leave_date and leave_date >= period_end_date:
    leave_date = period_end_date   # 离职日期最晚也就是当前期间的最后一天
_logger.info("离职日期 %s" %leave_date)

employee_hire_date = datetime.datetime.strptime(employee.hiredate, "%Y-%m-%d")
adjust_year = employee.company_working_age_adjustment or 0
employee_hire_date = employee_hire_date - datetime.timedelta(days=365*adjust_year)  # 这是调整后的入职日期

# 计算工龄跨档日，根据使用的工龄类型不同，得到不同的跨档日
# 当启用混合工龄与天数时, 默认用公司工龄计算跨当日;
company_work_age_cross_date, social_work_age_cross_date = get_work_age_cross_date(employee, current_period=current_period)

if not employee.social_work_start_date:
    social_work_age_cross_date = company_work_age_cross_date

_logger.info("公司跨档日期 %s" %company_work_age_cross_date)
_logger.info("社会跨档日期 %s" %social_work_age_cross_date)

# 计算工龄(公司工龄,社会工龄)
social_work_age = 0
inner_work_age = 0

if is_increase_with_work_age:
    # 计算公司工龄跟社会工龄
    social_work_age = work_age_calculate_func(employee, work_age_count_rule, "social",
                                                       company_work_age_cross_date, social_work_age_cross_date,
                                                       period_start_date, period_end_date, datetime,
                                                       datetime_minus,
                                                       leave_date=is_resignation_convert_enable and leave_date)
    _logger.info("社会工龄 %s" %social_work_age)
    inner_work_age = work_age_calculate_func(employee, "convert", "inner",
                                                      company_work_age_cross_date, social_work_age_cross_date,
                                                      period_start_date, period_end_date, datetime,
                                                      datetime_minus,
                                                      leave_date=is_resignation_convert_enable and leave_date)
    _logger.info("公司工龄 %s" %inner_work_age)

# 通福祥特殊配置
# 是否当前期间新入职
is_new = True if period_start_date < employee_hire_date < period_end_date else False

# 获取法定/公司 工龄应发的天数
legal_is_cross_year = False
legal_current_num = 0
legal_before_cross_num = 0
company_is_cross_year = False
company_current_num = 0
company_before_cross_num = 0
if is_increase_with_work_age:
    # 随工龄增长
    # 根据公司工龄跟社会工龄获取对应档的假期天数
    legal_holiday_count = {}
    company_holiday_count = {}
    holiday_count = {}
    try:
        if is_enable_complex_yos:
            # 使用混合工龄天数计算

            # 通福祥特殊变化
            is_new = True if inner_work_age < 2 else False
            company_work_age_cross_date = social_work_age_cross_date
            _logger.info("yos.code %s" %yos.code)
            holiday_count = getattr(rule_obj, yos.code)(inner_work_age, social_work_age)

            if is_new:
                employee_hire_date = employee_hire_date.replace(year=employee_hire_date.year + 1)
        else:
            # 使用单一工龄与天数计算
            work_age_count = social_work_age
            if "inner" == company_work_age_type:
                work_age_count = inner_work_age

            # 法定年假 用法定工龄, 公司年假根据公司工龄类型来选择
            if is_enable_legal_annual and not is_enable_company_annual:
                work_age_holiday_num = legal_allot_rule_line.search_read(domain=[("holiday_allot_rule", "=", rule.id)], fields=["year_num", "day_num"], order="year_num asc")
                legal_holiday_count = getattr(rule_obj, legal_yos.code)(social_work_age, work_age_holiday_num)
            elif not is_enable_legal_annual and is_enable_company_annual:
                work_age_holiday_num = company_allot_rule_line.search_read(domain=[("holiday_allot_rule", "=", rule.id)], fields=["year_num", "day_num"], order="year_num asc")
                company_holiday_count = getattr(rule_obj, company_yos.code)(work_age_count, work_age_holiday_num)
            elif is_enable_legal_annual and is_enable_company_annual:
                legal_work_age_holiday_num = legal_allot_rule_line.search_read(domain=[("holiday_allot_rule", "=", rule.id)], fields=["year_num", "day_num"], order="year_num asc")
                legal_holiday_count = getattr(rule_obj, legal_yos.code)(social_work_age, legal_work_age_holiday_num)

                company_work_age_holiday_num = company_allot_rule_line.search_read(domain=[("holiday_allot_rule", "=", rule.id)], fields=["year_num", "day_num"], order="year_num asc")
                company_holiday_count = getattr(rule_obj, company_yos.code)(work_age_count, company_work_age_holiday_num)
    except:
        legal_holiday_count = {"is_cross_year": False, "last_num": 0, "current_num": 0}
        company_holiday_count = {"is_cross_year": False, "last_num": 0, "current_num": 0}
        holiday_count = {"is_cross_year": False, "last_num": 0, "current_num": 0}
    if is_enable_complex_yos:
        # 启用混合时,只发到公司年假上
        company_is_cross_year = holiday_count["is_cross_year"]
        company_current_num = holiday_count["current_num"]
        company_before_cross_num = holiday_count["last_num"]
    else:
        if legal_holiday_count:
            legal_is_cross_year = legal_holiday_count["is_cross_year"]
            legal_current_num = legal_holiday_count["current_num"]
            legal_before_cross_num = legal_holiday_count["last_num"]

        if company_holiday_count:
            company_is_cross_year = company_holiday_count["is_cross_year"]
            company_current_num = company_holiday_count["current_num"]
            company_before_cross_num = company_holiday_count["last_num"]
    _logger.info("company_is_cross_year %s" %company_is_cross_year)
    _logger.info("company_before_cross_num %s" %company_before_cross_num)
    _logger.info("company_current_num %s" %company_current_num)

day_product_uom = get_day_product_uom(employee)

# 处理初始值
init_num = _compute_qty(rule.product_uom_id.id, init_num, day_product_uom.id)
if growth_type != "normal" and is_increase_with_work_age:
    legal_current_num = init_num + legal_current_num
    legal_before_cross_num = init_num + legal_before_cross_num

    company_current_num = init_num + company_current_num
    company_before_cross_num = init_num + company_before_cross_num

# 根据是否入职离职折算,设置其按月或按天拆分的起止日期
if is_entry_convert_enable and is_new:
    period_start_date = employee_hire_date
if is_resignation_convert_enable and leave_date:
    period_end_date = leave_date

# 处理发放频率
allot_records = []
if frequency == "year":
    # 按年发的入离职跟按月不一样,这里单独处理

    # 入离职折算
    if work_age_count_rule in ["preview", "enough"]:
        legal_is_cross_year = False
        company_is_cross_year = False
    _logger.info("法定年假跨档 %s" %legal_is_cross_year)
    _logger.info("公司年假跨档 %s" %company_is_cross_year)
    _logger.info("需要入职折算 %s" %(is_new and is_entry_convert_enable))
    _logger.info("需要离职折算 %s" %(leave_date and is_resignation_convert_enable))
    legal_temp_result = entry_resignation_converter(legal_before_cross_num, legal_current_num, leave_date, period_start_date, period_end_date, social_work_age_cross_date, employee_hire_date, legal_is_cross_year, is_new and is_entry_convert_enable, leave_date and is_resignation_convert_enable)
    company_temp_result = entry_resignation_converter(company_before_cross_num, company_current_num, leave_date, period_start_date, period_end_date, company_work_age_cross_date, employee_hire_date, company_is_cross_year, is_new and is_entry_convert_enable, leave_date and is_resignation_convert_enable)
    _logger.info("company_temp_result %s" %company_temp_result)
    # 精度处理
    legal_temp_result = precision_round(legal_temp_result, precision, round_rule)
    company_temp_result = precision_round(company_temp_result, precision, round_rule)

    if is_enable_legal_annual and not is_enable_company_annual:
        # 只启用法定年假
        result = {"social": legal_temp_result, "start_date": period_start_date, "end_date": period_end_date}
        _logger.info("只启用法定年假 %s" %result)
    elif not is_enable_legal_annual and is_enable_company_annual:
        # 只启用公司年假
        result = {"company": company_temp_result, "start_date": period_start_date, "end_date": period_end_date}
        _logger.info("只启用公司年假 %s" %result)
    elif not is_enable_legal_annual and not is_enable_company_annual:
        result = -1
    elif is_enable_legal_annual and is_enable_company_annual:
        # 法定跟公司都启用
        result = {"social": legal_temp_result, "company": company_temp_result, "start_date": period_start_date, "end_date": period_end_date}
        _logger.info("法定跟公司都启用 %s" %result)

elif frequency == "month":
    # 按月发的入离职折算在分月函数中做
    social_allot_records = []
    company_allot_records = []

    standard_product_uom = get_standard_product_uom(employee)

    # 在月假类型中,我们是先转为小时类型,然后进行分月发放,并进行精度控制
    # 注意 给出的 legal_before_cross_num, legal_current_num, company_before_cross_num, company_current_num 值得单位默认都是天,所以需要转换
    legal_before_cross_num = _compute_qty(day_product_uom.id, legal_before_cross_num, standard_product_uom.id)
    legal_current_num = _compute_qty(day_product_uom.id, legal_current_num, standard_product_uom.id)
    company_before_cross_num = _compute_qty(day_product_uom.id, company_before_cross_num, standard_product_uom.id)
    company_current_num = _compute_qty(day_product_uom.id, company_current_num, standard_product_uom.id)

    if day_product_uom.id == rule.product_uom_id.id:  # 如果按天时发假
        precision = _compute_qty(rule.product_uom_id.id, float(precision), standard_product_uom.id)

    social_allot_records = divide(legal_current_num, "month", period_start_date, period_end_date, precision, round_rule, copy, datetime, precision_round, monthrange, is_entry_convert=is_new and is_entry_convert_enable, is_resignation_convert=leave_date and is_resignation_convert_enable)

    company_allot_records = divide(company_current_num, "month", period_start_date, period_end_date, precision, round_rule, copy, datetime, precision_round, monthrange, is_entry_convert=is_new and is_entry_convert_enable, is_resignation_convert=leave_date and is_resignation_convert_enable)

    if not is_enable_complex_yos and work_age_count_rule == "convert":  # 不启用混合工龄计算 且为 折算档期
        if legal_is_cross_year:
            legal_before_cross_num = divide(legal_before_cross_num, "month", period_start_date, social_work_age_cross_date, precision, round_rule, copy, datetime, precision_round, monthrange, convert=True, is_entry_convert=is_new and is_entry_convert_enable, is_resignation_convert=leave_date and is_resignation_convert_enable)

            legal_current_num = divide(legal_current_num, "month", social_work_age_cross_date, period_end_date, precision, round_rule, copy, datetime, precision_round, monthrange, convert=True, is_entry_convert=is_new and is_entry_convert_enable, is_resignation_convert=leave_date and is_resignation_convert_enable)

            social_allot_records = rule_obj.merge_divide(legal_before_cross_num, legal_current_num)

        if company_is_cross_year:
            company_before_cross_num = divide(company_before_cross_num, "month", period_start_date, company_work_age_cross_date, precision, round_rule, copy, datetime, precision_round, monthrange, convert=True, is_entry_convert=is_new and is_entry_convert_enable, is_resignation_convert=leave_date and is_resignation_convert_enable)

            company_current_num = divide(company_current_num, "month", company_work_age_cross_date, period_end_date, precision, round_rule, copy, datetime, precision_round, monthrange, convert=True, is_entry_convert=is_new and is_entry_convert_enable, is_resignation_convert=leave_date and is_resignation_convert_enable)

            company_allot_records = rule_obj.merge_divide(company_before_cross_num, company_current_num)

    elif is_enable_complex_yos and work_age_count_rule == "convert":
        # 启用混和工龄的 折算档期
        if company_is_cross_year:
            company_before_cross_num = divide(company_before_cross_num, "month", period_start_date, company_work_age_cross_date, precision, round_rule, copy, datetime, precision_round, monthrange, convert=True, is_entry_convert=is_new and is_entry_convert_enable, is_resignation_convert=leave_date and is_resignation_convert_enable)

            company_current_num = divide(company_current_num, "month", company_work_age_cross_date, period_end_date, precision, round_rule, copy, datetime, precision_round, monthrange, convert=True, is_entry_convert=is_new and is_entry_convert_enable, is_resignation_convert=leave_date and is_resignation_convert_enable)

            company_allot_records = rule_obj.merge_divide(company_before_cross_num, company_current_num)

    # 处理启用的类型
    if is_enable_legal_annual and not is_enable_company_annual:
        # 只启用法定年假
        company_allot_records = False
    elif not is_enable_legal_annual and is_enable_company_annual:
        # 只启用公司年假
        social_allot_records = False
    elif not is_enable_legal_annual and not is_enable_company_annual:
        social_allot_records = False
        company_allot_records = False

    if social_allot_records:
        for record in social_allot_records:
            record.update({"type": "social"})
        allot_records += social_allot_records
    if company_allot_records:
        for record in company_allot_records:
            record.update({"type": "company"})
        allot_records += company_allot_records
    result = allot_records
'
where holiday_type_id=
(select res_id from ir_model_data where name='annual_leave_type' and model='hr.holiday.type');