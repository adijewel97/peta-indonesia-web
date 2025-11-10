select KD_PROV, PROVINSI,
--       count(*) TOTAL_MATERIAL,
       sum(
           CASE  WHEN (KATEGORI = 'GARDU') THEN
                 1 else 0
           END
       )||' PCS' as GARDU,
       sum(
           CASE  WHEN (KATEGORI = 'TIANG') and (TRANSMISI = 'TR') THEN
                 1 else 0
           END
       ) as TIANG_TR,
       sum(
           CASE  WHEN (KATEGORI = 'TIANG') and (TRANSMISI = 'TM') THEN
                 1 else 0
           END
       )||' PCS' as TIANG_TM,
       sum(
           CASE  WHEN (KATEGORI = 'KABEL') and (TRANSMISI = 'TR') THEN
                 VOLUME else 0
           END
       )||' M' as KABEL_TR,
       sum(
           CASE  WHEN (KATEGORI = 'KABEL') and (TRANSMISI = 'TM') THEN
                 VOLUME else 0
           END
       )||' M' as KABEL_TM
from LISDESBPBL.TRANS_JARINGAN_LISTRIK
group by  KD_PROV, PROVINSI