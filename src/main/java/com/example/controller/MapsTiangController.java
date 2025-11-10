package com.example.controller;

import com.example.service.DbService;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MapsTiangController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("application/json;charset=UTF-8");
        JSONObject result = new JSONObject();

        String act = req.getParameter("act"); // "add" atau "delete"

        try (Connection conn = new DbService().getConnection()) {
            if (conn == null) {
                result.put("success", false);
                result.put("message", "❌ Gagal koneksi ke database!");
            } else if ("add".equalsIgnoreCase(act)) {
                // === TAMBAH TIANG ===
                tambahTiang(req, result, conn);
            } else if ("delete".equalsIgnoreCase(act)) {
                // === HAPUS TIANG ===
                hapusTiang(req, result, conn);
            } else {
                result.put("success", false);
                result.put("message", "❌ Parameter 'act' tidak valid!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "❌ Terjadi kesalahan: " + e.getMessage());
        }

        try (PrintWriter out = resp.getWriter()) {
            out.print(result.toString());
        }
    }

    // =====================================================
    // 🔹 METHOD TAMBAH TIANG
    // =====================================================
    private void tambahTiang(HttpServletRequest req, JSONObject result, Connection conn) {
        try {
            String kategori = "TIANG";
            String spesifikasi = req.getParameter("spesifikasi");
            String kodeSystem = req.getParameter("kode_system");
            String latitude = req.getParameter("latitude");
            String longitude = req.getParameter("longitude");

            String user = "adis"; // nanti bisa diganti session

            // === Ambil Unit dan Wilayah ===
            String sqlUnit = 
                    "SELECT a.UNITUPI, a.UNITAP, a.UNITUP, " +
                    "a.KD_PROV, B.NAMA_PROV PROVINSI, a.KD_KAB,  B.NAMA_KAB KABUPATENKOTA, " +
                    "a.KD_KEC,  B.NAMA_KEC KECAMATAN, a.KD_KEL, B.NAMA_KEL DESAKELURAHAN " +
                    "FROM LISDESBPBL.MASTER_ROLE_PETUGAS a, LISDESBPBL.MASTER_REFF_KELURAHAN b " +
                    "WHERE a.USERNAME = ? AND a.KD_KEL = B.KD_KEL AND A.UNITUP = B.UNITUP";

            try (PreparedStatement psUnit = conn.prepareStatement(sqlUnit)) {
                psUnit.setString(1, user);
                ResultSet rs = psUnit.executeQuery();

                if (!rs.next()) {
                    result.put("success", false);
                    result.put("message", "❌ User tidak ditemukan di MASTER_ROLE_PETUGAS!");
                    return;
                }

                // === Ambil data wilayah ===
                String unitupi = rs.getString("UNITUPI");
                String unitap = rs.getString("UNITAP");
                String unitup = rs.getString("UNITUP");
                String kdProv = rs.getString("KD_PROV");
                String provinsi = rs.getString("PROVINSI");
                String kdKab = rs.getString("KD_KAB");
                String kabupatenKota = rs.getString("KABUPATENKOTA");
                String kdKec = rs.getString("KD_KEC");
                String kecamatan = rs.getString("KECAMATAN");
                String kdKel = rs.getString("KD_KEL");
                String desaKelurahan = rs.getString("DESAKELURAHAN");

                // === SQL INSERT ===
                String sqlInsert = "INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK (" +
                        "UNITUPI, UNITAP, UNITUP, KD_PROV, PROVINSI, KD_KAB, KABUPATENKOTA, " +
                        "KD_KEC, KECAMATAN, KD_KEL, DESAKELURAHAN, KODE_SYSTEM, KATEGORI, SPESIFIKASI, LATITUDE, LONGITUDE, USERID) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                try (PreparedStatement psInsert = conn.prepareStatement(sqlInsert)) {
                    psInsert.setString(1, unitupi);
                    psInsert.setString(2, unitap);
                    psInsert.setString(3, unitup);
                    psInsert.setString(4, kdProv);
                    psInsert.setString(5, provinsi);
                    psInsert.setString(6, kdKab);
                    psInsert.setString(7, kabupatenKota);
                    psInsert.setString(8, kdKec);
                    psInsert.setString(9, kecamatan);
                    psInsert.setString(10, kdKel);
                    psInsert.setString(11, desaKelurahan);
                    psInsert.setString(12, kodeSystem);
                    psInsert.setString(13, kategori);
                    psInsert.setString(14, spesifikasi);
                    psInsert.setString(15, latitude);
                    psInsert.setString(16, longitude);
                    psInsert.setString(17, user);

                    int row = psInsert.executeUpdate();
                    result.put("success", row > 0);
                    result.put("message", row > 0
                            ? "✅ Tiang berhasil disimpan!"
                            : "❌ Gagal menyimpan tiang!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "❌ Gagal tambah tiang: " + e.getMessage());
        }
    }

    // =====================================================
    // 🔹 METHOD HAPUS TIANG
    // =====================================================
    private void hapusTiang(HttpServletRequest req, JSONObject result, Connection conn) {
        try {
            String idTiang = req.getParameter("id_tiang");

            if (idTiang == null || idTiang.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "❌ Parameter id_tiang wajib diisi!");
                return;
            }

            String sqlDelete = "DELETE FROM LISDESBPBL.TRANS_JARINGAN_LISTRIK WHERE ID_JARINGAN = ?";
            try (PreparedStatement psDel = conn.prepareStatement(sqlDelete)) {
                psDel.setString(1, idTiang);
                int rows = psDel.executeUpdate();

                if (rows > 0) {
                    result.put("success", true);
                    result.put("message", "✅ Tiang berhasil dihapus!");
                } else {
                    result.put("success", false);
                    result.put("message", "❌ Tiang tidak ditemukan!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "❌ Gagal menghapus tiang: " + e.getMessage());
        }
    }
}
