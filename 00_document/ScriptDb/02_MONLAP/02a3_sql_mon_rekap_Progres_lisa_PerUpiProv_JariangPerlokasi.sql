SELECT 
    a.KD_PROV, 
    a.PROVINSI,
    -- Gardu
    SUM(
        CASE  
            WHEN UPPER(a.KATEGORI) = 'GARDU' THEN 1 
            ELSE 0 
        END
    ) || '-' ||
    MAX(
        CASE 
            WHEN UPPER(a.KATEGORI) = 'GARDU' THEN b.KDSATUAN 
        END
    ) AS GARDU,
    -- Tiang TM
    SUM(
        CASE  
            WHEN UPPER(a.KATEGORI) = 'TIANG' AND a.TRANSMISI = 'TM' THEN 1 
            ELSE 0 
        END
    ) || '-' ||
    MAX(
        CASE 
            WHEN UPPER(a.KATEGORI) = 'TIANG' AND a.TRANSMISI = 'TM' THEN b.KDSATUAN 
        END
    ) AS TIANG_TM,
    -- Kabel TM
    SUM(
        CASE 
            WHEN UPPER(a.KATEGORI) = 'KABEL' AND a.TRANSMISI = 'TM' THEN a.VOLUME 
            ELSE 0 
        END
    ) || '-' || 
    MAX(
        CASE 
            WHEN UPPER(a.KATEGORI) = 'KABEL' AND a.TRANSMISI = 'TM' THEN b.KDSATUAN 
        END
    ) || '/' ||
    COUNT(
        CASE 
            WHEN UPPER(a.KATEGORI) = 'KABEL' AND a.TRANSMISI = 'TM' THEN 1 
        END
    ) || '-Segment' AS KABEL_TM2,
    -- Tiang TR
    SUM(
        CASE  
            WHEN UPPER(a.KATEGORI) = 'TIANG' AND a.TRANSMISI = 'TR' THEN 1 
            ELSE 0 
        END
    ) || '-' ||
    MAX(
        CASE 
            WHEN UPPER(a.KATEGORI) = 'TIANG' AND a.TRANSMISI = 'TR' THEN b.KDSATUAN 
        END
    ) AS TIANG_TR,
    -- Kabel TR
    SUM(
        CASE 
            WHEN UPPER(a.KATEGORI) = 'KABEL' AND a.TRANSMISI = 'TR' THEN a.VOLUME 
            ELSE 0 
        END
    ) || '-' || 
    MAX(
        CASE 
            WHEN UPPER(a.KATEGORI) = 'KABEL' AND a.TRANSMISI = 'TR' THEN b.KDSATUAN 
        END
    ) || '/' ||
    COUNT(
        CASE 
            WHEN UPPER(a.KATEGORI) = 'KABEL' AND a.TRANSMISI = 'TR' THEN 1 
        END
    ) || '-Segment' AS KABEL_TR,
    -- Detail material
    COUNT(*) || ' Item' AS MATERIAL_DETAIL,
    -- Progress dan status
    SUM(
        CASE WHEN a.STATUS_PROGRES IN ('WOTERIMA', 'ONPROGRES') THEN 1 ELSE 0 END
    ) || ' Item' AS DETAIL_PROGRES,
    SUM(
        CASE WHEN a.STATUS_PROGRES = 'SELESAI' THEN 1 ELSE 0 END
    ) || ' Item' AS DETAIL_SELESAI,
    SUM(CASE WHEN TRIM(a.NOMOR_NIDI) IS NOT NULL THEN 1 ELSE 0 END) AS NIDI,
    SUM(CASE WHEN TRIM(a.NOMOR_NIDI) IS NOT NULL AND TRIM(a.NOMOR_SLO) IS NULL THEN 1 ELSE 0 END) AS WO_LIT,
    SUM(CASE WHEN TRIM(a.NOMOR_SLO) IS NOT NULL THEN 1 ELSE 0 END) AS SLO,
    SUM(CASE WHEN TRIM(a.STATUS_NYALA) = 'NYALA' THEN 1 ELSE 0 END) AS NYALA
FROM LISDESBPBL.TRANS_JARINGAN_LISTRIK a
LEFT JOIN LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA b ON a.ID_MDU = b.ID_MDU
GROUP BY a.KD_PROV, a.PROVINSI;
