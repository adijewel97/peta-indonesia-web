-- =====================================================
-- INSERT DATA MASTER MATERIAL DISTRIBUSI UTAMA (MDU)
-- (Oracle-compatible: INSERT ALL)
-- =====================================================

-- Pembangunan Jaringan Tegangan Menengah (transmisi = 'TM')
INSERT ALL
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00001', '001', 'Tiang', 'Tiang Baja 12 m', 0, 'Btg', 'Batang', 'TM')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00002', '001', 'Tiang', 'Tiang Baja 13 m', 0, 'Btg', 'Batang', 'TM')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00003', '001', 'Tiang', 'Tiang Beton 12 m', 0, 'Btg', 'Batang', 'TM')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00004', '001', 'Tiang', 'Tiang Beton 13 m', 0, 'Btg', 'Batang', 'TM')

  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00005', '002', 'Konduktor', 'AAAC;70MM2;', 0, 'm', 'Meter', 'TM')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00006', '002', 'Konduktor', 'AAAC;150MM2;', 0, 'm', 'Meter', 'TM')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00007', '002', 'Konduktor', 'AAAC-S;70MM2;', 0, 'm', 'Meter', 'TM')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00008', '002', 'Konduktor', 'AAAC-S;150MM2;', 0, 'm', 'Meter', 'TM')

  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00009', '003', 'Isolator', 'Isolator Tumpu', 0, 'Bh', 'Buah', 'TM')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00010', '003', 'Isolator', 'Isolator Tarik', 0, 'Set', 'Set', 'TM')

  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00011', '004', 'FCO', 'Fuse Cut Out', 0, 'Bh', 'Buah', 'TM')

  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00012', '005', 'LA', 'Lightning Arrester', 0, 'Bh', 'Buah', 'TM')

  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00013', '006', 'Tiang Topang', 'Tiang Baja 9 m', 0, 'Btg', 'Batang', 'TM')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00014', '006', 'Tiang Topang', 'Tiang Baja 11 m', 0, 'Btg', 'Batang', 'TM')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00015', '006', 'Tiang Topang', 'Tiang Beton 9 m', 0, 'Btg', 'Batang', 'TM')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00016', '006', 'Tiang Topang', 'Tiang Beton 11 m', 0, 'Btg', 'Batang', 'TM')

  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00017', '007', 'Kabel Power', 'NFA2X-T,3X70 + 70MM2;0.6/1KV', 0, 'm', 'Meter', 'TM')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00018', '007', 'Kabel Power', 'NFA2X-T,3X35 + 35MM2;0.6/1KV', 0, 'm', 'Meter', 'TM')
SELECT * FROM DUAL;

-- Pembangunan Gardu Distribusi (transmisi = 'TR')
INSERT ALL
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00019', '008', 'Tiang', 'Tiang Baja 12 m', 0, 'Btg', 'Batang', 'TR')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00020', '008', 'Tiang', 'Tiang Beton 12 m', 0, 'Btg', 'Batang', 'TR')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00021', '008', 'Tiang', 'Tiang Baja 13 m', 0, 'Btg', 'Batang', 'TR')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00022', '008', 'Tiang', 'Tiang Beton 13 m', 0, 'Btg', 'Batang', 'TR')

  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00023', '009', 'Trafo Distribusi', '50 kVA', 0, 'Unit', 'Unit', 'TR')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00024', '009', 'Trafo Distribusi', '100 kVA', 0, 'Unit', 'Unit', 'TR')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00025', '009', 'Trafo Distribusi', '160 kVA', 0, 'Unit', 'Unit', 'TR')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00026', '009', 'Trafo Distribusi', '250 kVA', 0, 'Unit', 'Unit', 'TR')

  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00027', '010', 'FCO', 'Fuse Cut Out', 0, 'Bh', 'Buah', 'TR')

  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00028', '011', 'LA', 'Lightning Arrester', 0, 'Bh', 'Buah', 'TR')

  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00029', '012', 'PHB TR', 'PL-250-2-LBS', 0, 'Unit', 'Unit', 'TR')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00030', '012', 'PHB TR', 'PL-250-2-MCCB', 0, 'Unit', 'Unit', 'TR')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00031', '012', 'PHB TR', 'PL-400-4-LBS', 0, 'Unit', 'Unit', 'TR')

  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00032', '013', 'Kabel Power', 'NYY;1X70MM2;0.6/1KV;Opstig', 0, 'm', 'Meter', 'TR')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00033', '013', 'Kabel Power', 'NYY;1X95MM2;0.6/1KV;Opstig', 0, 'm', 'Meter', 'TR')
  INTO  LISDESBPBL.MASTER_MATERIAL_DISTIBUSI_UTAMA (id_mdu, kd_material, kategori, nama_sku, volume, kdsatuan, satuan, transmisi)
    VALUES ('00034', '013', 'Kabel Power', 'NYY;1X150MM2;0.6/1KV;Opstig', 0, 'm', 'Meter', 'TR')
SELECT * FROM DUAL;

COMMIT;
