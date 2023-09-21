
-- lower(소문자), initcap(앞글자만 대문자), upper(대문자)

SELECT * FROM dual;

/*
dual이라는 테이블은 sys가 소유하는 오라클의 표준 테이블로서,
오직 한 행에 한 컬럼만 담고 있는 dummy 테이블 입니다.
일시적인 산술 연산이나 날짜 연산 등에 주로 사용합니다.
모든 사용자가 접근할 수 있습니다.
*/

SELECT
    'abcDEF', lower('abcDEF'), upper('abcDEF')
FROM
    dual;



