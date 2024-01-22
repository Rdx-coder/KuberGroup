<%@page import="java.sql.*" %>

<%
    String userId = request.getParameter("user_id");

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        // Database Connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/indore", "root", "12345678");

        String deleteQuery = "DELETE FROM usersdata WHERE user_id = ?";
        pstmt = con.prepareStatement(deleteQuery);
        pstmt.setString(1, userId);
        pstmt.executeUpdate();

        response.sendRedirect("usersData.jsp"); // Redirect back to the user management page
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error deleting user: " + e.getMessage());
    } finally {
        try {
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error closing the database connection: " + e.getMessage());
        }
    }
%>
