package Persistencia;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class datos {

    private Connection conn;

    public Connection getConn() {
        return conn;
    }

    public datos() {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("❌ Error cargando el driver de PostgreSQL");
            e.printStackTrace();
        }
    }

    public datos(String URL, String USER, String PASSWORD) throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("❌ Error cargando el driver de PostgreSQL");
            e.printStackTrace();
        }

        conn = DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
