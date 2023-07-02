DROP TABLE IF EXISTS core.recruit;
CREATE TABLE IF NOT EXISTS core.recruit AS
(
  WITH 
  recruit AS (SELECT id, title, posting_date, read_cnt, apply_cnt FROM raw_data.recruits),
  experiences AS (SELECT id, exp_name, exp_min, exp_max FROM raw_data.experiences),
  industries AS (SELECT id, industry_category, industry FROM raw_data.industries),
  locations AS (SELECT id, wide_location, (CASE WHEN location_name=wide_location THEN '미분류' ELSE location_name END) as location_name FROM raw_data.locations),
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
    END
  ) as tag
  FROM raw_data.job_code_keywords)

  SELECT *
  FROM 
    recruit
    JOIN experiences USING(id)
    JOIN industries USING(id)
    JOIN locations USING(id)
    JOIN job_code_keywords USING(id)
);


DROP TABLE IF EXISTS core.datajob;
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


DROP TABLE IF EXISTS core.certification;
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
  FROM raw_data.certification
);


DROP TABLE IF EXISTS core.google_trend;
CREATE TABLE IF NOT EXISTS core.google_trend AS
(
  SELECT date, '정보처리' as kw, info_proc as count FROM raw_data.google_trend
  UNION ALL
  SELECT date, '인공지능' as kw, ai FROM raw_data.google_trend
  UNION ALL
  SELECT date, '빅데이터' as kw, bigdata  FROM raw_data.google_trend
  UNION ALL
  SELECT date, '백준' as kw, boj FROM raw_data.google_trend
  UNION ALL
  SELECT date, '데이터엔지니어' as kw, de  FROM raw_data.google_trend
  UNION ALL
  SELECT date, '데이터분석가' as kw, da  FROM raw_data.google_trend
  UNION ALL
  SELECT date, '데이터사이언티스트' as kw, ds  FROM raw_data.google_trend
);

