package com.donation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Small JDBC helper for a local learning/demo project.
 * Configure DB_URL, DB_USER and DB_PASSWORD as environment variables when possible.
 */
public final class DBUtil {
    private static final String URL = env("DB_URL", "jdbc:mysql://localhost:3306/donation_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC");
    private static final String USER = env("DB_USER", "root");
    private static final String PASSWORD = env("DB_PASSWORD", "");

    private DBUtil() {}

    private static String env(String key, String fallback) {
        String value = System.getenv(key);
        return value == null ? fallback : value;
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    /** Creates the table if the SQL script has not been run yet. The database itself must exist. */
    public static void ensureTable() throws SQLException {
        String sql = """
            CREATE TABLE IF NOT EXISTS donations (
              id BIGINT PRIMARY KEY AUTO_INCREMENT,
              donor_name VARCHAR(100) NOT NULL,
              donor_email VARCHAR(190) NOT NULL,
              amount DECIMAL(10,2) NOT NULL,
              message VARCHAR(500),
              payment_status VARCHAR(30) NOT NULL DEFAULT 'DEMO_RECORDED',
              created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
            )
            """;
        try (Connection c = getConnection(); Statement s = c.createStatement()) {
            s.executeUpdate(sql);
        }
    }
}
