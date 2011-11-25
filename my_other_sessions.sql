CREATE VIEW MY_SESSIONS AS 
SELECT *
FROM V$SESSION
where username=user;

grant execute on my_sessions to public;

create public synonym my_sessions for my_sessions;

CREATE OR REPLACE PROCEDURE KILL_MY_OTHER_SESSION(P_SID IN NUMBER,P_SERIAL# IN NUMBER) AS
  L_exist NUMBER;
BEGIN
  SELECT 1 INTO L_exist
  FROM SYS.MY_SESSIONS
  WHERE SID=P_SID 
  AND SERIAL#=P_SERIAL#
  AND AUDSID != USERENV('SESSIONID');
  EXECUTE IMMEDIATE 'alter system kill session ''' || P_SID || ',' || P_SERIAL# || '''' ;
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN
       RAISE_APPLICATION_ERROR(-20101, 'Either session does not exist or you tried to kill your own session');
END;
/
