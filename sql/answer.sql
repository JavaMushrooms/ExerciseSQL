-- 1. 查询" 01 "课程比" 02 "课程成绩高的学生的信息及课程分数
select * from (select * from sqlTest.SC where CId = '01') t1, (select * from sqlTest.SC where CId = '02') t2
where t1.SId = t2.SId and t1.score > t2.score

-- 1.1 查询同时存在" 01 "课程和" 02 "课程的情况

