
--tablespace
CREATE TABLESPACE TS_PR_DATA
DATAFILE 'TS_PR_DATA.dbf'
SIZE 100M
AUTOEXTEND ON NEXT 10M;


--user:
CREATE USER DEVPRMOWNER IDENTIFIED BY devprmowner
DEFAULT TABLESPACE TS_PR_DATA
QUOTA UNLIMITED ON TS_PR_DATA
TEMPORARY TABLESPACE TEMP;

GRANT CONNECT, RESOURCE TO DEVPRMOWNER;

GRANT CREATE SESSION GRANT ANY PRIVILEGE TO DEVPRMOWNER;

GRANT UNLIMITED TABLESPACE TO DEVPRMOWNER;

--��Ÿ function

/* ���� ����, todo debug: 
--- package:

CREATE OR REPLACE PACKAGE DEVPRMOWNER.XX1 AS
        -- 
        FUNCTION DEC_VARCHAR2_SEL (p1 VARCHAR2, p2 NUMBER, p3  VARCHAR2) RETURN VARCHAR2;
END XX1;

CREATE OR REPLACE PACKAGE BODY DEVPRMOWNER.XX1 AS
    -- 
	FUNCTION DEC_VARCHAR2_SEL (p1 VARCHAR2, p2 NUMBER, p3  VARCHAR2) 
		RETURN VARCHAR2 
	IS 
	BEGIN 
		return p1;
	END;
END XX1;
*/