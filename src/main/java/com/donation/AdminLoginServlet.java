package com.donation;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import java.io.IOException;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String password = request.getParameter("password");
        String expected = System.getenv("ADMIN_PASSWORD");
        if (expected == null || expected.isBlank()) {
            expected = "admin123"; // Local demo default; change before any shared/production deployment.
        }

        if (password != null && constantTimeEquals(password, expected)) {
            request.getSession(true).setAttribute("givehopeAdmin", Boolean.TRUE);
            response.sendRedirect(request.getContextPath() + "/admin");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin-login.jsp?error=1");
        }
    }

    private boolean constantTimeEquals(String a, String b) {
        return java.security.MessageDigest.isEqual(
                a.getBytes(java.nio.charset.StandardCharsets.UTF_8),
                b.getBytes(java.nio.charset.StandardCharsets.UTF_8));
    }
}
