package com.example.maps;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/api/maps/info")
public class MapController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        double lat = Double.parseDouble(request.getParameter("lat"));
        double lon = Double.parseDouble(request.getParameter("lon"));

        String json;
        if (lat < -5 && lon > 105 && lon < 111) {
            json = "{\"kota\":\"Jawa Barat\",\"info\":\"Wilayah padat\",\"warna\":\"#ff0000\"}";
        } else {
            json = "{\"kota\":\"Luar Jawa\",\"info\":\"Wilayah umum\",\"warna\":\"#00ff00\"}";
        }

        response.setContentType("application/json");
        response.getWriter().write(json);
    }
}
