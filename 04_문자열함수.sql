
-- lower(�ҹ���), initcap(�ձ��ڸ� �빮��), upper(�빮��)

SELECT * FROM dual;

/*
dual�̶�� ���̺��� sys�� �����ϴ� ����Ŭ�� ǥ�� ���̺�μ�,
���� �� �࿡ �� �÷��� ��� �ִ� dummy ���̺� �Դϴ�.
�Ͻ����� ��� �����̳� ��¥ ���� � �ַ� ����մϴ�.
��� ����ڰ� ������ �� �ֽ��ϴ�.
*/

SELECT
    'abcDEF', lower('abcDEF'), upper('abcDEF')
FROM
    dual;



