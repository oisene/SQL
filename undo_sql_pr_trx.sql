-- By Jonathan K Lewis

column start_scn format 999,999,999,999
 
select
        tr.start_scn, tr.log_io, tr.phy_io, tr.used_ublk, tr.used_urec, recursive
from
        v$session       se,
        V$transaction   tr
where
        se.sid = &1
and     tr.ses_addr = se.saddr
;
 