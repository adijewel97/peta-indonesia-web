-- ===============================
-- 1?? Buat User / Schema
-- ===============================
CREATE USER LISDESBPBL 
IDENTIFIED BY adis123
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON USERS;

-- ===============================
-- 2?? Buat Role Khusus Aplikasi
-- ===============================
CREATE ROLE LISDESBPBL_APPRL;

-- ===============================
-- 3?? Berikan Hak Akses ke Role
-- ===============================
-- Privilege dasar login dan membuat objek
GRANT CREATE SESSION TO LISDESBPBL_APPRL;
GRANT CONNECT TO LISDESBPBL_APPRL;
GRANT RESOURCE TO LISDESBPBL_APPRL;

-- Privilege tambahan untuk aplikasi
GRANT CREATE VIEW TO LISDESBPBL_APPRL;
GRANT CREATE PROCEDURE TO LISDESBPBL_APPRL;
GRANT CREATE ANY PROCEDURE TO LISDESBPBL_APPRL;
GRANT CREATE ANY INDEX TO LISDESBPBL_APPRL;
GRANT CREATE SYNONYM TO LISDESBPBL_APPRL;
GRANT CREATE PUBLIC SYNONYM TO LISDESBPBL_APPRL;
GRANT DROP PUBLIC SYNONYM TO LISDESBPBL_APPRL;

-- Privilege khusus PL/SQL / debugging
GRANT EXECUTE ON SYS.DBMS_LOCK TO LISDESBPBL_APPRL;
GRANT DEBUG CONNECT SESSION TO LISDESBPBL_APPRL;

-- Privilege untuk melihat katalog (metadata)
GRANT SELECT_CATALOG_ROLE TO LISDESBPBL_APPRL;

-- ===============================
-- 4?? Berikan Role ke User
-- ===============================
GRANT LISDESBPBL_APPRL TO LISDESBPBL;

-- ===============================
-- 5?? Opsional: Cek Role & Privilege
-- ===============================
-- Role aktif

-- SELECT * FROM USER_ROLE_PRIVS WHERE USERNAME='LISDESBPBL';

-- Privilege sistem
-- SELECT * FROM USER_SYS_PRIVS WHERE USERNAME='LISDESBPBL';

-- Privilege objek
-- SELECT * FROM USER_TAB_PRIVS WHERE GRANTEE='LISDESBPBL';
