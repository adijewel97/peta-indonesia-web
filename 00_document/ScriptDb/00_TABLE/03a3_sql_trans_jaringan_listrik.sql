SELECT LEVEL AS level_data,  
       ID_JARINGAN, kode_system, kode_lapangan, parent_id, target_id,  
       unitupi, unitap, unitup,  
       KATEGORI, SPESIFIKASI, LATITUDE, LONGITUDE,  
       transmisi, status_lapangan, status_kontrak,  
       (VOLUME||' '||KDSATUAN) as satuan, rupiah_satuan,  
       tglinsert, tglkoreksi, keterangan  
FROM lisdesbpbl.trans_jaringan_listrik  
START WITH parent_id IS NULL  
CONNECT BY PRIOR ID_JARINGAN = parent_id  
ORDER SIBLINGS BY kode_system