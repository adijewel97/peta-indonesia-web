-- 1?? Buat tipe objek dulu (tipe data untuk satu baris kabel)
CREATE OR REPLACE TYPE KABEL_OBJ AS OBJECT (
    kode_system     VARCHAR2(50),
    parent_id       NUMBER,
    target_id       NUMBER,
    panjang_m       NUMBER,
    transmisi       VARCHAR2(10),
    status_lapangan VARCHAR2(20)
);
/

-- 2?? Buat tipe tabel dari objek di atas (untuk menampung banyak baris)
CREATE OR REPLACE TYPE KABEL_TAB_SQL AS TABLE OF KABEL_OBJ;
/
