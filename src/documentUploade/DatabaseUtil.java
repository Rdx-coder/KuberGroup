	package documentUploade;
	
	import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DatabaseUtil {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/indore";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "12345678";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("Error loading MySQL JDBC Driver.");
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }

    public static void closeConnection(Connection connection) {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void saveDocument(String documentType, byte[] content) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = getConnection();
            connection.setAutoCommit(false); // Set auto-commit to false for manual transaction control

            String query = "INSERT INTO documents (document_type, content) VALUES (?, ?)";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, documentType);
            preparedStatement.setBytes(2, content);
            preparedStatement.executeUpdate();

            connection.commit(); // Commit the transaction
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (connection != null) {
                    connection.rollback(); // Rollback the transaction in case of an error
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            closeConnection(connection);
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
