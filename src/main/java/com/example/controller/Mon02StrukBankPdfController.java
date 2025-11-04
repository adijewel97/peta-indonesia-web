package com.example.controller;

import com.example.utils.FTPUtil;
import com.example.utils.LoggerUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/mon2strukbank/list")
public class Mon02StrukBankPdfController extends HttpServlet {

    private static final Logger logger = LoggerUtil.getLogger(Mon02StrukBankPdfController.class);
    private final FTPUtil ftpUtil = new FTPUtil("10.71.1.177", 21, "rekon", "rekon");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        logger.info("=== [START] Mon02StrukMivBankPdfListController.doGet ===");
        response.setContentType("application/json;charset=UTF-8");

        try {
            String remoteDir = "/vertikal/2000001/200CA01/POSTPAID/lunas/struk";
            List<String> files = ftpUtil.listAllFiles(remoteDir);
            logger.info("Jumlah file ditemukan: " + (files != null ? files.size() : 0));

            // Convert List<String> ke JSON manual
            StringBuilder json = new StringBuilder("[");
            if (files != null && !files.isEmpty()) {
                for (int i = 0; i < files.size(); i++) {
                    json.append("\"").append(files.get(i)).append("\"");
                    if (i < files.size() - 1) json.append(",");
                }
            }
            json.append("]");

            response.getWriter().write(json.toString());
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Gagal ambil daftar file dari FTP", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }

        logger.info("=== [END] Mon02StrukMivBankPdfListController.doGet ===");
    }
}

