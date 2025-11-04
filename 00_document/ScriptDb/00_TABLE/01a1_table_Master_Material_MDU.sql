-- Membuat tabel
CREATE TABLE master_material_distibusi_utama (
    id_mdu VARCHAR2(10) PRIMARY KEY,       -- manual, format 5 digit
    kd_material  VARCHAR2(3 BYTE), --ambil 1,5 dari id_mdu
    kategori VARCHAR2(200),
    nama_sku VARCHAR2(400),
    spesifikasi VARCHAR2(400),
    volume NUMBER,
    kdsatuan VARCHAR2(10),
    satuan VARCHAR2(50),
    image   VARCHAR2(200) default null,
    CONSTRAINT uq_mdu_kategori_nama UNIQUE (id_mdu, kategori, nama_sku)
);
