DROP TABLE IF EXISTS core.job_types;
DROP TABLE IF EXISTS core.origin;
DROP TABLE IF EXISTS core.industries;
DROP TABLE IF EXISTS core.job_code_keywords;
DROP TABLE IF EXISTS core.locations;
DROP TABLE IF EXISTS core.experiences;
DROP TABLE IF EXISTS core.recruits;
DROP TABLE IF EXISTS core.recruit;
DROP TABLE IF EXISTS core.datajob;
DROP TABLE IF EXISTS core.certification;
DROP TABLE IF EXISTS core.google_trend;


CREATE TABLE IF NOT EXISTS core.job_types AS 
(
  WITH origin as (SELECT ROW_NUMBER() OVER (ORDER BY posting_date, position_title) id, * FROM external.recruit_table),
  job_code_split as (SELECT id, SPLIT(position_job_type,',') as code_split from origin)

  SELECT DISTINCT id
  FROM job_code_split
  CROSS JOIN UNNEST(job_code_split.code_split) as code
  WHERE code='1'
);


-- 임시 origin 테이블
CREATE TABLE IF NOT EXISTS core.origin AS
(
  SELECT a.*
  FROM (SELECT ROW_NUMBER() OVER (ORDER BY posting_date, position_title) id, * FROM external.recruit_table) as a
  JOIN core.job_types as b
  ON a.id=b.id
);
-- 생성 이후 job_types 필요 없음.
DROP TABLE IF EXISTS core.job_types;


-- -- position_industry 다중값 분리
CREATE TABLE IF NOT EXISTS core.industries AS
(
  WITH job_code_split as (SELECT id, SPLIT(position_industry,',') as code_split from core.origin),
  industries as (
    SELECT
      code,
      industry_category,
      industry
    FROM meta.industries as a
    JOIN meta.industry_categories as b
    ON a.super_code=b.super_code
    )

  SELECT id, a.code, industry_category, industry
  FROM (
    SELECT id, code
    FROM job_code_split
    CROSS JOIN UNNEST(job_code_split.code_split) as code
    ) as a
  JOIN industries as b
  ON a.code=b.code
  GROUP BY 1,2,3,4
);


-- -- position_location 다중값 분리
CREATE TABLE IF NOT EXISTS core.locations AS 
(
  WITH job_code_split as (SELECT id, SPLIT(position_location,',') as code_split from core.origin),
  locations as (
    SELECT
      a.local_code as local_code,
      b.location_name as wide_location,
      a.location_name as location_name
    FROM meta.location as a
    JOIN meta.location as b
    ON a.wide_code=b.local_code
    )

  SELECT id, a.code, b.wide_location, b.location_name
  FROM (
    SELECT id, code
    FROM job_code_split
    CROSS JOIN UNNEST(job_code_split.code_split) as code
    ) as a
  JOIN locations as b
  ON a.code=b.local_code
  GROUP BY 1,2,3,4
);


-- position_job_code_keyword_code 다중값 분리
CREATE TABLE IF NOT EXISTS core.job_code_keywords AS
(
  WITH job_code_split as (SELECT id, SPLIT(position_job_code_keyword_code,',') as code_split from core.origin)

  SELECT id, a.code, job_name
  FROM (
    SELECT id, code
    FROM job_code_split
    CROSS JOIN UNNEST(job_code_split.code_split) as code
    ) as a
  JOIN meta.job_codes as b
  ON a.code=b.job_code
  GROUP BY 1,2,3
);


-- experience_table
CREATE TABLE IF NOT EXISTS core.experiences AS 
(
  SELECT 
    a.id as id,
    a.position_experience_level_code as exp_code,
    b.experience as exp_name,
    a.position_experience_level_min as exp_min,
    a.position_experience_level_max as exp_max
  FROM core.origin as a
  JOIN meta.experiences as b
  ON a.position_experience_level_code=b.code
);


-- recruits 테이블 생성
CREATE TABLE IF NOT EXISTS core.recruits AS 
(
  SELECT
    id,
    position_title as title,
    position_required_education_level as education_level,
    salary,
    LEFT(posting_date,10) as posting_date,
    LEFT(expiration_date,10) as expiration_date,
    read_cnt,
    apply_cnt
  FROM core.origin
  WHERE LEFT(posting_date,4)='2023'
);


CREATE TABLE IF NOT EXISTS core.recruit AS
(
  WITH 
  recruit AS (SELECT id, title, posting_date, read_cnt, apply_cnt FROM core.recruits),
  experiences AS (SELECT id, exp_name, exp_min, exp_max FROM core.experiences),
  industries AS (SELECT id, industry_category, industry FROM core.industries),
  locations AS (SELECT id, wide_location, (CASE WHEN location_name=wide_location THEN '미분류' ELSE location_name END) as location_name FROM core.locations),
  job_code_keywords AS (SELECT id, job_name,
  (
    CASE
      WHEN job_name LIKE '데이터엔지니어' THEN '데이터엔지니어'
      WHEN job_name LIKE 'ETL' THEN '데이터엔지니어'
      WHEN job_name LIKE '데이터분석가' THEN '데이터분석가'
      WHEN job_name LIKE '데이터시각화' THEN '데이터분석가'
      WHEN job_name LIKE '%러닝' THEN '데이터사이언티스트'
      WHEN job_name LIKE '%인공%' THEN '데이터사이언티스트'
      WHEN job_name LIKE '프론트%' THEN '프론트엔드'
      WHEN job_name LIKE '백엔드%' THEN '백엔드'
      WHEN job_name LIKE '임베디드' THEN '임베디드'
      WHEN job_name LIKE '펌웨어' THEN '임베디드'
      WHEN job_name LIKE '%보안%' THEN '보안'
      WHEN job_name LIKE '게임개발' THEN '게임개발'
      WHEN job_name LIKE 'unreal' THEN '게임개발'
    END
  ) as tag
  FROM core.job_code_keywords)

  SELECT *
  FROM 
    recruit
    JOIN experiences USING(id)
    JOIN industries USING(id)
    JOIN locations USING(id)
    JOIN job_code_keywords USING(id)
);


-- 임시 테이블삭제
DROP TABLE IF EXISTS core.origin;
DROP TABLE IF EXISTS core.industries;
DROP TABLE IF EXISTS core.locations;
DROP TABLE IF EXISTS core.job_code_keywords;
DROP TABLE IF EXISTS core.experiences;
DROP TABLE IF EXISTS core.recruits;
--

CREATE TABLE IF NOT EXISTS core.datajob AS
(
  SELECT *
  FROM
  (
    (SELECT
      id, title, posting_date, read_cnt, apply_cnt
      , exp_name, exp_min, exp_max
      , industry_category, industry
      , wide_location, location_name
      , job_name, ('데이터엔지니어') as tag
    FROM core.recruit
    WHERE id IN (SELECT id FROM core.recruit WHERE tag LIKE '데이터엔지니어'))
    UNION ALL
    (SELECT
      id, title, posting_date, read_cnt, apply_cnt
      , exp_name, exp_min, exp_max
      , industry_category, industry
      , wide_location, location_name
      , job_name, ('데이터분석가') as tag
    FROM core.recruit
    WHERE id IN (SELECT id FROM core.recruit WHERE tag LIKE '데이터분석가'))
    UNION ALL
    (SELECT
      id, title, posting_date, read_cnt, apply_cnt
      , exp_name, exp_min, exp_max
      , industry_category, industry
      , wide_location, location_name
      , job_name, ('데이터사이언티스트') as tag
    FROM core.recruit
    WHERE id IN (SELECT id FROM core.recruit WHERE tag LIKE '데이터사이언티스트'))
  )
);

-- 깨진 컬럼명으로 와서 스키마 생성 후 데이터적재
CREATE TABLE IF NOT EXISTS core.certification_tmp(
  test_name STRING,
  test_year INTEGER,
  cert_type STRING,
  take INTEGER,
  pass INTEGER,
  pass_ratio FLOAT64
) AS SELECT * FROM external.certification;

CREATE TABLE IF NOT EXISTS core.certification AS
(
  SELECT test_year,
  test_name || ' ' || (
    CASE
      WHEN STRPOS(cert_type, '(')<>0 THEN RTRIM(SUBSTR(cert_type,0,STRPOS(cert_type,'(')-1))
      ELSE cert_type
    END
  ) as cert_name,
  take, pass, ROUND((pass/take)*100,2) as pass_ratio
  FROM core.certification_tmp
);
DROP TABLE IF EXISTS core.certification_tmp;


-- 깨진 컬럼명으로 와서 스키마 생성 후 데이터적재
CREATE TABLE IF NOT EXISTS core.google_trend_tmp(
  date DATE,
  info_proc INTEGER,
  ai INTEGER,
  bigdata INTEGER,
  boj INTEGER,
  boot_camp INTEGER,
  db INTEGER,
  d_mining INTEGER,
  clust INTEGER,
  de INTEGER,
  da INTEGER,
  ds INTEGER
) AS SELECT * FROM external.google_trend_V2;

CREATE TABLE IF NOT EXISTS core.google_trend AS
(
  SELECT date, '정보처리' as kw, info_proc as count FROM core.google_trend_tmp
  UNION ALL
  SELECT date, '인공지능' as kw, ai FROM core.google_trend_tmp
  UNION ALL
  SELECT date, '빅데이터' as kw, bigdata  FROM core.google_trend_tmp
  UNION ALL
  SELECT date, '백준' as kw, boj FROM core.google_trend_tmp
  UNION ALL
  SELECT date, '데이터엔지니어' as kw, de  FROM core.google_trend_tmp
  UNION ALL
  SELECT date, '데이터분석가' as kw, da  FROM core.google_trend_tmp
  UNION ALL
  SELECT date, '데이터사이언티스트' as kw, ds  FROM core.google_trend_tmp
);
DROP TABLE IF EXISTS core.google_trend_tmp;
