DECLARE
    v_id_g6 NUMBER;
    v_id_t61 NUMBER;
    v_id_t62 NUMBER;
    v_id_b61 NUMBER;
    v_id_k_g6_t61 NUMBER;
    v_id_k_t61_t62 NUMBER;
    v_id_k_t62_b61 NUMBER;
BEGIN
    -- Gardu G6
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, spesifikasi, latitude, longitude, status_lapangan,
        id_mdu
    )
    VALUES(
        '53', '53TSK', '53221', '32', 'JAWA BARAT', '3209', 'TASIKMALAYA',
        '3209050', 'CIBALONG', '3209050005', 'KELURAHAN A',
        'G6', 'GARDU', '400 KV', -7.3732, 108.4956, 'BARU','8'
    )
    RETURNING id_jaringan INTO v_id_g6;

    -- Tiang 6.1
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, latitude, longitude, parent_id, status_lapangan,
        id_mdu, spesifikasi
    )
    VALUES(
        '53', '53TSK', '53221', '32', 'JAWA BARAT', '3209', 'TASIKMALAYA',
        '3209050', 'CIBALONG', '3209050005', 'KELURAHAN A',
        'T6_1', 'TIANG', -7.3738, 108.4962, v_id_g6, 'BARU','17','TR 9m TM 12m'
    )
    RETURNING id_jaringan INTO v_id_t61;

    -- Tiang 6.2
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, latitude, longitude, parent_id, status_lapangan,
        id_mdu, spesifikasi
    )
    VALUES(
        '53', '53TSK', '53221', '32', 'JAWA BARAT', '3209', 'TASIKMALAYA',
        '3209050', 'CIBALONG', '3209050005', 'KELURAHAN A',
        'T6_2', 'TIANG', -7.3742, 108.4970, v_id_t61, 'BARU','17','TR 9m TM 12m'
    )
    RETURNING id_jaringan INTO v_id_t62;

    -- Pelanggan B6.1
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, latitude, longitude, parent_id, status_lapangan
    )
    VALUES(
        '53', '53TSK', '53221', '32', 'JAWA BARAT', '3209', 'TASIKMALAYA',
        '3209050', 'CIBALONG', '3209050005', 'KELURAHAN A',
        'B6_1', 'PELANGGAN', -7.3748, 108.4978, v_id_t62, 'BARU'
    )
    RETURNING id_jaringan INTO v_id_b61;

    -- Kabel dari Gardu ke Tiang 6.1
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, parent_id, target_id, volume, kdsatuan, satuan, status_lapangan,
        id_mdu, spesifikasi
    )
    VALUES(
        '53', '53TSK', '53221', '32', 'JAWA BARAT', '3209', 'TASIKMALAYA',
        '3209050', 'CIBALONG', '3209050005', 'KELURAHAN A',
        'K_G6_T61', 'KABEL', v_id_g6, v_id_t61, 50, 'm', 'Meter', 'BARU','03','NYFGbY 3x95 mm²'
    )
    RETURNING id_jaringan INTO v_id_k_g6_t61;

    -- Kabel dari Tiang 6.1 ke Tiang 6.2
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, parent_id, target_id, volume, kdsatuan, satuan, status_lapangan,
        id_mdu, spesifikasi
    )
    VALUES(
        '53', '53TSK', '53221', '32', 'JAWA BARAT', '3209', 'TASIKMALAYA',
        '3209050', 'CIBALONG', '3209050005', 'KELURAHAN A',
        'K_T61_T62', 'KABEL', v_id_t61, v_id_t62, 60, 'm', 'Meter', 'BARU','03','NYFGbY 3x95 mm²'
    )
    RETURNING id_jaringan INTO v_id_k_t61_t62;

    -- Kabel dari Tiang 6.2 ke Rumah B6.1
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, parent_id, target_id, volume, kdsatuan, satuan, status_lapangan,
        id_mdu, spesifikasi
    )
    VALUES(
        '53', '53TSK', '53221', '32', 'JAWA BARAT', '3209', 'TASIKMALAYA',
        '3209050', 'CIBALONG', '3209050005', 'KELURAHAN A',
        'K_T62_B61', 'KABEL', v_id_t62, v_id_b61, 20, 'm', 'Meter', 'BARU','03','NYFGbY 3x95 mm²'
    )
    RETURNING id_jaringan INTO v_id_k_t62_b61;

    COMMIT;
END;
/
