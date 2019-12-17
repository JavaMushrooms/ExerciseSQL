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
select stu.*, sc.avgscore from (select SId, avg(score) avgscore from sqlTest.SC group by SId having avg(score) > 60) sc, sqlTest.Student stu where sc.SId = stu.SId;

-- 3. 查询在 SC 表存在成绩的学生信息
select stu.*, sc.score from sqlTest.Student stu, sqlTest.SC sc where stu.SId = sc.SId and sc.score != 0

-- 4. 查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩(没成绩的显示为 null )
select student.sId, student.Sname, sc.courseCount, sc.sumScore from sqlTest.Student student, (
select SId, sum(score) sumScore, count(CId) courseCount from sqlTest.SC group by SId
) sc where student.SId = sc.SId

-- 4.1 查有成绩的学生信息
select * from sqlTest.Student student where exists (select SId from sqlTest.SC sc where SId = student.SId)

-- 5. 查询「李」姓老师的数量
select count(*) from sqlTest.Teacher where Tname like '李%'

-- 6. 查询学过「张三」老师授课的同学的信息
select student.* from sqlTest.Student student, sqlTest.SC sc, sqlTest.Teacher teacher, sqlTest.Course course where student.SId = sc.SId and sc.CId = course.CId and course.TId = teacher.TId and teacher.Tname = '李四'

-- 7. 查询没有学全所有课程的同学的信息
select student.* from sqlTest.Student student where student.SId not in (select sc.SId from sqlTest.SC sc group by sc.SId having count(*) = (select count(Course.CId) from sqlTest.Course))

-- 8. 查询至少有一门课与学号为" 01 "的同学所学相同的同学的信息
select distinct student.* from sqlTest.Student student, sqlTest.SC sc where sc.CId in (select sc1.CId from sqlTest.SC sc1 where sc1.SId = '01')
 and sc.SId = student.SId