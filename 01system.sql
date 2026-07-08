-- 1. 테이블스페이스 생성하기
-- 저장공간이름 first01.dbf 사이즈 10M 공간확보
create tablespace firstData
datafile 'C:\ocaclexe\oradata\XE\first01.dbf' size 10M;

-- 저장공간추가(수정)
alter tablespace firstData
add datafile 'C:\ocaclexe\oradata\XE\first02.dbf' size 10M;

-- 저장공간사이즈 수정
alter database
datafile 'C:\ocaclexe\oradata\XE\first02.dbf' resize 20M;

-- 저장공간삭제
drop tablespace firstData including contents and datafiles;

-- 저장공간 자동설정(first01.dbf)
-- 기존용량이 부족하면 1M 증가시키고, 최대 20M 가능함
alter database
datafile 'C:\ocaclexe\oradata\XE\first01.dbf'
AUTOEXTEND on
next 1M
MAXSIZE 20M;

-- 2.사용자 설정(아이디: javauser,pw: javauser, tablespace: firstData)
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

create user javauser IDENTIFIED by javauser
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp;

-- 3.사용자 권한설정(javauser에게 접속권한, 테이블 curd기능부여)
GRANT CONNECT, RESOURCE, dba to javauser;

-- 4.접속요청을 진행하면된다.








