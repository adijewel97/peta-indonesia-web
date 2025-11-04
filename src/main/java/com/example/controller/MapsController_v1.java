package com.example.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class MapsController_v1 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.getWriter().write("{\"status\": \"ok\", \"message\": \"Hello from MapsController\"}");
    }
}
