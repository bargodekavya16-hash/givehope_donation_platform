package com.donation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/donate")
public class DonateServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name = trim(request.getParameter("name"));
        String email = trim(request.getParameter("email"));
        String amountText = trim(request.getParameter("amount"));
        String message = trim(request.getParameter("message"));

        if (name.isEmpty() || email.isEmpty() || amountText.isEmpty()
                || !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Please enter a name, valid email address and donation amount.");
            return;
        }

        BigDecimal amount;
        try {
            amount = new BigDecimal(amountText);
            if (amount.compareTo(BigDecimal.ONE) < 0 || amount.compareTo(new BigDecimal("1000000")) > 0
                    || amount.scale() > 2) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException ex) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Donation amount must be between 1 and 1,000,000, with up to 2 decimal places.");
            return;
        }

        try {
            DBUtil.ensureTable();
            String sql = "INSERT INTO donations (donor_name, donor_email, amount, message, payment_status) VALUES (?, ?, ?, ?, 'DEMO_RECORDED')";
            try (Connection connection = DBUtil.getConnection();
                 PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, name);
                statement.setString(2, email);
                statement.setBigDecimal(3, amount);
                statement.setString(4, message.isEmpty() ? null : message);
                statement.executeUpdate();
            }
            request.setAttribute("donorName", name);
            request.setAttribute("donationAmount", amount.toPlainString());
            request.getRequestDispatcher("/success.jsp").forward(request, response);
        } catch (SQLException ex) {
            log("Could not save donation", ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Could not save the donation. Check that MySQL is running and DB settings are correct.");
        }
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
