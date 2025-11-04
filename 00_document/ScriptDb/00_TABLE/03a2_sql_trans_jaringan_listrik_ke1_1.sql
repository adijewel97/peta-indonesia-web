DECLARE
    v_id_g6 NUMBER;
    v_id_t61 NUMBER;
    v_id_t62 NUMBER;
    v_id_b61 NUMBER;
    v_id_k_g6_t61 NUMBER;
    v_id_k_t61_t62 NUMBER;
    v_id_k_t62_b61 NUMBER;

    v_id_t61a NUMBER;
    v_id_t61b NUMBER;
    v_id_b61a NUMBER;
    v_id_b61b NUMBER;
    v_id_k_t61_t61a NUMBER;
    v_id_k_t61_t61b NUMBER;
    v_id_k_t61b_b61a NUMBER;
    v_id_k_t61b_b61b NUMBER;
BEGIN
    -- Gardu G6
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, spesifikasi, latitude, longitude, status_lapangan
    )
    VALUES(
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'G6','GARDU','400 KV',-7.3732,108.4956,'BARU'
    )
    RETURNING id_jaringan INTO v_id_g6;

    -- Tiang 6.1
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, latitude, longitude, parent_id, status_lapangan
    )
    VALUES(
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'T6_1','TIANG',-7.3738,108.4962,v_id_g6,'BARU'
    )
    RETURNING id_jaringan INTO v_id_t61;

    -- Tiang 6.2
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, latitude, longitude, parent_id, status_lapangan
    )
    VALUES(
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'T6_2','TIANG',-7.3742,108.4970,v_id_t61,'BARU'
    )
    RETURNING id_jaringan INTO v_id_t62;

    -- Pelanggan B6.1
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, latitude, longitude, parent_id, status_lapangan
    )
    VALUES(
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'B6_1','PELANGGAN',-7.3748,108.4978,v_id_t62,'BARU'
    )
    RETURNING id_jaringan INTO v_id_b61;

    -- === Cabang baru dari T6_1 ===

    -- Tiang 6.1A
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, latitude, longitude, parent_id, status_lapangan
    )
    VALUES(
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'T6_1A','TIANG',-7.3740,108.4965,v_id_t61,'BARU'
    )
    RETURNING id_jaringan INTO v_id_t61a;

    -- Tiang 6.1B
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, latitude, longitude, parent_id, status_lapangan
    )
    VALUES(
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'T6_1B','TIANG',-7.3743,108.4968,v_id_t61,'BARU'
    )
    RETURNING id_jaringan INTO v_id_t61b;

    -- Pelanggan B6_1A (dari T6_1B)
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, latitude, longitude, parent_id, status_lapangan
    )
    VALUES(
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'B6_1A','PELANGGAN',-7.3745,108.4972,v_id_t61b,'BARU'
    )
    RETURNING id_jaringan INTO v_id_b61a;

    -- Pelanggan B6_1B (dari T6_1B)
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, latitude, longitude, parent_id, status_lapangan
    )
    VALUES(
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'B6_1B','PELANGGAN',-7.3747,108.4975,v_id_t61b,'BARU'
    )
    RETURNING id_jaringan INTO v_id_b61b;

    -- === Kabel ===

    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, parent_id, target_id, volume, kdsatuan, satuan, status_lapangan
    )
    VALUES(
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'K_T61_T61A','KABEL',v_id_t61,v_id_t61a,30,'m','Meter','BARU'
    )
    RETURNING id_jaringan INTO v_id_k_t61_t61a;

    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, parent_id, target_id, volume, kdsatuan, satuan, status_lapangan
    )
    VALUES(
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'K_T61_T61B','KABEL',v_id_t61,v_id_t61b,40,'m','Meter','BARU'
    )
    RETURNING id_jaringan INTO v_id_k_t61_t61b;

    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, parent_id, target_id, volume, kdsatuan, satuan, status_lapangan
    )
    VALUES(
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'K_T61B_B61A','KABEL',v_id_t61b,v_id_b61a,20,'m','Meter','BARU'
    )
    RETURNING id_jaringan INTO v_id_k_t61b_b61a;

    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK(
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, parent_id, target_id, volume, kdsatuan, satuan, status_lapangan
    )
    VALUES(
        '53','53TSK','53221','32','JAWA BARAT','3209','TASIKMALAYA',
        '3209050','CIBALONG','3209050005','KELURAHAN A',
        'K_T61B_B61B','KABEL',v_id_t61b,v_id_b61b,25,'m','Meter','BARU'
    )
    RETURNING id_jaringan INTO v_id_k_t61b_b61b;

    COMMIT;
END;
/
