DROP TABLE IF EXISTS job-posting-api-388303.external.recruit;
CREATE TABLE job-posting-api-388303.external.recruit AS 
    SELECT 
        position_title,
        position_industry,
        position_location,
        position_job_type,
        position_job_mid_code,
        position_industry_keyword_code,
        position_job_code_keyword_code,
        position_experience_level_code,
        position_experience_level_min,
        position_experience_level_max,
        position_required_education_level,
        keyword,
        salary,
        position_timestamp,
        position_date,
        expiration_timestamp,
        expiration_date,
        read_cnt,
        apply_cnt
    FROM job-posting-api-388303.staging.recruit;

