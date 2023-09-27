CREATE TABLE depts AS (SELECT * FROM departments);

SELECT * FROM depts;

DELETE FROM depts WHERE department_id = 290;
-- ���� 1
INSERT INTO depts (department_id, department_name, location_id)
VALUES(280, '����', 1800);

INSERT INTO depts (department_id, department_name, location_id)
VALUES(290, 'ȸ���', 1800);

INSERT INTO depts (department_id, department_name, location_id)
VALUES(300, '����', 1800);

INSERT INTO depts (department_id, department_name, location_id)
VALUES(310, '�λ�', 1800);

INSERT INTO depts (department_id, department_name, location_id)
VALUES(320, '����', 1700);

-- ���� 2
-- ���� 2-1
UPDATE depts SET department_name = 'IT_BANK'
WHERE department_name = 'IT_Support';

-- 2-2
UPDATE depts SET manager_id = 301
WHERE department_id = 290;

-- 2-3
UPDATE depts
SET
    department_name = 'IT Help',
    manager_id = 303,
    location_id = 1800
WHERE department_name = 'IT Helpdesk';

-- 2-4
UPDATE depts
SET
    manager_id = 301
WHERE department_id IN (290, 300, 310, 320);

SELECT * FROM depts;

-- ���� 3

DELETE FROM depts WHERE department_id = (SELECT department_id FROM depts WHERE department_name = '����');

DELETE FROM depts WHERE department_id = (SELECT department_id FROM depts WHERE department_name = 'NOC');

-- ���� 4
-- 4-1
DELETE FROM depts WHERE department_id > 200;

-- 4-2
UPDATE depts
SET manager_id = 100
WHERE manager_id IS NOT NULL;

SELECT * FROM departments;
DELETE FROM departments WHERE department_id = 290 or department_id = 280;
-- 4-4
MERGE INTO depts a
    USING (SELECT * FROM departments) d
    ON (a.department_id = d.department_id)
WHEN MATCHED THEN
    UPDATE SET
    a.department_name = d.department_name,
    a.manager_id = d.manager_id,
    a.location_id = d.location_id
    
WHEN NOT MATCHED THEN
    INSERT VALUES
    (d.department_id, d.department_name, d.manager_id, d.location_id);

-- ���� 5
-- 5-1
CREATE TABLE jobs_it AS
(SELECT * FROM jobs WHERE min_salary > 6000);

SELECT * FROM jobs_it;
SELECT * FROM jobs;

-- 5-2
INSERT INTO jobs_it VALUES('IT_DEV', '����Ƽ������', 6000, 20000);
INSERT INTO jobs_it VALUES('NET_DEV', '��Ʈ��ũ������', 5000, 20000);
INSERT INTO jobs_it VALUES('SEC_DEV', '���Ȱ�����', 6000, 19000);

-- 5-4
MERGE INTO jobs_it a
    USING (SELECT * FROM jobs WHERE min_salary > 5000) b
    ON (a.job_id = b.job_id)
WHEN MATCHED THEN
    UPDATE SET
        a.min_salary = b.min_salary,
        a.max_salary = b.max_salary
    
WHEN NOT MATCHED THEN
    INSERT VALUES
    (b.job_id, b.job_title, b.min_salary, b.max_salary);
