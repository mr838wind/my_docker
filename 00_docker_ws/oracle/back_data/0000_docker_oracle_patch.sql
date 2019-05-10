/*
db 변경 된것
*/
------------------------------------------------------------------------------------
-- select * from MTHSD_ACC_LOG

-- ORA-00904: "XX1"."DEC_VARCHAR2_SEL": invalid identifier

CREATE OR REPLACE PACKAGE XX1 AS
        FUNCTION DEC_VARCHAR2_SEL (p1 VARCHAR2, p2 NUMBER, p3  VARCHAR2) RETURN VARCHAR2;
END XX1;

CREATE OR REPLACE PACKAGE BODY XX1 AS
	FUNCTION DEC_VARCHAR2_SEL (p1 VARCHAR2, p2 NUMBER, p3  VARCHAR2)
		RETURN VARCHAR2
	IS
	BEGIN
		return p1;
	END;
END XX1;

--cust_id
-- select * from mtmbd_customer where cust_id = 'C91496660'
-- select t.*, xx1.DEC_VARCHAR2_SEL(t.card_number,10, 'CARD') from MTMBD_PRIV_CUSTOMER t where fk_cust_id = 'C91496660'
-- SELECT /*+ selectCardNumber */ FK_CUST_ID AS custId , XX1.DEC_VARCHAR2_SEL(CARD_NUMBER, 10,'CARD') AS cardNumber FROM MTMBD_PRIV_CUSTOMER WHERE FK_CUST_ID = 'C91496660'

commit;

------------------------------------------------------------------------------------
/*  이벤트 관련 */


/* user */
-- Insert into MTMBD_CUSTOMER (CUST_ID,FK_CUST_LV_CD,FK_STR_CODE,AGREE_MARKETING,AGREE_LOCATION,AGREE_3RD_PART,DEVICE_TOKEN,DEVICE_TYPE_CD,DEVICE_MODEL,DEVICE_OS,REG_DT,LAST_LOGIN_DT,STORE_SETTING_YN,APP_DOWNLOAD_YN,PUSH_SETTING_YN,CHG_DT,CHG_STORE_DT,FROM_SIMPLE_LOGIN,DEVICE_ID,AGREE_BCON_LOCATION,IS_OFFICER,CPN_AUTO_YN,PAPERLESS_RECEIPT_YN,TMS_UUID,CHG_TMS_UUID_DT,LAST_LOGIN_APP_DT,LAST_LOGIN_APP_VER) values ('C91496660',null,'2004','1','1','1',null,'A','LG-F400S','6.0',to_date('17/02/03','RR/MM/DD'),to_date('17/02/06','RR/MM/DD'),'1','1','0',to_date('16/08/25','RR/MM/DD'),to_date('16/08/02','RR/MM/DD'),'0','5c502ba8-6ac7-498a-bb52-b7fa1bc816c2','1','0','1','0',null,null,null,null);
-- Insert into DEVPRMOWNER.MTMBD_PRIV_CUSTOMER (FK_CUST_ID,CARD_NUMBER,CARD_NUMBER_SSG) values ('C91496660','93501302461917810900',null);
-- update MTMBD_PRIV_CUSTOMER set CARD_NUMBER = '93501302461917810900' where  fk_cust_id = 'C91496660'

/* event */
-- select * from mtevd_event where event_code = 'E0010050166'


insert into mtevd_event
(EVENT_CODE,START_DT,END_DT,EVENT_NM,EVENT_TYPE_CD,USE_YN,CONDITION_YN,IMAGE,WIN_ASSIGN_CD,CRTN_DT,CRTN_ID,CHG_DT,CHG_ID,WINNING_CONTENTS_YN,USE_TEMPLATE_YN,CONTETNS_IMAGE_ALT,WON_START_DT,WON_END_DT,WON_USE_YN,CPN_AUTO_YN)
select
'E0010050166'
,to_date('2019.03.19 00:00:00', 'yyyy.mm.dd. hh24:mi:ss')
,to_date('2019.04.17 23:59:00', 'yyyy.mm.dd. hh24:mi:ss')
,'무럭무럭 나무 키우기'
,'E001005'
,'0'
,'0'
,'/images/ws-upload/up/521f1d52-d95d-47d1-a474-6f54e73cce0b.jpg'
,'E003001'
,to_date('2019.03.19 16:24:10', 'yyyy.mm.dd. hh24:mi:ss')
,'FAS00117'
,to_date('2019.03.19 17:36:43', 'yyyy.mm.dd. hh24:mi:ss')
,'FAS00117'
,'0'
,'0'
,'/event/goGrowTree1904.do'
,to_date('2019.04.18 00:00:00', 'yyyy.mm.dd. hh24:mi:ss')
,to_date('2019.06.02 23:59:00', 'yyyy.mm.dd. hh24:mi:ss')
,'0'
,'1'
from dual
where not exists (
  select * from mtevd_event where event_code = 'E0010050166'
)
;

commit;
