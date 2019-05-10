/**
my custom procedure, function for event develop
chhan
*/


/* >>>>>>>>>>>>>>> define >>>>>>>>>>>>>>>>>>>>>>>  */
define e_c = 'E0010050176'
define c_i = 'C91496660'
-- define c_i ='C83725213'
-- define c_i = 'C69776541'
-- define c_i = 'C20080866'


select '&c_i' as ci, '&e_c' as ec from dual



/*

exec my_clear_all('&e_c');

exec my_clear_all('&e_c', 'C91496660');


select my_ycoin('&c_i') from dual;

*/
-----


/* >>>>>>>>>>>>>>> clear all >>>>>>>>>>>>>>>>>>>>>>>  */
CREATE OR REPLACE PROCEDURE my_clear_all
    ( e_c  IN evhsd_cust_collect.fk_event_code%TYPE
      ,c_i IN evhsd_cust_collect.fk_cust_id%TYPE := ''
    )
IS
  query varchar2(4000);
  q_ci varchar2(100);
  q_v_ec varchar2(100);
BEGIN
-- '' means escape '
----------------
    q_v_ec := ' '''||e_c||''' ';

    if c_i is null then
      q_ci := ' ';
    else
      q_ci := ' and fk_cust_id = ''' ||c_i|| ''' ';
    end if;

    query := 'delete from evhsd_cust_mission where fk_event_code = '||q_v_ec|| q_ci;
    EXECUTE IMMEDIATE query;

    query := 'delete from evhsd_cust_collect where fk_event_code = '||q_v_ec|| q_ci;
    EXECUTE IMMEDIATE query;

    query := 'delete from evhsd_cust_history where fk_event_code = '||q_v_ec|| q_ci;
    EXECUTE IMMEDIATE query;

    query := 'delete from evhsd_cust_ticket where fk_event_code = '||q_v_ec|| q_ci;
    EXECUTE IMMEDIATE query;

    query := 'delete from lfptd_cust_history where event_code = '||q_v_ec|| q_ci;
    EXECUTE IMMEDIATE query;

    query := 'delete  from evhsd_cust_share where fk_event_code = '||q_v_ec|| q_ci;
    EXECUTE IMMEDIATE query;

    --add
    query := 'delete  from MBCPD_CUST_STAMP where fk_event_code = '||q_v_ec|| q_ci;
    EXECUTE IMMEDIATE query;

    --coupon:
    query := 'delete  from MMS_CUST_MST_PRM where fk_event_code = '||q_v_ec|| q_ci;
    EXECUTE IMMEDIATE query;

    --coupon:
    query := 'delete  from MBCPD_EVT_COUPON where EVENT_CODE = '||q_v_ec|| q_ci;
    EXECUTE IMMEDIATE query;

    ---- maybe not use
    query := 'delete  from EVHSD_CUST_ACTION where fk_event_code = '||q_v_ec|| q_ci;
    EXECUTE IMMEDIATE query;

    query := 'delete  from evhsd_marble_history where fk_event_code = '||q_v_ec|| q_ci;
    EXECUTE IMMEDIATE query;

    query := 'delete  from EVFGD_CUST_HISTORY where fk_event_code = '||q_v_ec|| q_ci;
    EXECUTE IMMEDIATE query;

    query := 'delete  from MTEVD_RECO_EVENT where fk_event_code = '||q_v_ec|| q_ci;
    EXECUTE IMMEDIATE query;

    dbms_output.put_line('>>> done.');

    commit;
----------------
END ;

-- 실행:
-- exec my_clear_all('&e_c', '&c_i');

-- exec my_clear_all('&e_c');



/* >>>>>>>>>>>>>>> yellow coin >>>>>>>>>>>>>>>>>>>>>>>  */
-- yellow coin
CREATE OR REPLACE function my_ycoin
    (
      c_i IN evhsd_cust_collect.fk_cust_id%TYPE := ''
    )
RETURN number
IS
  ycoin number;
BEGIN
  select
  (SELECT
          NVL(SUM(A.COUNT), 0)
        FROM
          LFPTD_CUST_HISTORY A
        WHERE
          A.FK_CUST_ID    = c_i
          AND A.USE_YN    =0
          AND A.ENABLED_YN=1
          AND SYSDATE BETWEEN ADD_MONTHS(A.AVAIL_DT, -3) + 1/(24*60*60) AND A.AVAIL_DT
  )
  -
  (
          SELECT
          NVL(SUM(B.COUNT), 0)
        FROM
          LFPTD_CUST_HISTORY B
        WHERE
          B.FK_CUST_ID    = c_i
          AND B.USE_YN    =1
          AND B.ENABLED_YN=1
          AND SYSDATE BETWEEN ADD_MONTHS(B.AVAIL_DT, -3) + 1/(24*60*60) AND B.AVAIL_DT
  ) as yellow_coin
  into ycoin
  from dual;

  return (ycoin);
END;



select my_ycoin('&c_i') from dual;

select * from LFPTD_CUST_HISTORY where FK_CUST_ID    ='&c_i'
--and event_code='TTT'
order by taking_dt desc


-- delete from LFPTD_CUST_HISTORY where FK_CUST_ID    ='&c_i' and event_code='TTT'

-- commit;

/* ---yellow coin

insert into LFPTD_CUST_HISTORY
(fk_cust_id, use_yn, taking_cd, count, avail_dt, taking_dt, event_code, enabled_yn, comments)
values
('&c_i', 0, 'L001007', 600, to_date('20190630235959','yyyymmddhh24miss'), sysdate, 'TTT', 1, 'test data');

delete from LFPTD_CUST_HISTORY where fk_cust_id = '&c_i';

commit;
*/




/* 신규 가입 초기화 */
/*

UPDATE MTMBD_CUSTOMER SET
        REG_DT = SYSDATE
    , STORE_SETTING_YN = '0'
    , agree_marketing = '0'
    , CHG_STORE_DT = null
    , FK_STR_CODE = null
WHERE CUST_ID = '&c_i';

*/













