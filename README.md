# Data_Industry_Trends_Visualization


<img src="https://img.shields.io/badge/github-181717?style=flat&logo=github&logoColor=white"/> <img src="https://img.shields.io/badge/slack-4A154B?style=flat&logo=slack&logoColor=white"/> <img src="https://img.shields.io/badge/googlecloud-4285F4?style=flat&logo=googlecloud&logoColor=white"/> <img src="https://img.shields.io/badge/powerbi-F2C811?style=flat&logo=powerbi&logoColor=white"/>

## 2팀 2조 채용관련 API를 이용한 데이터 직종 일자리 분석

### 팀원 및 역할

    김창민 : 데이터 GCS 적재 및 자동화 (airflow -dag 활용)
    박경모 : 데이터 GCS 적재 및 자동화 (airflow -dag 활용)
    박정우 : 데이터 GCS 적재 및 자동화 (airflow -dag 활용)
    김태준 : GCP 환경 구축 및 자동화 (GCS, workflow, Bigquery) (airflow -dag 활용)
    임형우 : DB 모델링, 데이터 분석, 대시보드 구축 및 자동화 (airflow -dag 활용)

### 사용 기술
|분야|기술|
|:---:|:---:|
|언어|Python|
|클라우드|docker, airflow, GCP|
|라이브러리|apache-airflow, pandas|
|협업툴|slack, JIRA, Github|
|데이터 API|Saramin API, Google trend API|
|대시보드|Looker|
- - -
### 개요   
사람인에서 재공하는 API와 다른 채용 정보들을 이용하여 현재 데브코스 자체의 의미와 목표인 취업 또는 일자리전망, 유망직종 여부 등의 정보와 추가로 검색량, 자격증 취득 현황 등을 연관관계를 파악할 수 있도록 시각화하여 제공한다.

#### 설정한 지표 목표
- 전체 채용 시장에서 데이터 엔지니어, 데이터 분석가, 데이터 사이언티스트에 대한 채용량의 변화를 시각화
- 각 신입 채용, 채용하는 산업분야, 채용 지역 등의 관점으로 채용량의 변화 파악이 쉽도록 시각화
- 채용정보 외에도 데이터 또는 IT분야에 관련된 구글 검색량, 관련 자격증 응시/취득 여부 데이터를 시간에 따른 시각화

#### 기대 효과
- 시간에 따른 데이터 인력 수요 변화를 이용해 해당 직종에 대한 동향과 이후 전망을 파악할 수 있을 것.
- 원하는 산업분야나 지역에 대해 일자리 공급이 어느정도인지 파악하여 개인의 취업계획에 대해 구체적인 계획을 세우는데 도움을 줄 수 있을 것.
- 검색량에 대한 변화는 개발자가 아닌 일반인들 전체의 관심도를 나타낼 수 있을 것.
- 자격증 데이터는 해당 분야에 대해서 직접적으로 공부를 시작하고, 전문 인력의 수에 대해서 파악할 수 있을 것.
- 이런 [**검색량**, **자격증**, **채용**]. 세 가지 지표를 이용해 연관성을 파악하고 좀 더 유의미한 분석이 가능 할 것으로 예상함.

#### 데이터의 문제점⭐
- 사람인 API를 제외한 다른 API는 개인에게 오픈하지 않거나, 아예 제공되지 않는 경우가 많아 사람인 하나의 데이터로만 진행
- 사람인 채용 데이터의 분포가 17000개 정도의 데이터에서 아래 테이블과 같았으며, 월별로는 23년 5월의 데이터만 12000개로 전체의 70%를 차지하여 시간에 따른 변화를 나타내기에는 부적절한 데이터라고 판단
    - 2023년 데이터로만 한정하여, 모두 현재상태의 지표를 나타내는 것으로 설정함.
    - 이로 인해서 시간에 따른 검색량, 자격증 등의 외부 요인과의 연관성을 도출할 수 없음.

|연도|데이터 수|
|---|---|
|2023|16136|
|2022|937|
|2021|152|
|2020|1|
|2018|1|

- - -
# Workflow
<img src="https://github.com/pjw74/GCP-Job-Board/assets/131341085/5a4b4e90-767a-43dc-94cb-57e90287efcf" width="800" height="500" />

![image](https://github.com/pjw74/Data_Industry_Trends_Visualization/assets/89377440/9a2d7791-3767-472e-a838-ff042d69c2ad)



# ETL 과정

## ETL 서버 생성(Google Compute Engine)

### GCP의 VM instance를 활용, ETL 서버를 생성
Setting
- e2-medium
- debian-11-bullseye-v20230509 사용
- linux 환경에서 진행

### Cronjob으로 스케쥴
![Cronjob 세팅](https://github.com/pjw74/GCP-Job-Board/assets/50907018/f1bf7385-0f82-410c-8571-a5acb6b3afa0)

- linux 시스템인 Cronjob을 활용해서 30분 / 1시간마다 ETL 파이썬 스크립트 진행
- 에러 발생 시의 로그를 로컬에 저장하는 식(외부의 DB로 넘길 수 있도록 변경하면 좋을듯)

### 모니터링
- 스크립트 실패 / 데이터 적재 실패 / 인스턴스 다운 에 대해서 크게 3가지로 분류하고 해당 오류에 대한 예외처리 및 SLACK으로 알림 기능 구현

## 채용공고 API ETL
### DAG
- API to Cloud, Cloud to Cloud DAG 구현
    - 이전에 운영하던 클라우드 서버가 자원 문제로 인스턴스 종료되는 상황 발생
        - 서버에 기록된 데이터, 코드 등 보존을 위해 Storage에 모든 내용을 적재하도록 함
        - 이전에 API를 불러온 시점부터 이후의 데이터를 모두 가져올 수 있는 구조의 DAG 작성
        - 서버에 부하가 걸리지 않게 작업한 내용은 서버 인스턴스에 남기지 않고 API에서 받아온 정보를 바로 Cloud로, Cloud의 정보를 가공한 후 Cloud로 적재하는 DAG 생성
    - 데이터 구조 변경에 반응하기 위한 데이터 추출 코드 수정
        - API를 사용하고 있는 데이터 소스에서 제공하는 데이터의 형태가 변하는 경우를 대비
        - API에서 추출한 원시데이터를 바로 스토리지에 적재하는 DAG, 해당 DAG의 완료 task로부터 trigger를 받아 BigQuery에 적재하기 명확한 CSV형태로 변환하는 DAG 2개로 나누어 ETL 과정 구현
### API to Cloud DAG graph
<img src="https://github.com/pjw74/Data_Industry_Trends_Visualization/assets/131341085/7028c591-84f0-4926-89f1-68f05c0f64aa" width="800" height="150" />

- 한달간 스케줄링 결과 한 시간 동안 채용공고가 올라오지 않는 시간 다수 확인
    - API 호출 시 데이터가 있는지 여부를 우선 확인
    - 없는 경우 slack으로 바로 알림을 보내고 종료
    - 있는 경우 json 형태로 적재
        - 적재 후 json을 csv로 변환하는 DAG를 trigger

### Cloud to Cloud DAG graph
<img src="https://github.com/pjw74/Data_Industry_Trends_Visualization/assets/131341085/c82c798b-298a-4f1f-99c3-226adb2126ff" width="600" height="100" />

- 혼자 동작하지 않고 API to Cloud DAG의 trigger를 받아 동작
- json 데이터를 csv로 변환해서 GCS상에 적재
- 적재 완료 알람이 구현된 부분

### ETL 결과 알림
- Slack web hook을 이용해 알림기능 구현
- callback을 통해 실행 결과를 확인
    - success callback : 추출한 공고가 있는지, 몇개의 공고가 적재되었는지 알림
    - failure callback : 각 task마다 실행 과정에서 에러가 발생했을 때 어떤 부분에 문제가 생겼는지 알림
<img src="https://github.com/pjw74/Data_Industry_Trends_Visualization/assets/131341085/568bccb0-45b9-40ed-8c5a-76b50fef7743" width="500" height="300"/>


## 구글 트렌드 API ETL

DAG
API에서 추출한 원시데이터를 Xcom push 후, 완료 task로부터 trigger,  BigQuery에 Xcom pull하여 tempfile에 저장 후 CSV형태로 변형, 
적재하는 2개의 task로 나누어 ETL 구현

Cloud to Cloud DAG graph

![3차플젝_그래프](https://github.com/pjw74/Data_Industry_Trends_Visualization/assets/70009161/383c98c5-851a-4bf6-a131-db3949a0d3a3)

적재 완료 알람이 구현된 부분
ETL 결과 알림
Slack web hook을 이용해 알림기능 구현

![3차플젝_알람](https://github.com/pjw74/Data_Industry_Trends_Visualization/assets/70009161/d64253b0-3316-43c3-91c2-e00951d1cf3d)

수집에 실패한 키워드 알람

- - - 
# 테이블 모델링
<left>![img1](/query/elt_flow.png)</left>

- **external** : 검증 및 스키마 변경 사항 등 반영한 외부 테이블 스키마
    (csv파일)
    - recruit : csv로 저장된 API 응답 (일정 주기로 스케줄링 되어있음.)
    - recruit : csv로 저장된 구글 트렌드 API 응답 (일정 주기로 스케줄링 되어있고 schema 변경이 자주 일어남)

- **external** : 에러 사항 수정한 외부 테이블 스키마   
    (csv파일)
    - recruit_table : csv로 저장된 API응답
    - google_trend : csv로 저장된 구글 트렌드 API응답
    - certification : csv로 저장된 자격증 

- **meta** : 외부테이블 값에 대한 메타데이터   
    (API명세 내용)
    - education : 채용 학력코드 상세
    - experiences : 채용 경력코드 상세
    - industries : 채용 산업코드 상세 (소분류)
    - industry_categories : 채용 산업코드 상세 (대분류)
    - job_codes : 채용 키워드
    - location : 채용 지역 상세

- **raw_data** : 외부 데이터에서 정제/전처리 한 데이터   
    (external.recruit_table로부터 레코드별로 id부여 후 정규화)
    - certification : 자격증 취득 현황 테이블
    - experiences : 경력코드-경력값 테이블
    - google_trend : 구글 트렌드 검색량 테이블
    - industries : 산업코드-대분류-소분류 테이블
    - job_doce_keywords : 키워드코드-키워드 테이블
    - locations : 지역코드-전체지역-상세지역
    - recruits : 공고명, 학력, 급여조건, 게시일자, 조회수, 지원수

- **analystic** : 분석용 요약 테이블   
    (특정 태그에 맞는 직종별 id단일 컬럼으로 구성된 조인테이블로써 구성)
    - da_ids : 데이터 분석가 id목록
    - datajob_ids : de, da, ds 세 직종을 합치고 중복 제거한 id목록
    - de_ids : 데이터 엔지니어 id목록
    - ds_ids : 데이터 사이언티스트 id목록
    - embedded_ids : 임베디드 개발자 id목록
    - security_ids : 보안계열 id목록
    - web_back_ids : 웹 백엔드 id목록
    - web_front_ids : 웹 프론트엔드 id목록

- **visual_tables** : 대시보드 연동 테이블
    - all_count : 전체 recruit 데이터레코드 갯수
    - area_ratio : 전체지역 별 채용 비율
    - area_ratio_seoul : 서울 지역 내 채용 비율
    - certifications : 연간 자격증 응시자/합격자/합격률
    - data_job_detail_ratio : 데이터직종 내 상세 비율
    - data_job_ratio : 전체 채용 중 데이터직종 비율
    - dev_industry_datajobs : 개발자 채용 산업 계 (대분류), (it전체, de, da, ds 별)
    - dev_industry_first_detail : 위 대분류에서 최상위 산업분야의 상세 내용 (it전체, de, da, ds 별)
    - google_trends : 주간 구글 트렌드 검색량
    - recruit_for_exp : 위 analystic에서 분류된 직종 별 전체, 경력, 신입무관, 신입 채용 수
    - top_datajob_keywords : 데이터직종 채용 키워드 TOP30 (de, da, ds 별)
    - top_keywords : IT전체 채용 키워드 TOP50

- **adhoc** : 임시 스키마   
    (쓰이진 않으나 참고용으로 가능하기에 남겨둠)
    - area_ratio_gyeonggi : 경기도 지역 채용 수
    - area_ratio_gyeonggi_sum : 경기도 지역 채용 수 ('구'별 구분 없이)
    - count_of_month : 수집된 데이터 월간 분포 (전처리 이후)
    - count_of_year : 수집된 데이터 연간 분포 (전처리 이후)

# ELT 과정

## ELT flow
1. GCS 내 적재되는 데이터 중 일부는 스케줄링 되어 매번 적재되고 일부는 데이터셋 전체로 적재
2. GCS -> Bigquery 과정에서 staging 테이블을 생성해 다음과 같은 task grid 작성
![image](https://github.com/pjw74/Data_Industry_Trends_Visualization/assets/89377440/e470d6b2-941c-4831-b933-d65987996cf5)
3. 해당 task (check_table명)을 통해 query로 2차 검증을 거쳐 Bigquery-external로 적재되는 데이터 체크

- 기존 cloud function 활용한 schedule -> schedule_interval 처리
- GCSToBigQueryOperator, BigQueryOperator, BigQueryCheckOperator 등 활용해 data flow 생성 및 validation 진행
- create, check task 실행 시 sql문으로 validation
### ELT 결과 알림
- slack webhook token, email 활용해 각 태스크 별 성공/실패 여부 확인
- 매 3시간 마다 checking 하여 작업 확인




- - -
# 대시보드
