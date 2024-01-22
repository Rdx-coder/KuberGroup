<%@ page import="java.sql.*" %>

<%
    String userId = request.getParameter("user_id");
    String blockStatus = request.getParameter("block_status"); // Change int to String

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        // Database Connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/indore", "root", "12345678");

        if (blockStatus.equals("1")) { // Check if blockStatus is "1" (as a String)
            // User is currently blocked, so unblock them
            String unblockQuery = "UPDATE usersdata SET blocked = 0 WHERE user_id = ?";
            pstmt = con.prepareStatement(unblockQuery);
        } else {
            // User is currently unblocked, so block them
            String blockQuery = "UPDATE usersdata SET blocked = 1 WHERE user_id = ?";
            pstmt = con.prepareStatement(blockQuery);
        }

        pstmt.setString(1, userId);
        pstmt.executeUpdate();

        response.sendRedirect("usersDataManagement.jsp"); // Redirect back to the user management page
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error toggling user block status: " + e.getMessage());
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
