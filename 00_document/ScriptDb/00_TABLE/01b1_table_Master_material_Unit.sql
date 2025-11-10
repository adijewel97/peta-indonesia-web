CREATE TABLE master_material_unit (
    id_mdu VARCHAR2(10),           -- ID material dari master_material_distibusi_utama
    unitupi VARCHAR2(2) NOT NULL, -- kode UPI
    unitap  VARCHAR2(5) NOT NULL, -- kode UP3
    unitup  VARCHAR2(5) NOT NULL, -- kode ULP
    harga   NUMBER(12,2) NOT NULL, -- harga material per unit
    volume  NUMBER,                 -- volume material (misal jumlah tiang/kabel)
    KDSATUAN     VARCHAR2(10 BYTE),
    SATUAN       VARCHAR2(50 BYTE),
    tgl_berlaku DATE DEFAULT SYSDATE, -- tanggal harga berlaku
    keterangan VARCHAR2(500),
    CONSTRAINT pk_material_unit PRIMARY KEY (id_mdu, unitupi, unitap, unitup),
    CONSTRAINT fk_material_unit FOREIGN KEY (id_mdu)
        REFERENCES master_material_distibusi_utama(id_mdu)
);
