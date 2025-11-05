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
        #btnTambahTiang, #btnToggleMap {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 14px;
            border-radius: 6px;
            cursor: pointer;
            margin-right: 8px;
        }
        #btnTambahTiang:hover, #btnToggleMap:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<h2>📡 Peta Jaringan Listrik</h2>
<button id="btnTambahTiang">➕ Tambah Tiang Baru</button>
<button id="btnToggleMap">🌎 Ganti ke Satelit</button>
<div id="map"></div>

<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {

    // ====== Inisialisasi peta ======
    var defaultMap = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', { maxZoom: 19 });
    var satelliteMap = L.tileLayer('https://{s}.google.com/vt/lyrs=s&x={x}&y={y}&z={z}', { 
        maxZoom: 20, subdomains: ['mt0','mt1','mt2','mt3'] 
    });

    var currentBase = 'default';
    var map = L.map('map', { center: [-6.2, 106.816], zoom: 13, layers: [defaultMap] });

    var garduLayer = L.layerGroup().addTo(map);
    var tiangLayer = L.layerGroup().addTo(map);
    var pelangganLayer = L.layerGroup().addTo(map);
    var kabelLayer = L.layerGroup().addTo(map);

    // ====== Icon Marker ======
    var icons = {
        gardu_baru: L.icon({ iconUrl: 'assets/icons/TrafoListrik_new64.png', iconSize: [28,28], iconAnchor: [14,28] }),
        gardu_lama: L.icon({ iconUrl: 'assets/icons/TrafoListrik_old64.png', iconSize: [28,28], iconAnchor: [14,28] }),
        tiang_baru: L.icon({ iconUrl: 'assets/icons/TiangListrik_new64.png', iconSize: [28,28], iconAnchor: [14,28] }),
        tiang_lama: L.icon({ iconUrl: 'assets/icons/TiangListrik_old64.png', iconSize: [28,28], iconAnchor: [14,28] }),
        pelanggan_baru: L.icon({ iconUrl: 'assets/icons/PelangganListrik_new64.png', iconSize: [28,28], iconAnchor: [14,28] }),
        pelanggan_lama: L.icon({ iconUrl: 'assets/icons/PelangganListrik_old64.png', iconSize: [28,28], iconAnchor: [14,28] })
    };

    var newMarker = null;
    var tambahTiangMode = false;

    // ====== Fungsi utama memuat data jaringan ======
    function loadJaringan() {
        garduLayer.clearLayers();
        tiangLayer.clearLayers();
        pelangganLayer.clearLayers();
        kabelLayer.clearLayers();

        fetch('api/jaringan')
            .then(res => res.json())
            .then(function(data){
                console.log("✅ Data jaringan:", data);
                var bounds = [];

                data.forEach(function(row){
                    var kategori = (row.kategori || '').toUpperCase();
                    var status = (row.status_lapangan || 'LAMA').toUpperCase();

                    // ====== Kabel (garis) ======
                    if (kategori === 'KABEL') {
                        var lat1 = parseFloat(row.lat_awal);
                        var lon1 = parseFloat(row.lon_awal);
                        var lat2 = parseFloat(row.lat_akhir);
                        var lon2 = parseFloat(row.lon_akhir);

                        if (!lat1 || !lon1 || !lat2 || !lon2) return;

                        var transmisi = (row.transmisi || '').toUpperCase();
                        var color = '#808080'; // default abu-abu

                        if (status === 'BARU') {
                            if (transmisi === 'TT') color = '#ff6600'; // oranye
                            else if (transmisi === 'TM') color = '#00bfff'; // biru muda
                            else if (transmisi === 'TR') color = '#32cd32'; // hijau
                        }

                        var polyline = L.polyline([[lat1, lon1], [lat2, lon2]], {
                            color: color,
                            weight: status === 'BARU' ? 4 : 2,
                            opacity: status === 'BARU' ? 0.9 : 0.6,
                            dashArray: (status === 'LAMA' ? '6, 6' : null)
                        }).bindPopup(
                            "<b>KABEL</b><br>" +
                            "ID: " + (row.id_jaringan || '-') + "<br>" +
                            "Transmisi: " + (row.transmisi || '-') + "<br>" +
                            "Status: " + (row.status_lapangan || '-') + "<br>" +
                            "Koordinat Awal: " + lat1 + ", " + lon1 + "<br>" +
                            "Koordinat Akhir: " + lat2 + ", " + lon2
                        );

                        kabelLayer.addLayer(polyline);
                        bounds.push([lat1, lon1]);
                        bounds.push([lat2, lon2]);
                        return;
                    }

                    // ====== Marker Gardu / Tiang / Pelanggan ======
                    var lat = parseFloat(row.latitude);
                    var lon = parseFloat(row.longitude);
                    if (!lat || !lon) return;

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
                    bounds.push([lat, lon]);

                    // Klik kanan untuk hapus tiang
                    if (kategori === 'TIANG') {
                        marker.on('contextmenu', function(e){
                            if (!row.id_jaringan) {
                                alert("❌ ID jaringan tidak ditemukan!");
                                return;
                            }
                            var confirmDelete = confirm("⚠️ Hapus tiang ini?\nID: " + row.id_jaringan);
                            if (confirmDelete) {
                                fetch('api/maps/tiang?act=delete', {
                                    method: 'POST',
                                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                                    body: "id_tiang=" + encodeURIComponent(row.id_jaringan)
                                })
                                .then(r => r.json())
                                .then(res => {
                                    if (res.success) {
                                        alert("✅ Tiang berhasil dihapus!");
                                        loadJaringan();
                                    } else {
                                        alert("❌ " + (res.message || "Gagal menghapus tiang!"));
                                    }
                                })
                                .catch(err => {
                                    console.error(err);
                                    alert("❌ Terjadi kesalahan saat menghapus tiang!");
                                });
                            }
                        });

                        var labelText = (row.kode_system || '-') + " - " + (row.transmisi || '-');
                        marker.bindTooltip(labelText, {
                            permanent: true, direction: 'top', offset: [0, -30], className: 'label-tiang'
                        });
                    }

                    if (kategori === 'GARDU') garduLayer.addLayer(marker);
                    else if (kategori === 'TIANG') tiangLayer.addLayer(marker);
                    else if (kategori === 'PELANGGAN') pelangganLayer.addLayer(marker);
                });

                if(bounds.length>0) map.fitBounds(bounds, {padding:[40,40]});
            })
            .catch(err => console.error("❌ Gagal memuat data jaringan:", err));
    }

    // ====== Control Layer ======
    var baseMaps = { "🗺️ Peta Standar": defaultMap, "🌎 Satelit": satelliteMap };
    var overlayMaps = { "Gardu": garduLayer, "Tiang": tiangLayer, "Pelanggan": pelangganLayer, "Kabel": kabelLayer };
    L.control.layers(baseMaps, overlayMaps, {collapsed: false}).addTo(map);

    loadJaringan();

    // ====== Mode Tambah Tiang ======
    document.getElementById('btnTambahTiang').addEventListener('click', function(){
        tambahTiangMode = true;
        alert("📍 Klik di peta untuk menambahkan titik tiang baru");
    });

    map.on('click', function(e){
        if(!tambahTiangMode) return;
        var lat = e.latlng.lat.toFixed(6);
        var lon = e.latlng.lng.toFixed(6);

        if(newMarker) map.removeLayer(newMarker);
        newMarker = L.marker([lat, lon], {icon: icons.tiang_baru}).addTo(map);
        newMarker.bindPopup(
            "<div class='popup-content'>" +
            "<b>Tambah Tiang Baru</b><br>" +
            "Lat: " + lat + "<br>" +
            "Lon: " + lon + "<br><br>" +
            "<button id='btnSimpanTiang'>💾 Simpan ke Database</button>" +
            "</div>"
        ).openPopup();
        tambahTiangMode = false;
    });

    // ====== Simpan Tiang Baru ======
    map.on('popupopen', function(e){
        var popupNode = e.popup.getElement();
        if(!popupNode) return;
        var simpanBtn = popupNode.querySelector('#btnSimpanTiang');
        if(simpanBtn){
            simpanBtn.addEventListener('click', function(){
                var lat = e.popup._source.getLatLng().lat;
                var lon = e.popup._source.getLatLng().lng;
                var formData = new URLSearchParams();
                formData.append("latitude", lat);
                formData.append("longitude", lon);
                formData.append("kategori", "TIANG");
                formData.append("spesifikasi", "Tiang Baja 9 m");
                formData.append("kode_system", "AUTO_TG_" + Date.now());

                fetch('api/maps/tiang?act=add', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: formData.toString()
                })
                .then(r => r.json())
                .then(res => {
                    if(res.success){
                        alert("✅ Tiang berhasil disimpan!");
                        loadJaringan();
                    } else {
                        alert("❌ Gagal menyimpan tiang!");
                    }
                })
                .catch(err => {
                    console.error(err);
                    alert("❌ Terjadi kesalahan saat menyimpan!");
                });
            });
        }
    });

    // ====== Ganti Layer Peta ======
    document.getElementById('btnToggleMap').addEventListener('click', function(){
        if(currentBase === 'default'){
            map.removeLayer(defaultMap);
            map.addLayer(satelliteMap);
            currentBase = 'satellite';
            this.innerText = "🗺️ Ganti ke Peta Standar";
        } else {
            map.removeLayer(satelliteMap);
            map.addLayer(defaultMap);
            currentBase = 'default';
            this.innerText = "🌎 Ganti ke Satelit";
        }
    });

    // ====== Legenda ======
    var legend = L.control({ position: 'bottomleft' });
    legend.onAdd = function(){
        var div = L.DomUtil.create('div', 'legend');
        div.innerHTML = "<b>Keterangan:</b><br>" +
                        "<img src='assets/icons/TrafoListrik_new64.png'> Gardu Baru<br>" +
                        "<img src='assets/icons/TiangListrik_new64.png'> Tiang Baru<br>" +
                        "<img src='assets/icons/PelangganListrik_new64.png'> Pelanggan Baru<br><hr>" +
                        "<div><span class='legend-line' style='background:#ff6600'></span> TT</div>" +
                        "<div><span class='legend-line' style='background:#00bfff'></span> TM</div>" +
                        "<div><span class='legend-line' style='background:#32cd32'></span> TR</div>" +
                        "<div><span class='legend-line' style='background:#808080; border:1px dashed #808080'></span> Kabel Lama</div>";
        return div;
    };
    legend.addTo(map);
});
</script>
</body>
</html>
