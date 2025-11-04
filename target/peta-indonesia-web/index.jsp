<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Peta Jaringan Listrik</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <style>
        body { font-family: Arial, sans-serif; margin: 10px; background: #f7f7f7; }
        #map { height: 600px; border-radius: 10px; margin-bottom: 20px; }
        h2 { color: #007bff; }
        .legend {
            background: white;
            padding: 10px 12px;
            font-size: 12px;
            line-height: 18px;
            color: #333;
            box-shadow: 0 0 6px rgba(0,0,0,0.3);
            border-radius: 8px;
        }
        .legend img { vertical-align: middle; width: 18px; height: 18px; margin-right: 6px; }
        .legend-line {
            display: inline-block;
            width: 30px; height: 4px;
            margin-right: 6px; vertical-align: middle;
        }
        .label-tiang {
            background-color: rgba(255,255,255,0.9);
            border: 1px solid #007bff;
            padding: 2px 4px;
            border-radius: 4px;
            font-weight: bold;
            color: #007bff;
            font-size: 12px;
        }
    </style>
</head>
<body>
<h2>📡 Peta Jaringan Listrik</h2>
<div id="map"></div>

<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {

    // === Base layer ===
    var defaultMap = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', { maxZoom: 19, attribution: '&copy; OpenStreetMap' });
    var satelliteMap = L.tileLayer('https://{s}.google.com/vt/lyrs=s&x={x}&y={y}&z={z}', { maxZoom: 20, subdomains: ['mt0','mt1','mt2','mt3'], attribution: '&copy; Google Satellite' });

    // === Map Initialization ===
    var map = L.map('map', { center: [-6.2, 106.816], zoom: 13, layers: [defaultMap] });

    // === Layers ===
    var jaringanLayer = L.layerGroup().addTo(map);
    var kabelLayer = L.layerGroup().addTo(map); 

    // === Icons ===
    var icons = {
        gardu_baru: L.icon({ iconUrl: 'assets/icons/TrafoListrik_new64.png', iconSize: [28,28], iconAnchor: [14,28] }),
        gardu_lama: L.icon({ iconUrl: 'assets/icons/TrafoListrik_old64.png', iconSize: [28,28], iconAnchor: [14,28] }),
        tiang_baru: L.icon({ iconUrl: 'assets/icons/TiangListrik_new64.png', iconSize: [28,28], iconAnchor: [14,28] }),
        tiang_lama: L.icon({ iconUrl: 'assets/icons/TiangListrik_old64.png', iconSize: [28,28], iconAnchor: [14,28] }),
        pelanggan_baru: L.icon({ iconUrl: 'assets/icons/PelangganListrik_new64.png', iconSize: [28,28], iconAnchor: [14,28] }),
        pelanggan_lama: L.icon({ iconUrl: 'assets/icons/PelangganListrik_old64.png', iconSize: [28,28], iconAnchor: [14,28] })
    };

    // === Fungsi offset kabel agar TM/TR tidak menumpuk ===
    function offsetLine(lat1, lon1, lat2, lon2, offset){
        var dx = lon2 - lon1;
        var dy = lat2 - lat1;
        var length = Math.sqrt(dx*dx + dy*dy);
        if(length === 0) return [[lat1, lon1],[lat2, lon2]];
        var ox = -dy/length * offset;
        var oy = dx/length * offset;
        return [[lat1+oy, lon1+ox],[lat2+oy, lon2+ox]];
    }

    // === Fetch Data ===
    fetch('api/jaringan')
        .then(res => res.json())
        .then(function(data){
            console.log("✅ Data jaringan:", data);
            var bounds = [];

            // --- Tambah marker TIANG/GARDU/PELANGGAN ---
            data.forEach(function(row){
                var lat = parseFloat(row.latitude);
                var lon = parseFloat(row.longitude);
                if (!lat || !lon) return;

                var kategori = (row.kategori || '').toUpperCase();
                var status = (row.status_lapangan || 'LAMA').toUpperCase();
                var iconKey = '';

                if (kategori === 'GARDU') iconKey = status === 'BARU' ? 'gardu_baru' : 'gardu_lama';
                else if (kategori === 'TIANG') iconKey = status === 'BARU' ? 'tiang_baru' : 'tiang_lama';
                else if (kategori === 'PELANGGAN') iconKey = status === 'BARU' ? 'pelanggan_baru' : 'pelanggan_lama';

                var icon = icons[iconKey];

                var popup = "<b>ID:</b> " + (row.id_jaringan || '-') +
                            "<br><b>Kode:</b> " + (row.kode_system || '-') +
                            "<br><b>Kategori:</b> " + (row.kategori || '-') +
                            "<br><b>Spesifikasi:</b> " + (row.spesifikasi || '-') +
                            "<br><b>Transmisi:</b> " + (row.transmisi || '-') +
                            "<br><b>Status Lapangan:</b> " + (row.status_lapangan || '-') +
                            "<br><b>Latitude:</b> " + (row.latitude || '-') +
                            "<br><b>Longitude:</b> " + (row.longitude || '-');

                var marker = L.marker([lat, lon], {icon: icon}).bindPopup(popup);
                jaringanLayer.addLayer(marker);
                bounds.push([lat, lon]);

                // --- Label khusus TIANG ---
                if (kategori === 'TIANG'){
                    var labelText = (row.kode_system || '-') + " - " + (row.transmisi || '-');
                    marker.bindTooltip(labelText, {
                        permanent: true,
                        direction: 'top',
                        offset: [0, -30],
                        className: 'label-tiang'
                    });
                }
            });

            // --- Gambar kabel antar node ---
            data.forEach(function(row){
                if (row.kategori === 'KABEL' && row.parent_id && row.target_id){
                    var parent = data.find(d => d.id_jaringan === row.parent_id);
                    var target = data.find(d => d.id_jaringan === row.target_id);
                    if (parent && target){
                        var tegangan = (row.transmisi || '').toUpperCase();
                        var status = (row.status_lapangan || '').toUpperCase();
                        var color = '#00bfff'; // default TM
                        var offset = 0;
                        var dashStyle = null; // default garis utuh

                        // --- Prioritas 1: Status LAMA (abu-abu putus-putus)
                        if (status === 'LAMA') {
                            color = '#808080';
                            dashStyle = '5, 8'; // garis putus-putus
                        }
                        // --- Prioritas 2: Transmisi (jika bukan lama)
                        else if (tegangan === 'TT') {
                            color = '#ff6600'; // oranye
                        }
                        else if (tegangan === 'TM') {
                            color = '#00bfff'; // biru muda
                        }
                        else if (tegangan === 'TR') {
                            color = '#32cd32'; // hijau
                        }

                        // --- Offset agar garis TM/TR tidak menumpuk
                        if (tegangan === 'TM') offset = 0.00005;
                        else if (tegangan === 'TR') offset = -0.00005;

                        var lineCoords = offsetLine(parent.latitude, parent.longitude, target.latitude, target.longitude, offset);

                        var line = L.polyline(lineCoords, { 
                            color: color, 
                            weight: 3, 
                            dashArray: dashStyle 
                        })
                        .bindPopup(
                            "<b>Kabel:</b> " + (row.kode_system || '-') +
                            "<br><b>Dari:</b> " + (parent.kode_system || '-') +
                            "<br><b>Ke:</b> " + (target.kode_system || '-') +
                            "<br><b>Tegangan:</b> " + (row.transmisi || '-') +
                            "<br><b>Spesifikasi:</b> " + (row.spesifikasi || '-') +
                            "<br><b>Status Lapangan:</b> " + (row.status_lapangan || '-')
                        );

                        kabelLayer.addLayer(line);
                    }
                }
            });

            if(bounds.length>0) map.fitBounds(bounds, {padding:[40,40]});
        })
        .catch(err => console.error("❌ Gagal memuat data jaringan:", err));

    // === Layer Control ===
    var baseMaps = { "Default": defaultMap, "Satelit": satelliteMap };
    var overlayMaps = { "Jaringan Listrik": jaringanLayer, "Kabel": kabelLayer };
    L.control.layers(baseMaps, overlayMaps, {collapsed: false}).addTo(map);

    // === Legend ===
    var legend = L.control({ position: 'bottomleft' });
    legend.onAdd = function(){
        var div = L.DomUtil.create('div', 'legend');
        div.innerHTML = "<b>Keterangan:</b><br>" +
                        "<img src='assets/icons/TrafoListrik_new64.png'> Gardu Baru<br>" +
                        "<img src='assets/icons/TrafoListrik_old64.png'> Gardu Lama<br>" +
                        "<img src='assets/icons/TiangListrik_new64.png'> Tiang Baru<br>" +
                        "<img src='assets/icons/TiangListrik_old64.png'> Tiang Lama<br>" +
                        "<img src='assets/icons/PelangganListrik_new64.png'> Pelanggan Baru<br>" +
                        "<img src='assets/icons/PelangganListrik_old64.png'> Pelanggan Lama<br><hr>" +
                        "<div><span class='legend-line' style='background:#ff6600'></span> TT (Tegangan Tinggi)</div>" +
                        "<div><span class='legend-line' style='background:#00bfff'></span> TM (Tegangan Menengah)</div>" +
                        "<div><span class='legend-line' style='background:#32cd32'></span> TR (Tegangan Rendah)</div>" +
                        "<div><span class='legend-line' style='background:#808080; border:1px dashed #808080'></span> Lama</div>";
        return div;
    };
    legend.addTo(map);

});
</script>
</body>
</html>
