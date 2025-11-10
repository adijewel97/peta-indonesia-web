INSERT INTO master_material_unit (id_mdu, unitupi, unitap, unitup, harga, volume, kdsatuan, satuan, tgl_berlaku)
SELECT 
    m.id_mdu,
    j.unitupi,
    j.unitap,
    j.unitup,
    CASE 
        WHEN m.kd_material = '01' THEN 12000      -- contoh harga default kabel
        WHEN m.kd_material = '02' THEN 15000      -- contoh harga default conductor
        WHEN m.kd_material = '03' THEN 15000000   -- contoh harga default trafo
        WHEN m.kd_material = '04' THEN 5000000    -- contoh harga default FCO
        WHEN m.kd_material = '05' THEN 2000000    -- contoh harga default isolator
        WHEN m.kd_material = '06' THEN 1000000    -- contoh harga default LA
        WHEN m.kd_material = '07' THEN 1200000    -- contoh harga default tiang baja
        WHEN m.kd_material = '08' THEN 1000000    -- contoh harga default tiang beton
        WHEN m.kd_material = '09' THEN 2000000    -- contoh harga default PHB TR
        ELSE 100000
    END as harga,
    m.volume,
    m.kdsatuan,
    m.satuan,
    SYSDATE
FROM master_material_distibusi_utama m
CROSS JOIN (
    SELECT DISTINCT unitupi, unitap, unitup
    FROM LISDESBPBL.TRANS_JARINGAN_LISTRIK
) j;
