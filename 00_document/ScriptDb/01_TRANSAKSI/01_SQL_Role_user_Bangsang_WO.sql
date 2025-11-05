SELECT a.ID_ROLE, a.USERNAME, a.ROLE_NAME,                                 
     a.UNITUPI, a.UNITAP, a.UNITUP,                                        
     a.KD_PROV, B.NAMA_PROV PROVINSI, a.KD_KAB,  B.NAMA_KAB KABUPATENKOTA, 
     a.KD_KEC,  B.NAMA_KEC KECAMATAN, a.KD_KEL, B.NAMA_KEL DESAKELURAHAN,  
     B.UNITUP UP,                                                        
     a.STATUS, a.CREATED_AT                                                
 FROM LISDESBPBL.MASTER_ROLE_PETUGAS a, LISDESBPBL.MASTER_REFF_KELURAHAN b 
 WHERE a.USERNAME = 'adis'                                                   
 AND a.KD_KEL = B.KD_KEL                                                   
 AND A.UNITUP = B.UNITUP                                                   