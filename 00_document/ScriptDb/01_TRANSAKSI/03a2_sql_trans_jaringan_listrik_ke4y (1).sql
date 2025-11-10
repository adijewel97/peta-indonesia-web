DECLARE
    v_id_g6           NUMBER;
    v_id_t61          NUMBER;
    v_id_t62          NUMBER;
    v_id_b61          NUMBER;
    v_id_k_g6_t61_tm  NUMBER;
    v_id_k_g6_t61_tr  NUMBER;
    v_id_k_t61_t62_tm NUMBER;
    v_id_k_t61_t62_tr NUMBER;
    v_id_k_t62_b61_tr NUMBER;
BEGIN
    -- ===========================
    -- 1. Gardu G6
    -- ===========================
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota,
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, spesifikasi,
        latitude, longitude, status_lapangan, id_mdu
    ) VALUES (
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'G6','GARDU','400 KV',
        -7.3732,108.4956,'BARU','M001'
    )
    RETURNING id_jaringan INTO v_id_g6;

    -- ===========================
    -- 2. Tiang 6.1 (TM)
    -- ===========================
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota,
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, spesifikasi, transmisi,
        latitude, longitude, parent_id, status_lapangan, id_mdu
    ) VALUES (
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'T6_1','TIANG','Tiang Beton 12 m','TM',
        -7.3738,108.4962,v_id_g6,'BARU','M017'
    )
    RETURNING id_jaringan INTO v_id_t61;

    -- ===========================
    -- 3. Tiang 6.2 (TR)
    -- ===========================
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota,
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, spesifikasi, transmisi,
        latitude, longitude, parent_id, status_lapangan, id_mdu
    ) VALUES (
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'T6_2','TIANG','Tiang Baja 12 m','TM',
        -7.3742,108.4970,v_id_t61,'BARU','M018'
    )
    RETURNING id_jaringan INTO v_id_t62;

    -- ===========================
    -- 4. Pelanggan B6.1
    -- ===========================
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota,
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, spesifikasi,
        latitude, longitude, parent_id, status_lapangan, id_mdu
    ) VALUES (
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'B6_1','PELANGGAN','-',
        -7.3748,108.4978,v_id_t62,'BARU','M030'
    )
    RETURNING id_jaringan INTO v_id_b61;

    -- ===========================
    -- 5. Kabel Gardu ? Tiang 6.1 (TM)
    -- ===========================
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota,
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, parent_id, target_id, volume, kdsatuan, satuan,
        status_lapangan, transmisi, id_mdu
    ) VALUES (
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'K_G6_T61_TM','KABEL',v_id_g6,v_id_t61,50,'m','Meter','BARU','TM','M050'
    )
    RETURNING id_jaringan INTO v_id_k_g6_t61_tm;

    -- 6. Kabel Gardu ? Tiang 6.1 (TR)
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota,
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, parent_id, target_id, volume, kdsatuan, satuan,
        status_lapangan, transmisi, id_mdu
    ) VALUES (
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'K_G6_T61_TR','KABEL',v_id_g6,v_id_t61,50,'m','Meter','BARU','TR','M051'
    )
    RETURNING id_jaringan INTO v_id_k_g6_t61_tr;

    -- ===========================
    -- 7. Kabel Tiang 6.1 ? Tiang 6.2 (TM)
    -- ===========================
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota,
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, parent_id, target_id, volume, kdsatuan, satuan,
        status_lapangan, transmisi, id_mdu
    ) VALUES (
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'K_T61_T62_TM','KABEL',v_id_t61,v_id_t62,60,'m','Meter','BARU','TM','M052'
    )
    RETURNING id_jaringan INTO v_id_k_t61_t62_tm;

    -- 8. Kabel Tiang 6.1 ? Tiang 6.2 (TR)
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota,
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, parent_id, target_id, volume, kdsatuan, satuan,
        status_lapangan, transmisi, id_mdu
    ) VALUES (
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'K_T61_T62_TR','KABEL',v_id_t61,v_id_t62,60,'m','Meter','BARU','TR','M053'
    )
    RETURNING id_jaringan INTO v_id_k_t61_t62_tr;

    -- 9. Kabel Tiang 6.2 ? Pelanggan B6.1 (TR)
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota,
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, parent_id, target_id, volume, kdsatuan, satuan,
        status_lapangan, transmisi, id_mdu
    ) VALUES (
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'K_T62_B61_TR','KABEL',v_id_t62,v_id_b61,30,'m','Meter','BARU','TR','M054'
    )
    RETURNING id_jaringan INTO v_id_k_t62_b61_tr;

    COMMIT;
END;
/
