DECLARE
    -- ID untuk masing-masing node dan kabel
    v_id_g1 NUMBER;
    v_id_t1 NUMBER;
    v_id_t11 NUMBER;
    v_id_b1 NUMBER;
    v_id_t12 NUMBER;
    v_id_b2 NUMBER;
    v_id_t2 NUMBER;
    v_id_t21 NUMBER;
    v_id_b3 NUMBER;
    v_id_t3 NUMBER;
    v_id_g2 NUMBER;
    v_id_k0 NUMBER;
    v_id_k1 NUMBER;
    v_id_k2 NUMBER;

    -- tambahan cabang dari T1.2
    v_id_t122L1 NUMBER;
    v_id_t121 NUMBER;
    v_id_t122 NUMBER;
    v_id_b4 NUMBER;
    v_id_b5 NUMBER;
    v_id_b6 NUMBER;
    v_id_k3 NUMBER;
    v_id_k4 NUMBER;
    v_id_k5 NUMBER;

BEGIN
    -- Gardu G1
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK (
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, spesifikasi, latitude, longitude, status_lapangan
    ) VALUES (
        '53', '53TSK', '53221', 
        '32', 'JAWA BARAT', '3207', 'CIAMIS', 
        '320701', 'CISAGA', '32070101', 'CISAGA',
        'G1', 'GARDU', 'Trafo 250 kVA', -7.309500, 108.576300, 'LAMA'
    )
    RETURNING ID_JARINGAN INTO v_id_g1;

    -- Tiang 1
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK (
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota, 
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, latitude, longitude, parent_id, status_lapangan
    ) VALUES (
        '53', '53TSK', '53221',
        '32', 'JAWA BARAT', '3207', 'CIAMIS',
        '320701', 'CISAGA', '32070101', 'CISAGA',
        'T1', 'TIANG', -7.310200, 108.577100, v_id_g1, 'LAMA'
    )
    RETURNING ID_JARINGAN INTO v_id_t1;

    -- Kabel G1 -> T1
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK (
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota,
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, parent_id, target_id, volume, kdsatuan, satuan, transmisi, status_lapangan
    ) VALUES (
        '53', '53TSK', '53221',
        '32', 'JAWA BARAT', '3207', 'CIAMIS',
        '320701', 'CISAGA', '32070101', 'CISAGA',
        'K0', 'KABEL', v_id_g1, v_id_t1, 50, 'M', 'Meter', 'TT', 'LAMA'
    )
    RETURNING ID_JARINGAN INTO v_id_k0;

    -- Tiang 1.1
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK (
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota,
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, latitude, longitude, parent_id, status_lapangan
    ) VALUES (
        '53', '53TSK', '53221',
        '32', 'JAWA BARAT', '3207', 'CIAMIS',
        '320701', 'CISAGA', '32070101', 'CISAGA',
        'T1.1', 'TIANG', -7.311000, 108.577800, v_id_t1, 'LAMA'
    )
    RETURNING ID_JARINGAN INTO v_id_t11;

    -- Rumah 1
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK (
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota,
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, latitude, longitude, parent_id, status_lapangan
    ) VALUES (
        '53', '53TSK', '53221',
        '32', 'JAWA BARAT', '3207', 'CIAMIS',
        '320701', 'CISAGA', '32070101', 'CISAGA',
        'B1', 'PELANGGAN', -7.311400, 108.578000, v_id_t11, 'BARU'
    )
    RETURNING ID_JARINGAN INTO v_id_b1;

    -- Tiang 1.2
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK (
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota,
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, latitude, longitude, parent_id, status_lapangan
    ) VALUES (
        '53', '53TSK', '53221',
        '32', 'JAWA BARAT', '3207', 'CIAMIS',
        '320701', 'CISAGA', '32070101', 'CISAGA',
        'T1.2', 'TIANG', -7.311800, 108.578200, v_id_t1, 'BARU'
    )
    RETURNING ID_JARINGAN INTO v_id_t12;

    -- Rumah 2
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK (
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota,
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, latitude, longitude, parent_id, status_lapangan
    ) VALUES (
        '53', '53TSK', '53221',
        '32', 'JAWA BARAT', '3207', 'CIAMIS',
        '320701', 'CISAGA', '32070101', 'CISAGA',
        'B2', 'PELANGGAN', -7.312200, 108.578400, v_id_t12, 'BARU'
    )
    RETURNING ID_JARINGAN INTO v_id_b2;

    -- Kabel T1 -> T1.2
    INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK (
        unitupi, unitap, unitup, kd_prov, provinsi, kd_kab, kabupatenkota,
        kd_kec, kecamatan, kd_kel, desakelurahan,
        kode_system, kategori, parent_id, target_id, volume, kdsatuan, satuan, transmisi, status_lapangan
    ) VALUES (
        '53', '53TSK', '53221',
        '32', 'JAWA BARAT', '3207', 'CIAMIS',
        '320701', 'CISAGA', '32070101', 'CISAGA',
        'K1', 'KABEL', v_id_t1, v_id_t12, 30, 'M', 'Meter', 'TR', 'BARU'
    )
    RETURNING ID_JARINGAN INTO v_id_k1;

    COMMIT;
END;
/
