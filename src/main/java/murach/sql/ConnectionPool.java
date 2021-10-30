package murach.sql;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.*;
import javax.sql.DataSource;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class ConnectionPool {

    private static ConnectionPool pool = null;
    private static String username = "";
    private static String password = "";
    private static String dbUrl = "";

    private ConnectionPool() {
        try {
            //InitialContext ic = new InitialContext();
            //dataSource = (DataSource) ic.lookup("java:/comp/env/jdbc/murach");
            
            URI dbUri = new URI(System.getenv("DATABASE_URL"));

            username = dbUri.getUserInfo().split(":")[0];
            password = dbUri.getUserInfo().split(":")[1];
            dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath();
        
        } catch (URISyntaxException e) {
            System.out.println(e);
        }
    }

    public static synchronized ConnectionPool getInstance() {
        if (pool == null) {
            pool = new ConnectionPool();
        }
        return pool;
    }

    public Connection getConnection() {
        try {
            return DriverManager.getConnection(dbUrl, username, password);
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        }
    }

    public void freeConnection(Connection c) {
        try {
            c.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}