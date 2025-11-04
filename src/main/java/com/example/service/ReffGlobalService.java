package com.example.service;

import oracle.jdbc.OracleTypes;
import java.sql.*;
import java.util.*;
import javax.sql.DataSource;

public class ReffGlobalService {
    private final DataSource dataSource;

    public ReffGlobalService(DataSource dataSource) {
         this.dataSource = dataSource;
    }

    public List<Map<String, Object>> getDataUnitUPI(String kd_dist) throws SQLException {
        List<Map<String, Object>> resultList = new ArrayList<>();

        try (
            Connection conn = dataSource.getConnection();
            CallableStatement stmt = conn.prepareCall("{call OPHARTDE.VER_MON_LAP.GET_combo_UNITUPI(?, ?, ?)}")
        ) {
            // Jika ALL/null → ambil semua distribusi
            if (kd_dist == null || kd_dist.trim().isEmpty() || "ALL".equalsIgnoreCase(kd_dist)) {
                stmt.setNull(1, Types.VARCHAR);
            } else {
                stmt.setString(1, kd_dist);
            }

            stmt.registerOutParameter(2, OracleTypes.CURSOR);
            stmt.registerOutParameter(3, Types.VARCHAR);
            stmt.execute();

            try (ResultSet rs = (ResultSet) stmt.getObject(2)) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("KD_DIST", rs.getString("KD_DIST"));
                    row.put("NAMA_DIST", rs.getString("NAMA_DIST"));
                    resultList.add(row);
                }
            }
        }

        return resultList;
    }

    public List<Map<String, Object>> getDataAreaUP3(String kd_dist) throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();

        try (
            Connection conn = dataSource.getConnection();
            CallableStatement stmt = conn.prepareCall("{call OPHARTDE.VER_MON_LAP.GET_combo_AREA(?, ?, ?)}")
        ) {
            stmt.setString(1, kd_dist);
            stmt.registerOutParameter(2, OracleTypes.CURSOR);
            stmt.registerOutParameter(3, Types.VARCHAR);
            stmt.execute();

            try (ResultSet rs = (ResultSet) stmt.getObject(2)) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("KD_AREA", rs.getString("KD_AREA"));
                    row.put("NAMA_AREA", rs.getString("NAMA_AREA"));
                    list.add(row);
                }
            }
        }

        return list;
    }

    public List<Map<String, Object>> getMasterBank(String kdbank) throws SQLException {
        List<Map<String, Object>> resultList = new ArrayList<>();

        try (
            Connection conn = dataSource.getConnection();
            CallableStatement stmt = conn.prepareCall("{call OPHARTDE.VER_MON_LAP.GET_combo_BANK_MIV(?, ?, ?)}")
        ) {
            // Jika parameter null, kosong, atau 'SEMUA' → ambil semua data
            if (kdbank == null || kdbank.trim().isEmpty() || "SEMUA".equalsIgnoreCase(kdbank)) {
                stmt.setNull(1, Types.VARCHAR);
            } else {
                stmt.setString(1, kdbank);
            }

            stmt.registerOutParameter(2, OracleTypes.CURSOR);
            stmt.registerOutParameter(3, Types.VARCHAR);
            stmt.execute();

            try (ResultSet rs = (ResultSet) stmt.getObject(2)) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    // gunakan kode ERP sebagai ID bank
                    row.put("KODE_ERP", rs.getString("KODE_ERP"));
                    row.put("KODE_BANK", rs.getString("KODE_BANK"));
                    row.put("NAMA_BANK", rs.getString("NAMA_BANK"));
                    resultList.add(row);
                }
            }
        }

        return resultList;
    }

}
