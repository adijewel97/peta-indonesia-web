DECLARE
BEGIN
    INSERT INTO LISDESBPBL.MASTER_MATERIAL (KD_MATERIAL, KATEGORI)
    SELECT kd_material, kategori
    FROM (
        SELECT DISTINCT KD_MATERIAL,
               kategori
        FROM LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA mdu
        WHERE NOT EXISTS (
            SELECT 1 
            FROM LISDESBPBL.MASTER_MATERIAL mm
            WHERE mm.kd_material = SUBSTR(mdu.id_mdu, 1, 3)
               OR mm.kategori = mdu.kategori
        )
    )
    ORDER BY 
        KD_MATERIAL;

    COMMIT;
END;
/
