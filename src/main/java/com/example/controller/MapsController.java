package com.example.controller;

import com.example.service.DbService;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedHashMap;
import java.util.Map;

public class MapsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("application/json;charset=UTF-8");
        JSONArray jsonArray = new JSONArray();
        Map<Integer, String> kodeById = new LinkedHashMap<>();

        System.out.println("📡 [MapsController] Mulai proses /api/jaringan...");

        String sql =
            "SELECT LEVEL AS level_data, " +
            "       ID_JARINGAN, kode_system, kode_lapangan, parent_id, target_id, " +
            "       unitupi, unitap, unitup, " +
            "       KATEGORI, SPESIFIKASI, LATITUDE, LONGITUDE, " +
            "       transmisi, status_lapangan, status_kontrak, " +
            "       (VOLUME||' '||KDSATUAN) as satuan, rupiah_satuan, " +
            "       tglinsert, tglkoreksi, keterangan, " +
            "       PROVINSI,  KABUPATENKOTA , KECAMATAN, DESAKELURAHAN " +
            "FROM lisdesbpbl.trans_jaringan_listrik " +
            "START WITH parent_id IS NULL " +
            "CONNECT BY PRIOR ID_JARINGAN = parent_id " +
            "ORDER SIBLINGS BY kode_system";

        try (Connection conn = new DbService().getConnection()) {
            if (conn == null) {
                System.err.println("❌ Gagal membuat koneksi ke database (conn = null)");
                return;
            }

            System.out.println("✅ Koneksi database berhasil dibuat.");
            System.out.println("🧩 Menjalankan SQL: " + sql);

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            int count = 0;
            while (rs.next()) {
                int id = rs.getInt("ID_JARINGAN");
                String kodeSystem = rs.getString("kode_system");
                kodeById.put(id, kodeSystem);

                JSONObject obj = new JSONObject();
                obj.put("id_jaringan", id);
                obj.put("kode_system", kodeSystem);
                obj.put("kode_lapangan", rs.getString("kode_lapangan"));
                obj.put("unitupi", rs.getString("unitupi"));
                obj.put("unitap", rs.getString("unitap"));
                obj.put("unitup", rs.getString("unitup"));
                obj.put("kategori", rs.getString("kategori"));
                obj.put("spesifikasi", rs.getString("spesifikasi"));
                obj.put("latitude", rs.getObject("latitude"));
                obj.put("longitude", rs.getObject("longitude"));
                obj.put("transmisi", rs.getString("transmisi"));
                obj.put("status_lapangan", rs.getString("status_lapangan"));
                obj.put("status_kontrak", rs.getString("status_kontrak"));
                obj.put("satuan", rs.getString("satuan"));
                obj.put("rupiah_satuan", rs.getObject("rupiah_satuan"));
                obj.put("tglinsert", rs.getString("tglinsert"));
                obj.put("tglkoreksi", rs.getString("tglkoreksi"));
                obj.put("keterangan", rs.getString("keterangan"));
                obj.put("level_data", rs.getInt("level_data"));
                obj.put("target_id", rs.getObject("target_id"));
                obj.put("PROVINSI", rs.getObject("PROVINSI"));
                obj.put("KABUPATENKOTA", rs.getObject("KABUPATENKOTA"));
                obj.put("KECAMATAN", rs.getObject("KECAMATAN"));
                obj.put("DESAKELURAHAN", rs.getObject("DESAKELURAHAN"));

                // Mapping parent
                Object parentIdObj = rs.getObject("parent_id");
                if (parentIdObj != null) {
                    int pid = ((Number) parentIdObj).intValue();
                    obj.put("parent_id", pid);
                    obj.put("parent_kode", kodeById.getOrDefault(pid, ""));
                } else {
                    obj.put("parent_id", JSONObject.NULL);
                    obj.put("parent_kode", "");
                }

                jsonArray.put(obj);
                count++;
            }

            System.out.println("📊 Jumlah data ditemukan: " + count);

        } catch (Exception e) {
            System.err.println("🔥 ERROR di MapsController.doGet()");
            e.printStackTrace();
        }

        try (PrintWriter out = resp.getWriter()) {
            out.print(jsonArray.toString());
        }
    }
}
