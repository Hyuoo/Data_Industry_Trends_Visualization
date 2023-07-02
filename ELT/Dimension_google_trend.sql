
DROP TABLE IF EXISTS job-posting-api-388303.external.google_trend;
CREATE TABLE job-posting-api-388303.external.google_trend AS
    SELECT 
        date as Date,
        info as 정보처리,
        ai as 인공지능,
        bigdata as 빅데이터,
        boj as 백준,
        /*programmers as 프로그래머스,*/
        bootcamp as 부트캠프,
        db as 데이터베이스,
        dm as 데이터 마이닝,
        clustering as 클러스터링,
        de as 데이터 엔지니어,
        da as 데이터 분석가,
        ds as 데이터 사이언티스트
    FROM job-posting-api-388303.staging.google_trend;
