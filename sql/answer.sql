-- 1. 查询" 01 "课程比" 02 "课程成绩高的学生的信息及课程分数
select * from (select * from sqlTest.SC where CId = '01') t1, (select * from sqlTest.SC where CId = '02') t2
where t1.SId = t2.SId and t1.score > t2.score

-- 1.1 查询同时存在" 01 "课程和" 02 "课程的情况
select * from (select * from sqlTest.SC where CId = '01') t1, (select * from sqlTest.SC where CId = '02') t2
where t1.SId = t2.SId

-- 1.2 查询存在" 01 "课程但可能不存在" 02 "课程的情况(不存在时显示为 null )
select * from (select * from sqlTest.SC where CId = '01') t1 left join (select * from sqlTest.SC where CId = '02') t2
on t1.SId = t2.SId

-- 1.3 查询不存在" 01 "课程但存在" 02 "课程的情况
select * from sqlTest.SC where SId not in (select SId from sqlTest.SC where CId = '01') and CId = '02'

-- 2. 查询平均成绩大于等于 60 分的同学的学生编号和学生姓名和平均成绩
select stu.*, sc.avgscore from (select SId, av)