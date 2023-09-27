
/*
view�� �������� �ڷḸ ���� ���� ����ϴ� ���� ���̺��� �����Դϴ�.
��� �⺻ ���̺��� ������ ���� ���̺��̱� ������
�ʿ��� �÷��� ������ �θ� ������ ������ ���ϴ�.
��� �������̺��� ���� �����Ͱ� ���������� ����� ���´� �ƴմϴ�.
�並 ���ؼ� �����Ϳ� �����ϸ� ���� �����ʹ� �����ϰ� ��ȣ�� �� �ֽ��ϴ�.
*/

SELECT * FROM user_sys_privs; --���� Ȯ��

-- �ܼ� �� : �ϳ��� ���̺��� �̿��Ͽ� ������ ��
-- ���� �÷� �̸��� �Լ� ȣ�⹮, ����� �� ���� ���� ǥ�����̸� �ȵ˴ϴ�.
SELECT
    employee_id,
    first_name || ' ' || last_name,
    job_id,
    salary
FROM employees
WHERE department_id = 60;


CREATE VIEW view_emp AS(
    SELECT
        employee_id,
        first_name || ' ' || last_name AS full_name,
        job_id,
        salary
    FROM employees
    WHERE department_id = 60
);

SELECT * FROM view_emp
WHERE salary >= 6000;

-- ���� ��
-- ���� ���̺��� �����Ͽ� �ʿ��� �����͸� �����ϰ� ���� Ȯ���� ���� ���.
CREATE VIEW view_emp_dept_jobs AS (
    SELECT
        e.employee_id,
        first_name || ' ' || last_name AS full_name,
        d.department_name,
        j.job_title
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    LEFT JOIN jobs
    ON e.job_id = j.job_id
)
ORDER BY employee_id ASC;

SELECT * FROM view_emp_dept_jobs;

-- ���� ����(CREATE OR REPLACE VIEW ����)
-- ���� �̸����� �ش� ������ ����ϸ� �����Ͱ� ����Ǹ鼭 ���Ӱ� �����˴ϴ�.

CREATE OR REPLACE VIEW view_emp_dept_jobs AS (
    SELECT
        e.employee_id,
        first_name || ' ' || last_name AS full_name,
        d.department_name,
        j.job_title,
        e.salary -- �߰��� �κ�
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
ORDER BY employee_id ASC;

SELECT * FROM view_emp_dept_jobs;


SELECT
    job_title,
    AVG(salary) AS avg
FROM view_emp_dept_jobs
GROUP BY job_title
ORDER BY AVG(salary) DESC; --SQL ������ Ȯ���� ª����.

-- �� ����
DROP VIEW view_emp;

/*
VIEW�� INSERT�� �Ͼ�� ��� ���� ���̺����� �ݿ��� �˴ϴ�.
�׷��� VIEW�� INSERT, UPDATE, DELETE�� ���� ���� ������ �����ϴ�.
���� ���̺��� NOT NULL�� ��� VIEW�� INSERT�� �Ұ����մϴ�.
VIEW���� ����ϴ� �÷��� ������ ��쿡�� �ȵ˴ϴ�.
*/

-- �� ��° �÷��� 'full_name'�� ����(virtual column)�̱� ������ INSERT �ȵ˴ϴ�.
INSERT INTO view_emp_dept_jobs
VALUES(300, 'test', 'test', 'test', 10000); -- �ȵ�

-- JOIN�� ���� ��� �� ���� ������ �� �����ϴ�.
INSERT INTO view_emp_dept_jobs
(employee_id, department_name, job_title, salary)
VALUES(300, 'test', 'test', 10000);

INSERT INTO view_emp
(employee_id, job_id, salary)
VALUES(300, 'test', 10000); -- �ȵ�.

-- ����, ����, ���� ���� �� ���� ���̺��� �ݿ��˴ϴ�.
DELETE FROM view_emp
WHERE employee_id = 107;

SELECT * FROM view_emp;
SELECT * FROM employees;
ROLLBACK;

-- WITH CHECK OPTION -> ���� ���� �÷�
-- �並 ������ �� ����� ���� �÷��� �並 ���ؼ� ������ �� ���� ���ִ� Ű����
CREATE VIEW view_emp_test AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        email,
        hire_date,
        job_id,
        department_id
    FROM employees
    WHERE department_id = 60
)
WITH CHECK OPTION CONSTRAINT view_emp_test_ck;

UPDATE view_emp_test
SET job_id = 'AD_VP'
WHERE employee_id = 107;

SELECT * FROM view_emp_test;

DROP TABLE view_emp_test;

-- �б� ���� �� -- WITH READ ONLY (DML ������ ���� -> SELECT�� ���)
CREATE OR REPLACE VIEW view_emp_test AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        email,
        hire_date,
        job_id,
        department_id
    FROM employees
    WHERE department_id = 60
)
WITH READ ONLY;

/*
���� 12. 
employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 
1-10��° �����͸� ����մϴ�.
����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, 
�μ����̵�, �μ��̸� �� ����մϴ�.
����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.
*/

/*
���� 13. 
--EMPLOYEES �� DEPARTMENTS ���̺����� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID, 
DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���.
*/

/*
���� 14
--DEPARTMENT���̺����� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
--�ο��� ���� �������� �����ϼ���.
--����� ���� �μ��� ������� ���� �ʽ��ϴ�.
*/

/*
���� 15
--�μ��� ���� ���� ���ο�, �ּ�, ������ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���.
--�μ��� ����� ������ 0���� ����ϼ���.
*/

/*
���� 16
-���� 15 ����� ���� DEPARTMENT_ID�������� �������� �����ؼ� 
ROWNUM�� �ٿ� 1-10 ������ ������ ����ϼ���.
*/