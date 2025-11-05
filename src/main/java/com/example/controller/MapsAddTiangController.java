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

public class MapsAddTiangController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("application/json;charset=UTF-8");
        JSONObject result = new JSONObject();

        try (Connection conn = new DbService().getConnection()) {
            if (conn == null) {
                result.put("success", false);
                result.put("message", "❌ Gagal koneksi ke database!");
            } else {
                // === Parameter dari frontend ===
                String kategori = "TIANG";
                String spesifikasi = req.getParameter("spesifikasi");
                String kodeSystem = req.getParameter("kode_system");
                String latitude = req.getParameter("latitude");
                String longitude = req.getParameter("longitude");

                // === Ambil unit & wilayah berdasarkan user ===
                String user = "adis"; // bisa diganti dengan user session/login
                String sqlUnit =    "SELECT a.ID_ROLE, a.USERNAME, a.ROLE_NAME,                                 "+ 
                                    "     a.UNITUPI, a.UNITAP, a.UNITUP,                                        "+ 
                                    "     a.KD_PROV, B.NAMA_PROV PROVINSI, a.KD_KAB,  B.NAMA_KAB KABUPATENKOTA, "+ 
                                    "     a.KD_KEC,  B.NAMA_KEC KECAMATAN, a.KD_KEL, B.NAMA_KEL DESAKELURAHAN,  "+ 
                                    "     B.UNITUP UP,                                                          "+
                                    "     a.STATUS, a.CREATED_AT                                                "+ 
                                    "FROM LISDESBPBL.MASTER_ROLE_PETUGAS a, LISDESBPBL.MASTER_REFF_KELURAHAN b  "+
                                    "WHERE a.USERNAME = ?                                                       "+  
                                    "AND a.KD_KEL = B.KD_KEL                                                    "+
                                    "AND A.UNITUP = B.UNITUP                                                    ";

                try (PreparedStatement psUnit = conn.prepareStatement(sqlUnit)) {
                    psUnit.setString(1, user);
                    ResultSet rs = psUnit.executeQuery();

                    if (!rs.next()) {
                        result.put("success", false);
                        result.put("message", "❌ User tidak ditemukan di MASTER_ROLE_PETUGAS!");
                        try (PrintWriter out = resp.getWriter()) {
                            out.print(result.toString());
                        }
                        return;
                    }

                    String unitupi = rs.getString("UNITUPI");
                    String unitap = rs.getString("UNITAP");
                    String unitup = rs.getString("UNITUP");
                    String kdProv = rs.getString("KD_PROV");
                    String provinsi = rs.getString("PROVINSI");
                    String kdKab = rs.getString("KD_KAB");
                    String kabupatenKota = rs.getString("KABUPATENKOTA");   // nama kolom sesuai DB
                    String kdKec = rs.getString("KD_KEC");
                    String kecamatan = rs.getString("KECAMATAN");
                    String kdKel = rs.getString("KD_KEL");
                    String desaKelurahan = rs.getString("DESAKELURAHAN");    // nama kolom sesuai DB

                    // === Log hasil ambil unit & wilayah ===
                    System.out.println("=== LOG MASTER_ROLE_PETUGAS ===");
                    System.out.println("UNITUPI = " + unitupi);
                    System.out.println("UNITAP = " + unitap);
                    System.out.println("UNITUP = " + unitup);
                    System.out.println("KD_PROV = " + kdProv);
                    System.out.println("PROVINSI = " + provinsi);
                    System.out.println("KD_KAB = " + kdKab);
                    System.out.println("KABUPATENKOTA = " + kabupatenKota);
                    System.out.println("KD_KEC = " + kdKec);
                    System.out.println("KECAMATAN = " + kecamatan);
                    System.out.println("KD_KEL = " + kdKel);
                    System.out.println("DESAKELURAHAN = " + desaKelurahan);
                    System.out.println("==============================");

                    // === SQL Insert ===
                    String sqlInsert = "INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK ("
                            + "UNITUPI, UNITAP, UNITUP, KD_PROV, PROVINSI, KD_KAB, KABUPATENKOTA, "
                            + "KD_KEC, KECAMATAN, KD_KEL, DESAKELURAHAN, KODE_SYSTEM, KATEGORI, SPESIFIKASI, LATITUDE, LONGITUDE,"
                            + " USERID) "
                            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                    // === Log parameter ===
                    String[] params = new String[] {
                            unitupi, unitap, unitup, kdProv, provinsi, kdKab, kabupatenKota,
                            kdKec, kecamatan, kdKel, desaKelurahan, kodeSystem, kategori, spesifikasi, latitude, longitude,
                            user
                    };
                    System.out.println("=== LOG SQL INSERT TIANG ===");
                    for (int i = 0; i < params.length; i++) {
                        System.out.println("Parameter " + (i+1) + " = " + params[i]);
                    }
                    System.out.println("=============================");

                    try (PreparedStatement psInsert = conn.prepareStatement(sqlInsert)) {
                        for (int i = 0; i < params.length; i++) {
                            psInsert.setString(i + 1, params[i]);
                        }

                        int row = psInsert.executeUpdate();
                        result.put("success", row > 0);
                        if (row > 0) {
                            result.put("message", "✅ Tiang berhasil disimpan!");
                        } else {
                            result.put("message", "❌ Gagal menyimpan tiang! Tidak ada baris yang di-insert.");
                        }
                    } catch (Exception sqle) {
                        sqle.printStackTrace();
                        result.put("success", false);
                        result.put("message", "❌ Gagal menyimpan tiang! SQL Error: " + sqle.getMessage());
                    }
                }
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
}
