/*
출첵
*/

/* >>>>>>>>>>>>>>> define >>>>>>>>>>>>>>>>>>>>>>>  */
-- E0010050164  -- 출첵
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

/* >>>>>>>>>>>>>>> basic >>>>>>>>>>>>>>>>>>>>>>>  */
--이벤트
select * from mtevd_event where event_code = '&e_c'
--and fk_cust_id = '&c_i'


select * from evhsd_cust_collect where fk_event_code = '&e_c'
--and fk_cust_id = '&c_i'
order by seq desc

--
select * from evhsd_cust_mission where fk_event_code = '&e_c'
--and fk_cust_id = '&c_i'
order by seq desc


select * from evhsd_cust_history where fk_event_code = '&e_c'
order by seq desc

--경품
select * from evhsd_cust_ticket where fk_event_code = '&e_c'
--and fk_cust_id = '&c_i'
order by seq desc

--yellow coin
select * from  lfptd_cust_history where event_code = '&e_c'
--and fk_cust_id = '&c_i'
--order by use_yn,taking_dt desc
order by taking_dt desc

--공유
select * from evhsd_cust_share where fk_event_code = '&e_c'
--and fk_cust_id = '&c_i'

-- stamp
select * from MBCPD_CUST_STAMP where fk_event_code = '&e_c'

-- coupon
select * from MMS_CUST_MST_PRM where fk_event_code = '&e_c'

-- coupon
select * from MBCPD_EVT_COUPON where EVENT_CODE = '&e_c'



--- others:
-- L001002 이벤트 당첨
-- L001003 이벤트 참여
select * from mtcdd_codes where code like 'L%'





--공유하기 test data
/*
insert into evhsd_cust_share (seq, fk_cust_id, fk_event_code, share_type, share_url, crtn_date, crtn_dt)
values (seq_evhsd_cust_share.nextval, '&c_i', '&e_c', 'KK', '/event/goGawiBawiBo1901.do', '20190107', sysdate);

commit;
*/

/*
--이벤트 날짜 변경:

select to_date('20190304'||'000000','yyyymmddhh24miss') as a from dual;

select to_date('20190314'||'235959','yyyymmddhh24miss') as a from dual;

select * from mtevd_event where event_code = 'E0010050128';

update mtevd_event
set start_dt = to_date('20180901'||'000000','yyyymmddhh24miss')
   ,end_dt = to_date('20180914'||'235959','yyyymmddhh24miss')
where  event_code = 'E0010050128';

commit;

*/


/* 어제 기록으로 바꿔줌  */
select * from evhsd_cust_mission where fk_event_code = '&e_c'

select * from evhsd_cust_collect where fk_event_code = '&e_c' and crtn_date = '20190117'

select * from evhsd_cust_collect where fk_event_code = '&e_c'
--and seq = 6022
order by seq desc

/*
update evhsd_cust_mission
set crtn_date = '20190116'
 ,crtn_dt = crtn_dt -1
 ,chg_date = '20190116'
 ,chg_dt = chg_dt -1
where fk_event_code = '&e_c' and crtn_date = '20190117';

update evhsd_cust_collect
set crtn_date = '20190129'
 ,crtn_dt = crtn_dt -1
 ,chg_date = '20190129'
 ,chg_dt = chg_dt -1
where fk_event_code = '&e_c' and crtn_date = '20190130';

-- delete from evhsd_cust_collect where seq = 6022

commit;
*/





/* >>>>>>>>>>>>>>> other test >>>>>>>>>>>>>>>>>>>>>>>  */
/*
--누적 test:

insert into evhsd_cust_collect ( seq, fk_cust_id, fk_event_code, collection_id, collection_name, collection_path, quantity, refer_id, status, crtn_date, crtn_dt, chg_date, chg_dt)
values (seq_evhsd_cust_collect.nextval, '&c_i', '&e_c', 'SN_APPLY_COIN', '동글동글 꼬마 눈사람', 5, 1, '{"status":"C","level":"1","score":"0"}', '00', '20181203', sysdate, '20181203', sysdate)

--SN_APPLY_FREE, SN_APPLY_COIN
*/

-- commit;

/*
--날짜 변경
update evhsd_cust_ticket
set crtn_date = '20181202'
,crtn_dt = sysdate -1
--,chg_date = '20181202'
--,chg_dt = sysdate -1

*/


/* 경품 test */
--경품 test
select * from evhsd_cust_collect where fk_event_code = '&e_c'
and status = '01'
order by seq desc

--경품
select * from evhsd_cust_ticket where fk_event_code = '&e_c'

/*
--clear
delete from evhsd_cust_collect where fk_event_code = '&e_c'
and status = '01';

--경품
delete from evhsd_cust_ticket where fk_event_code = '&e_c';

commit;
*/


/*
--
delete from evhsd_cust_collect where fk_event_code = '&e_c'
and seq >= 2995

update evhsd_cust_collect
set chg_dt = to_date('2018.09.03 10:00:00','yyyy.mm.dd hh24:mi:ss')
where seq = 3228

*/






/* selectTop100ForFindGiftBox */
select * from (
		      SELECT
		         T1.FK_CUST_ID
		       , ROW_NUMBER() OVER (ORDER BY T1.CNT DESC) AS MY_RANK
		       , CNT                                      AS CNT
		      FROM
		         (
		            SELECT
		               FK_CUST_ID
		             , COUNT(*) AS CNT
		            FROM
		               EVHSD_CUST_COLLECT
		            WHERE
		               FK_EVENT_CODE     =  '&e_c'
		               AND STATUS        = '00'
		               AND REFER_ID   LIKE '{"status":"C","level":"3"%'
		            GROUP BY
		               FK_CUST_ID
		         )
		         T1
)
where my_rank <= 50
order by MY_RANK



























