package JDBCConnection;

import java.sql.Connection;
import java.sql.DriverManager;
// Removed DriverManager import
import java.sql.SQLException;

public class ConnectionFactory {
    private static ConnectionFactory connectionFactory = null;
    private static Connection con = null;
    private String username = "root";
    private String password = "root";
    private String url = "jdbc:mysql://localhost:3306/onlinespareparts";
    private String driverClass = "com.mysql.cj.jdbc.Driver";
    
    // Private constructor to implement Singleton pattern
    private ConnectionFactory() throws ClassNotFoundException, SQLException {
        Class.forName(driverClass);
        createConnection();
    }
    
    private void createConnection() throws SQLException {
        con = DriverManager.getConnection(url, username, password);
        System.out.println("Database connected successfully!");
    }

    // Method to check if the connection is still valid
    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        if (connectionFactory == null) {
            connectionFactory = new ConnectionFactory();
        }
        if (con == null || con.isClosed()) {
            connectionFactory.createConnection();
        }
        return con;
    }
}
