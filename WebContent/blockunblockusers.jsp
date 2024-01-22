<%@page import="java.sql.*, java.io.*" %>

<%
    Connection con = null;
    PreparedStatement pstmt = null;
    String user_id = request.getParameter("user_id");
    boolean isBlocked = Boolean.parseBoolean(request.getParameter("isBlocked"));

    try {
        // Database Connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/indore", "root", "12345678");

        // Toggle the block status
        boolean newStatus = !isBlocked;

        // Update the user's status in the database
        String updateQuery = "UPDATE usersdata SET IsBlocked = ? WHERE user_id = ?";
        pstmt = con.prepareStatement(updateQuery);
        pstmt.setBoolean(1, newStatus);
        pstmt.setString(2, user_id);
        pstmt.executeUpdate();

        // Redirect back to the user management page
        response.sendRedirect("usersDataManagement.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error updating user status: " + e.getMessage());
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
            out.println("Error closing database resources: " + e.getMessage());
        }
    }
%>
