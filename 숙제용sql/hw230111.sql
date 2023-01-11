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


