-- 1?? Hapus data lama (opsional)
TRUNCATE TABLE master_material_distibusi_utama;

-- 2?? Insert Data Baru

-- Cable Power
INSERT INTO master_material_distibusi_utama 
(id_mdu, kd_material, kategori, nama_sku, spesifikasi, volume, kdsatuan, satuan, image) VALUES
('00001', '01', 'CABLE POWER', 'NFA2X 2X16 mm²', 'Kabel udara 2x16 mm²', 100, 'M', 'Meter', NULL);
INSERT INTO master_material_distibusi_utama VALUES 
('00002', '01', 'CABLE POWER', 'NFA2X 4X25 mm²', 'Kabel udara 4x25 mm²', 100, 'M', 'Meter', NULL);
INSERT INTO master_material_distibusi_utama VALUES 
('00003', '01', 'CABLE POWER', 'NYFGBY 3X95 mm²', 'Kabel tanah 3x95 mm²', 50, 'M', 'Meter', NULL);

-- Conductor
INSERT INTO master_material_distibusi_utama VALUES 
('00004', '02', 'CONDUCTOR', 'AAAC 150 mm²', 'Kawat penghantar udara 150 mm²', 200, 'M', 'Meter', NULL);
INSERT INTO master_material_distibusi_utama VALUES 
('00005', '02', 'CONDUCTOR', 'AAAC 240 mm²', 'Kawat penghantar udara 240 mm²', 200, 'M', 'Meter', NULL);

-- Trafo Distribusi
INSERT INTO master_material_distibusi_utama VALUES 
('00006', '03', 'TRAFO DISTRIBUSI', 'Trafo 100 kVA', 'Trafo distribusi 20 kV/400 V', 1, 'PCS', 'Buah', NULL);
INSERT INTO master_material_distibusi_utama VALUES 
('00007', '03', 'TRAFO DISTRIBUSI', 'Trafo 160 kVA', 'Trafo distribusi 20 kV/400 V', 1, 'PCS', 'Buah', NULL);
INSERT INTO master_material_distibusi_utama VALUES 
('00008', '03', 'TRAFO DISTRIBUSI', 'Trafo 250 kVA', 'Trafo distribusi 20 kV/400 V', 1, 'PCS', 'Buah', NULL);

-- FCO
INSERT INTO master_material_distibusi_utama VALUES 
('00009', '04', 'FCO', 'Fuse Cut Out 100A', 'Pemutus beban distribusi 100A', 1, 'SET', 'Set', NULL);
INSERT INTO master_material_distibusi_utama VALUES 
('00010', '04', 'FCO', 'Fuse Cut Out 200A', 'Pemutus beban distribusi 200A', 1, 'SET', 'Set', NULL);

-- Isolator
INSERT INTO master_material_distibusi_utama VALUES 
('00011', '05', 'ISOLATOR', 'Isolator Pin 20 kV', 'Tipe pin untuk saluran 20 kV', 1, 'PCS', 'Buah', NULL);
INSERT INTO master_material_distibusi_utama VALUES 
('00012', '05', 'ISOLATOR', 'Isolator Suspensi 20 kV', 'Tipe gantung saluran 20 kV', 1, 'PCS', 'Buah', NULL);

-- Lightning Arrester
INSERT INTO master_material_distibusi_utama VALUES 
('00013', '06', 'LIGHTNING ARRESTER', 'LA 20 kV', 'Penangkal petir distribusi 20 kV', 1, 'PCS', 'Buah', NULL);
INSERT INTO master_material_distibusi_utama VALUES 
('00014', '06', 'LIGHTNING ARRESTER', 'LA 24 kV Polymer', 'Penangkal petir polimer 24 kV', 1, 'PCS', 'Buah', NULL);

-- Tiang Baja
INSERT INTO master_material_distibusi_utama VALUES 
('00015', '07', 'TIANG BAJA', 'Tiang Baja 9 m', 'Tiang baja galvanis 9 meter', 1, 'PCS', 'Buah', NULL);
INSERT INTO master_material_distibusi_utama VALUES 
('00016', '07', 'TIANG BAJA', 'Tiang Baja 12 m', 'Tiang baja galvanis 12 meter', 1, 'PCS', 'Buah', NULL);

-- Tiang Beton
INSERT INTO master_material_distibusi_utama VALUES 
('00017', '08', 'TIANG BETON', 'Tiang Beton 9 m', 'Tiang beton bertulang 9 meter', 1, 'PCS', 'Buah', NULL);
INSERT INTO master_material_distibusi_utama VALUES 
('00018', '08', 'TIANG BETON', 'Tiang Beton 11 m', 'Tiang beton bertulang 11 meter', 1, 'PCS', 'Buah', NULL);

-- PHB TR
INSERT INTO master_material_distibusi_utama VALUES 
('00019', '09', 'PHB TR', 'Panel TR 3 Fasa', 'Panel distribusi trafo 3 fasa', 1, 'SET', 'Set', NULL);
INSERT INTO master_material_distibusi_utama VALUES 
('00020', '09', 'PHB TR', 'Panel TR 1 Fasa', 'Panel distribusi trafo 1 fasa', 1, 'SET', 'Set', NULL);

COMMIT;
