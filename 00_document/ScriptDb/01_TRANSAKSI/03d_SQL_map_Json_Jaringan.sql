SELECT JSON_ARRAYAGG(
           JSON_OBJECT(
               'id' VALUE id,
               'kode' VALUE kode,
               'tipe' VALUE tipe,
               'kapasitas' VALUE kapasitas,
               'lat' VALUE lat,
               'lon' VALUE lon,
               'parent_id' VALUE parent_id
           )
       ) AS jaringan_json
FROM lisdesbpbl.jaringan_listrik;
