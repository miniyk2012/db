UPDATE hr_holiday_rule_function
    SET python_code='result = ""
def my_work_age_count(employee, work_age_count_rule, work_age_type, company_work_age_cross_date, social_work_age_cross_date, period_start_date, period_end_date, datetime, datetime_minus, leave_date=None):
        """
        计算员工工龄
        :param employee: 员工对象
        :param work_age_count_rule: 工龄计算规则(preview/enough/convert)
        :param work_age_type: 工龄类型(social/inner表示社会工龄还是公司工龄)
        :param company_work_age_cross_date: 公司跨档日, datetime类型,这里折算了公司工龄调整值后的日期,是本期间所在年的某一天
        :param social_work_age_cross_date: 社会跨当日, datetime类型，这里折算了社会工龄调整值后的日期，是本期间所在年的某一天
        :param period_start_date: 当前期间开始日期, datetime类型
        :param period_end_date: 当前期间结束日期, datetime类型
        :return: 数值，表示员工工龄，float类型，是个年数值
        """
        res = 0
        work_age_cross_date = company_work_age_cross_date
        start_date = datetime.datetime.strptime(employee.hiredate, "%Y-%m-%d")  # 公司入职日期
        adjust_year = employee.company_working_age_adjustment or 0

        # 如果算社会工龄,则返回社会工龄
        if "social" == work_age_type and employee.social_work_start_date:
            work_age_cross_date = social_work_age_cross_date
            start_date = datetime.datetime.strptime(employee.social_work_start_date, "%Y-%m-%d")  # 社会入职日期
            adjust_year = employee.social_working_age_adjustment or 0
        adjusted_start_date = start_date - datetime.timedelta(days=365*adjust_year)  # 是调整后的社会工作日期或公司入职日期
        # 这里需要将入职日期加上调整值折算成新的入职日期
        if work_age_count_rule == "convert":
            work_age = datetime_minus(work_age_cross_date, adjusted_start_date) / 365.0
        elif work_age_count_rule == "preview":
            work_age = datetime_minus(period_end_date, adjusted_start_date) / 365.0
        elif work_age_count_rule == "enough":
            work_age = datetime_minus(period_start_date + datetime.timedelta(days=-1), adjusted_start_date) / 365.0
        res = work_age
        if res < 0:
            res = 0.0
        return res
result = my_work_age_count'
where id=(SELECT res_id from ir_model_data where name='function_work_age_count' and model='hr.holiday.rule.function');

SELECT  * from hr_employee;

SELECT  id from hr_employee;




