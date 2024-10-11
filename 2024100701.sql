2024-1007-01)USER 생성
 - CREATE 명령 사용
 - 권한 부여
 (사용형식)
  CREATE USER 유저명 IDENTIFIED BY 암호;
  
  CREATE USER CSS02 IDENTIFIED BY java;
  
  **권한부여
  (사용형식)
  GRANT 권한명 [,권한명,...] TO USER명;
  . 권한명 : CONNECT, RESOURCE, DBA, ...
  
  GRANT CONNECT, RESOURCE, DBA TO CSS02;
    