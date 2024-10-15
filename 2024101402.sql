20241014-02)UPDATE
  - 자료를 수정할때 사용
사용형식)
    UPDATE 테이블명
          SET 컬럼명=값,
              컬럼명=값,
                 :
              컬럼명=값
    WHERE 조건;
    
    UPDATE 테이블명
          SET (컬럼명1,컬럼명2,컬럼명3,...)=(값1,값2,...|서브쿼리)  -- 이런 경우는 값을 서브쿼리를 써서 사용하는 경우.
    WHERE 조건;    
    
사용예) HR계정의 사원테이블(EMPLOYEES)에서 모든 직원의 급여를 10% 인상하시오.
UPDATE HR.EMPLOYEES
    SET SALARY=SALARY*1.1;
    COMMIT;
    
사용예) 회원테이블(MEMBER)에서 마일리지가 3000이하인 회원을 조회하여 각각 500씩을 추가지급하시오.

  UPDATE CSS02.MEMBER
    SET MEM_MILEAGE=MEM_MILEAGE+500
  WHERE MEM_MILEAGE<=3000;

  SELECT MEM_ID,MEM_NAME,MEM_MILEAGE
    FROM CSS02.MEMBER;
    
    ROLLBACK; -- 원래대로 되돌림
    COMMIT;





