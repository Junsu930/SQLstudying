--1
SELECT STUDENT_NAME "학생 이름", STUDENT_ADDRESS 주소지
FROM TB_STUDENT 
ORDER BY STUDENT_NAME;

--2
SELECT STUDENT_NAME, STUDENT_SSN 
FROM TB_STUDENT 
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;

--3
SELECT STUDENT_NAME 학생이름, STUDENT_NO 학번 , STUDENT_ADDRESS "거주지 주소"
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '%경기도%' OR STUDENT_ADDRESS LIKE '%강원도%')
AND SUBSTR(STUDENT_NO,1 ,1) LIKE '9'
ORDER BY STUDENT_NAME;

--4
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR 
WHERE DEPARTMENT_NO LIKE '005'
ORDER BY PROFESSOR_SSN ;

--5
SELECT STUDENT_NO, POINT 
FROM TB_STUDENT 
LEFT JOIN TB_GRADE  USING (STUDENT_NO)
WHERE CLASS_NO LIKE 'C3118100'
AND TERM_NO LIKE '200402';

--6
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO);

--7
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO);

--8 
SELECT CLASS_NAME, PROFESSOR_NAME 
FROM TB_CLASS_PROFESSOR
JOIN TB_PROFESSOR USING (PROFESSOR_NO)
JOIN TB_CLASS USING (CLASS_NO);

--9
SELECT CLASS_NAME, PROFESSOR_NAME 
FROM TB_CLASS_PROFESSOR
JOIN TB_PROFESSOR USING (PROFESSOR_NO)
JOIN TB_CLASS USING (CLASS_NO)
WHERE TB_PROFESSOR.DEPARTMENT_NO <= 21;

--10
SELECT STUDENT_NO 학번, STUDENT_NAME "학생 이름", ROUND(AVG(POINT), 1) "전체 평점"
FROM TB_STUDENT 
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME LIKE '음악학과'
GROUP BY STUDENT_NO, STUDENT_NAME
ORDER BY STUDENT_NO;

--11
SELECT DEPARTMENT_NAME 학과이름, STUDENT_NAME 학생이름, PROFESSOR_NAME 지도교수이름
FROM TB_STUDENT s 
JOIN TB_DEPARTMENT td USING (DEPARTMENT_NO)
JOIN TB_PROFESSOR p ON (p.PROFESSOR_NO = s.COACH_PROFESSOR_NO)
WHERE STUDENT_NO LIKE 'A313047';

--12  2007년에 인간관계론 수강학생 이름과 수강 학기
SELECT STUDENT_NAME, TERM_NO
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_CLASS USING (CLASS_NO)
WHERE TERM_NO LIKE '2007%'
AND CLASS_NAME LIKE '인간관계론' ;

--13 
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS 
LEFT JOIN TB_CLASS_PROFESSOR USING (CLASS_NO)
LEFT JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE PROFESSOR_NO IS NULL
AND CATEGORY LIKE '예체능';

--14 
SELECT STUDENT_NAME 학생이름, NVL(PROFESSOR_NAME, '지도교수 미지정') 지도교수
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
LEFT JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE DEPARTMENT_NAME LIKE '서반아어학과'
ORDER BY STUDENT_NO;

--15
SELECT STUDENT_NO 학번 , STUDENT_NAME 이름 , DEPARTMENT_NAME "학과 이름",  AVG(POINT) 평점
FROM TB_STUDENT 
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (STUDENT_NO)
WHERE ABSENCE_YN='N'
GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING  AVG(POINT)>= 4.0
ORDER BY STUDENT_NO;

--16
SELECT CLASS_NO, CLASS_NAME, AVG(POINT)
FROM TB_CLASS
JOIN TB_GRADE USING (CLASS_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME LIKE '환경조경학과'
AND CLASS_TYPE LIKE '전공%'
GROUP BY CLASS_NAME, CLASS_NO

--17
SELECT STUDENT_NAME, STUDENT_ADDRESS 
FROM TB_STUDENT
WHERE DEPARTMENT_NO LIKE (SELECT DEPARTMENT_NO FROM TB_STUDENT WHERE STUDENT_NAME LIKE '최경희');

--18
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (STUDENT_NO)
WHERE DEPARTMENT_NAME LIKE '국어국문학과'
GROUP BY STUDENT_NO, STUDENT_NAME
HAVING AVG(POINT) = (SELECT MAX(AVG(POINT)) FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (STUDENT_NO)
WHERE DEPARTMENT_NAME LIKE '국어국문학과'
GROUP BY STUDENT_NO); 


--19
SELECT DEPARTMENT_NAME "계열 학과명", ROUND(AVG(POINT), 1) 전공평점
FROM TB_DEPARTMENT 
JOIN TB_CLASS USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (CLASS_NO)
WHERE CATEGORY LIKE (SELECT CATEGORY FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME LIKE '환경조경학과')
AND CLASS_TYPE LIKE '전공%'
GROUP BY DEPARTMENT_NAME
ORDER BY 1;
