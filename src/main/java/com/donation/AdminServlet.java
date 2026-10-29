package com.donation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!Boolean.TRUE.equals(request.getSession(false) == null ? null
                : request.getSession(false).getAttribute("givehopeAdmin"))) {
            response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
            return;
        }

        List<Map<String, Object>> donations = new ArrayList<>();
        int count = 0;
        java.math.BigDecimal total = java.math.BigDecimal.ZERO;
        try {
            DBUtil.ensureTable();
            try (Connection c = DBUtil.getConnection();
                 PreparedStatement summary = c.prepareStatement(
                         "SELECT COUNT(*) AS donation_count, COALESCE(SUM(amount), 0) AS total_amount FROM donations");
                 ResultSet rs = summary.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt("donation_count");
                    total = rs.getBigDecimal("total_amount");
                }
            }
            try (Connection c = DBUtil.getConnection();
                 PreparedStatement query = c.prepareStatement(
                         "SELECT id, donor_name, donor_email, amount, message, payment_status, created_at FROM donations ORDER BY created_at DESC, id DESC");
                 ResultSet rs = query.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new LinkedHashMap<>();
                    row.put("id", rs.getLong("id"));
                    row.put("name", rs.getString("donor_name"));
                    row.put("email", rs.getString("donor_email"));
                    row.put("amount", rs.getBigDecimal("amount"));
                    row.put("message", rs.getString("message"));
                    row.put("status", rs.getString("payment_status"));
                    row.put("createdAt", rs.getTimestamp("created_at"));
                    donations.add(row);
                }
            }
        } catch (SQLException ex) {
            log("Could not load admin dashboard", ex);
            request.setAttribute("dbError", "Database connection failed. Check MySQL and DB_URL/DB_USER/DB_PASSWORD.");
        }
        request.setAttribute("donations", donations);
        request.setAttribute("donationCount", count);
        request.setAttribute("totalAmount", total);
        request.getRequestDispatcher("/admin.jsp").forward(request, response);
    }
}
