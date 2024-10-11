2024-1010-03) 날짜자료 타입
 - DATE, TIMESTAMP, TIMESTAMP WITH LOCAL TIME ZONE, TIMESTAMP WITH TIME ZONE
1. DATE
 - 기본 날짜 타입(년, 월, 일, 시, 분, 초)
 - '+', '-' 의 연산 대상 (나누기, 곱 안됨)
 - SYSDATE 함수로 시스템 날짜 저장
 
2. TIMESTAMP
  - 정교한 시간(소수점 9자리 까지의 초반환)
  - SYSTIMESTAMP 함수로 시스템 날짜 저장
  
사용형식)
  SELECT SYSDATE FROM DUAL;
   ** 프롬할 테이블이 없으면 DUAL을 사용.
  SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
   ** 그냥 출력하면 영국 기준 GMT 값으로 나옴.
   ** 다운 받은 파일 6. Docker에서 오라클의 시간 설정 변경하기 << 파일 보고 
      그대로 도커 세팅하면 서울 시간으로 변경 가능.
      
      
      
사용예)
  CREATE TABLE TEST04(
    COL1 DATE,
    COL2 DATE,
    COL3 DATE,
    COL4 TIMESTAMP,
    COL5 TIMESTAMP WITH LOCAL TIME ZONE,
    COL6 TIMESTAMP WITH TIME ZONE);
    
  INSERT INTO TEST04 VALUES(SYSDATE, SYSDATE-10, SYSDATE+10, SYSTIMESTAMP, SYSTIMESTAMP, SYSTIMESTAMP);  

  SELECT * FROM TEST04;  
  -- 결과값
  -- 2024/10/11	2024/10/01	2024/10/21	2024/10/11 09:16:52.596606000	2024/10/11 09:16:52.596606000	2024/10/11 09:16:52.596606000 +09:00
  
  -- 날짜를 -10 하면 10일이 빠짐.
  
  SELECT TRUNC(SYSDATE) - TRUNC(TO_DATE('19921229')) FROM DUAL;
  -- 위 식은 저 날짜까지 살아온 일수 계산법
  -- TRUNC : 소수점 짤라줘라.
  -- DUAL : 테이블이 없을때.
  -- 날짜 - 날짜 = 날수
  
  
  
  
  
  
  
  
  
  
  
  
   
   
   