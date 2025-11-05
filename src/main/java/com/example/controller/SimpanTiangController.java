package com.example.controller;

import com.example.service.DbService;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 * Controller untuk menyimpan titik Tiang baru ke tabel TRANS_JARINGAN_LISTRIK
 */
@WebServlet("/simpanTiang")
public class SimpanTiangController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("application/json;charset=UTF-8");
        JSONObject result = new JSONObject();

        try (BufferedReader reader = req.getReader()) {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) sb.append(line);

            JSONObject input = new JSONObject(sb.toString());
            System.out.println("📥 [SimpanTiangController] Data diterima: " + input);

            String kategori = input.optString("kategori", "TIANG");
            String spesifikasi = input.optString("spesifikasi", "Tiang Baja 9 m");
            String transmisi = input.optString("transmisi", "TR");
            String status = input.optString("status_lapangan", "BARU");
            double latitude = input.optDouble("latitude");
            double longitude = input.optDouble("longitude");

            // --- SQL Insert ---
            String sql = "INSERT INTO LISDESBPBL.TRANS_JARINGAN_LISTRIK " +
                    "(KATEGORI, SPESIFIKASI, TRANSMISI, STATUS_LAPANGAN, LATITUDE, LONGITUDE) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";

            try (Connection conn = new DbService().getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setString(1, kategori);
                ps.setString(2, spesifikasi);
                ps.setString(3, transmisi);
                ps.setString(4, status);
                ps.setDouble(5, latitude);
                ps.setDouble(6, longitude);

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    result.put("success", true);
                    result.put("message", "✅ Tiang baru berhasil disimpan!");
                    System.out.println("✅ Data tiang tersimpan di DB (" + latitude + ", " + longitude + ")");
                } else {
                    result.put("success", false);
                    result.put("message", "❌ Gagal menyimpan data tiang.");
                }

            } catch (Exception e) {
                e.printStackTrace();
                result.put("success", false);
                result.put("message", "❌ Error DB: " + e.getMessage());
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            result.put("success", false);
            result.put("message", "❌ Error parsing data: " + ex.getMessage());
        }

        try (PrintWriter out = resp.getWriter()) {
            out.print(result.toString());
        }
    }
}
