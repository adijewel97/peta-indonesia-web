select count(*) jml,-- a.idpel, a.blth, 
       a.nousulan, tglusulan, tglinsert, b.tgltrans, b.tglbayar, b.userid
from OPHARTDE.VER_TEMP_DATA_LOCKING a, plngatepost.dpp b
where to_char(a.tglinsert,'YYYYMM') = '202510'
and a.KDPROSES = '2'
and a.KDBANK   = '200'
and a.idpel = b.idpel
and a.blth  = b.blth
and b.tgltrans = '20251101'
group by a.nousulan, tglusulan, tglinsert, b.tgltrans, b.tglbayar, b.userid