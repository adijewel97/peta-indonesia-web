-- ============================================================
-- 3?? Insert data harga per ULP
-- ============================================================

-- Harga untuk ULP A
INSERT INTO LISDESBPBL.MASTER_HARGA_MDU
(UNITUPI, UNITAP, UNITUP, ID_MDU, KD_MATERIAL, KATEGORI, 
 NAMA_SKU, SPESIFIKASI, VOLUME, KDSATUAN, SATUAN, 
 RUPIAH_SATUAN, USER_UPDATE)
SELECT 
    '51' AS UNITUPI,
    '5101' AS UNITAP,
    '51011' AS UNITUP,
    mdu.id_mdu,
    mdu.kd_material,
    mdu.kategori,
    mdu.nama_sku,
    mdu.spesifikasi,
    mdu.volume,
    mdu.kdsatuan,
    mdu.satuan,
    CASE 
        WHEN UPPER(mdu.kategori) LIKE 'TRAFO%' THEN 25000000
        WHEN UPPER(mdu.kategori) LIKE 'CABLE%' THEN 15000
        WHEN UPPER(mdu.kategori) LIKE 'TIANG%' THEN 3500000
        ELSE 100000
    END AS rupiah_satuan,
    'ADMIN_ULP_A' AS USER_UPDATE
FROM LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA mdu
WHERE NOT EXISTS (
    SELECT 1 FROM LISDESBPBL.MASTER_HARGA_MDU h
    WHERE h.UNITUPI = '51' AND h.UNITAP = '5101' 
          AND h.UNITUP = '51011' AND h.ID_MDU = mdu.id_mdu
);

-- Harga untuk ULP B
INSERT INTO LISDESBPBL.MASTER_HARGA_MDU
(UNITUPI, UNITAP, UNITUP, ID_MDU, KD_MATERIAL, KATEGORI, 
 NAMA_SKU, SPESIFIKASI, VOLUME, KDSATUAN, SATUAN, 
 RUPIAH_SATUAN, USER_UPDATE)
SELECT 
    '51' AS UNITUPI,
    '5101' AS UNITAP,
    '51012' AS UNITUP,
    mdu.id_mdu,
    mdu.kd_material,
    mdu.kategori,
    mdu.nama_sku,
    mdu.spesifikasi,
    mdu.volume,
    mdu.kdsatuan,
    mdu.satuan,
    CASE 
        WHEN UPPER(mdu.kategori) LIKE 'TRAFO%' THEN 26000000
        WHEN UPPER(mdu.kategori) LIKE 'CABLE%' THEN 15500
        WHEN UPPER(mdu.kategori) LIKE 'TIANG%' THEN 3400000
        ELSE 110000
    END AS rupiah_satuan,
    'ADMIN_ULP_B' AS USER_UPDATE
FROM LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA mdu
WHERE NOT EXISTS (
    SELECT 1 FROM LISDESBPBL.MASTER_HARGA_MDU h
    WHERE h.UNITUPI = '51' AND h.UNITAP = '5101' 
          AND h.UNITUP = '51012' AND h.ID_MDU = mdu.id_mdu
);

COMMIT;
/