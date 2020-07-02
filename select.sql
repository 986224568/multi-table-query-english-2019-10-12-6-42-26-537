# 1.Query the existence of 1 course

select 
count(s.id) num
from student as s, course as c, student_course as sc 
where s.id = sc.studentId and c.id = sc.courseId and c.id = '1'

# 2.Query the presence of both 1 and 2 courses

select 
count(sc.studentId) num
from 
student_course sc
inner join 
student_course sc1
on sc.studentId = sc1.studentId
where sc.courseId = '1' and sc1.courseId = '2'

# 3.Query the student number and student name and average score of students whose average score is 60 or higher.

select sc1.id, sc1.name, avg(sc1.score) average from 
(select
s.id, s.name, sc.score
from student s
join
student_course sc
on s.id = sc.studentId) sc1
group by sc1.id
having avg(sc1.score) >= 60

# 4.Query the SQL statement of student information that does not have grades in the student_course table

select s.*
from student s
join
(select distinct studentId from student_course where score = 0) sc
on s.id = sc.studentId

# 5.Query all SQL with grades

select s.*
from student s
join
(select distinct studentId from student_course where score <> 0) sc
on s.id = sc.studentId

# 6.Inquire about the information of classmates who have numbered 1 and also studied the course numbered 2

select
s.*
from student s
join
student_course sc
on s.id = sc.studentId
where s.id = '1' and sc.courseId = '2'

# 7.Retrieve 1 student score with less than 60 scores in descending order

select
score
from
student_course
where score < 60
order by score
desc
limit 1

# 8.Query the average grade of each course. The results are ranked in descending order of average grade. When the average grades are the same, they are sorted in ascending order by course number.

SELECT
courseid, AVG(score) average 
FROM student_course
GROUP BY courseid 
ORDER BY average DESC, courseid ASC

# 9.Query the name and score of a student whose course name is "Math" and whose score is less than 60

select 
s.name, sc.score
from student s, course c, student_course sc 
where s.id = sc.studentId and c.id = sc.courseId and c.name = 'Math'
group by s.name
having sc.score < 60