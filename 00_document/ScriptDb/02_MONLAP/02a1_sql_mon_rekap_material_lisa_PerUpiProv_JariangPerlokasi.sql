SELECT 
    COUNT(*) AS volume,
--    a.NOMOR_KONTRAK_INDUK,
    a.NOMOR_KONTRAK_RINCI as KODE,
    a.UNITUPI, a.UNITAP, a.UNITUP,
    a.KD_PROV, a.PROVINSI,
    a.KD_KAB, a.KABUPATENKOTA,
    a.KD_KEC, a.KECAMATAN,
    a.KD_KEL, a.DESAKELURAHAN,
    -- ==== Konversi Latitude ke format DMS ====
    TRUNC(ABS(MIN(a.Latitude))) || '°' ||
    TRUNC(MOD(ABS(MIN(a.Latitude)) * 60, 60)) || '''' ||
    TRUNC(MOD(ABS(MIN(a.Latitude)) * 3600, 60)) || '"' ||
    CASE WHEN MIN(a.Latitude) < 0 THEN 'S ' ELSE 'N ' END ||    
    -- ==== Konversi Longitude ke format DMS ====
    TRUNC(ABS(MIN(a.Longitude))) || '°' ||
    TRUNC(MOD(ABS(MIN(a.Longitude)) * 60, 60)) || '''' ||
    TRUNC(MOD(ABS(MIN(a.Longitude)) * 3600, 60)) || '"' ||
    CASE WHEN MIN(a.Longitude) < 0 THEN 'W' ELSE 'E' END AS koordinat,
    MIN(a.Latitude) as Latitude,
    MIN(a.Longitude) as Longitude
FROM LISDESBPBL.TRANS_JARINGAN_LISTRIK a
GROUP BY 
    a.NOMOR_KONTRAK_INDUK, a.NOMOR_KONTRAK_RINCI,
    a.UNITUPI, a.UNITAP, a.UNITUP,
    a.KD_PROV, a.PROVINSI,
    a.KD_KAB, a.KABUPATENKOTA,
    a.KD_KEC, a.KECAMATAN,
    a.KD_KEL, a.DESAKELURAHAN
ORDER BY a.KD_KEL;
