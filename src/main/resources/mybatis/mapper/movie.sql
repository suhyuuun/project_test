
-- 회원 정보 테이블
CREATE TABLE ugotfilm_user(
    usercode number,
    id varchar2(100),
    password varchar2(100),
    nickname varchar2(100),
    joindate Date,
    gender varchar2(10),
    birth number,
    authRole varchar2(20)
);

-- 회원 유저코드 시퀀스
CREATE SEQUENCE ugotfilm_user_usercode_seq START with 1 increment by 1 nocache nocycle;

-- 유저가 선택한 영화 기록
CREATE TABLE ugotfilm_choice(
    usercode number,
    moviecode number,
    choicedate date
);

-- 영화 정보 저장 테이블
CREATE TABLE ugotfilm_movie(
    moviecode number,
    title varchar2(100),
    overview varchar2(1000),
    release_date date,
    vote_average varchar2(100),
    genre_ids varchar2(100),
    poster_url varchar2(100)

);

-- 인물 정보 저장 테이블
CREATE TABLE ugotfilm_person(
    personcode number,       -- id
    name varchar2(100),     -- name
    job varchar2(1000),     -- known_for_department
    profile_path varchar2(200) -- profile_path

);

-- 영화 정보 샘플
insert INTO ugotfilm_movie VALUES (1, '테스트1', '1번영화 내용', sysdate, 4.5, '판타지', '포스터 경로');
insert INTO ugotfilm_movie VALUES (2, '테스트2', '2번영화 내용', sysdate, 4.0, '멜로', '포스터 경로2');
insert INTO ugotfilm_movie VALUES (3, '테스트3', '3번영화 내용', sysdate, 4.3, '다큐', '포스터 경로3');
insert INTO ugotfilm_movie VALUES (4, '테스트3', '3번영화 내용', sysdate, 4.3, '다큐', '포스터 경로3');

commit;

select * from ugotfilm_movie;

-- 회원 정보 샘플
insert INTO ugotfilm_user VALUES (1, 'user1', '0000', '유저1', sysdate, '남', 2000);
insert INTO ugotfilm_user VALUES (2, 'user2', '0000', '유저2', sysdate, '여', 1990);
insert INTO ugotfilm_user VALUES (3, 'user3', '0000', '유저3', sysdate, '남', 2010);
commit;

select * from ugotfilm_user;

-- 선택 정보 샘플
insert INTO ugotfilm_choice VALUES (1, 1, sysdate);
insert INTO ugotfilm_choice VALUES (1, 2, sysdate);
insert INTO ugotfilm_choice VALUES (2, 3, sysdate);

commit;

select * from ugotfilm_choice;


-- 다양한 기준의 정보
--1번 유저가 가장 선호하는 영화 장르
select genre_ids, count(genre_ids)from (select * from (select u.*, m.*, c.choicedate from ugotfilm_choice c
left join ugotfilm_user u on u.usercode=c.usercode
left join ugotfilm_movie m on m.moviecode=c.moviecode) where usercode=1) group by genre_ids order by genre_ids desc;

-- 2번 유저가 클릭한 영화 리스트
select * from (select u.*, m.*, c.choicedate from ugotfilm_choice c
left join ugotfilm_user u on u.usercode=c.usercode
left join ugotfilm_movie m on m.moviecode=c.moviecode) where usercode=2;


-- 유저1이 가장 많이 확인한 영화 제목 및 클릭수
select title, count(title) from (select u.usercode, u.id, u.nickname, m.title from ugotfilm_choice c
left join ugotfilm_user u on u.usercode=c.usercode
left join ugotfilm_movie m on m.moviecode=c.moviecode)where usercode=1 group by title order by count(title) desc;

--유저1의 장르별 선호도
select genre_ids, count(genre_ids)from (select * from (select u.*, m.*, c.choicedate from ugotfilm_choice c
left join ugotfilm_user u on u.usercode=c.usercode
left join ugotfilm_movie m on m.moviecode=c.moviecode) where usercode=1) group by genre_ids order by genre_ids desc;

--유저의 정보로도 구분하여 클릭수 정보를 group by 하여 가져올 수 있음

select m.title,  r.* from (select moviecode, count(moviecode) from ugotfilm_choice c group by moviecode)r 
left join ugotfilm_movie m on r.moviecode=m.moviecode;

select moviecode, count(moviecode) from ugotfilm_choice c group by moviecode;