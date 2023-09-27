-- ���̺� ������ ��������
-- : ���̺� �������� �����Ͱ� �ԷµǴ� ���� �����ϱ� ���� ��Ģ�� �����ϴ� ��
-- ���̺� ������ �������� (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: ���̺��� ���� �ĺ� �÷��Դϴ�. (�ֿ� Ű)
-- UNIQUE: ������ ���� ���� �ϴ� �÷� (�ߺ��� ����)
-- NOT NULL: null�� ������� ����.
-- FOREIGN KEY: �����ϴ� ���̺��� PRIMARY KEY�� �����ϴ� �÷�
-- CHECK: ���ǵ� ���ĸ� ����ǵ��� ���.

-- �÷� ���� ���� ���� (�÷� ���𸶴� �������� ����)
CREATE TABLE dept2 (
    dept_no NUMBER(2) CONSTRAINT dept2_deptno_pk PRIMARY KEY,
    dept_name VARCHAR2(14) NOT NULL CONSTRAINT dept2_deptname_uk UNIQUE,
    loca VARCHAR2(15) CONSTRAINT dept2_loca_locid_fk REFERENCES locations(location_id),
    dept_bonus NUMBER(10) CONSTRAINT dept2_bonus_ck CHECK(dept_bonus>0),
    dept_gender VARCHAR2(1) CONSTRAINT dept2_gender_ck CHECK(dept_gender IN ('M','F'))
);

DROP TABLE dept2;

CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(15),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1),
    
    CONSTRAINT dept2_deptno_pk PRIMARY KEY(dept_no),
    CONSTRAINT dept2_deptname_uk UNIQUE(dept_name),
    CONSTRAINT dept2_loca_locid_fk FOREIGN KEY(loca) REFERENCES locations(location_id),
    CONSTRAINT dept2_bonus_ck CHECK(dept_bonus>0),
    CONSTRAINT dept2_gender_ck CHECK(dept_gender IN ('M','F'))
);

SELECT * FROM dept2;

--�ܷ� Ű (foreign key)�� �θ����̺�(�������̺�)�� ���ٸ� INSERT �Ұ���
--INSERT INTO dept2 VALUES (20,'gg',4000,100000,'M');

INSERT INTO dept2 VALUES (10,'gg',3000,100000,'M');
INSERT INTO dept2 VALUES (20,'hh',1900,100000,'M');
--UPDATE dept2 SET loca = 4000 WHERE dept_no = 10; -- ����(�ܷ�Ű �������� ����)

-- ���������� ����
-- ���������� �߰�, ������ �����մϴ�. ������ �ȵ˴ϴ�.
-- �����Ϸ��� �����ϰ� ���ο� �������� �߰��ϼž� �մϴ�.


CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(15),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1)
);

-- PK �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept_no_pk PRIMARY KEY(dept_no);
-- FK �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_loca_locid_fk FOREIGN KEY(loca) REFERENCES locations(location_id);
-- CHECK �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_bonus_ck CHECK(dept_bonus>0);
-- UNIQUE �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_deptname_uk UNIQUE(dept_name);
-- NOT NULL�� �� �������·� �����մϴ�.
ALTER TABLE dept2 MODIFY dept_bonus NUMBER(10) NOT NULL;

-- ���� ���� Ȯ��
SELECT * FROM user_constraints WHERE table_name = 'DEPT2';

-- ���� ���� ���� (���� ���� �̸�����)
ALTER TABLE dept2 DROP CONSTRAINT DEPT2_DEPTNO_PK;

-------------------------------------------------------------------------------
CREATE TABLE members(
    m_name VARCHAR2(3) NOT NULL,
    m_num NUMBER(2) CONSTRAINT mem_memmnum_pk PRIMARY KEY, 
    reg_date DATE NOT NULL CONSTRAINT mem_regdate_uk UNIQUE,
    gender VARCHAR2(1),
    loca NUMBER(5) CONSTRAINT mem_loca_loc_locid_fk REFERENCES locations(location_id)
);

INSERT INTO members VALUES('AAA',1,'2018-07-01','M',1800);
INSERT INTO members VALUES('BBB',2,'2018-07-02','F',1800);
INSERT INTO members VALUES('CCC',3,'2018-07-03','M',1800);
INSERT INTO members VALUES('DDD',4,sysdate,'M',1800);
--DROP TABLE members;
SELECT 
    m.m_name,
    m.m_num,
    loc.street_address,
    loc.location_id
FROM members m
INNER JOIN locations loc
ON (loc.location_id = m.loca)
ORDER BY m_num ASC;







