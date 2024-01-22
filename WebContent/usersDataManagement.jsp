<%@page import="java.sql.*, java.io.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>User Management</title>
</head>
<body>
    <div class="userManagement">
        <h2>User Management</h2>
        <%
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;
        %>

        <table>
            <tr>
                <th>User ID</th>
                <th>Email</th>
                <th>Name</th>
                <th>Given Name</th>
                <th>Family Name</th>
                <th>Picture</th>
                <th>Locale</th>
                <th>Action</th>
                <th>Block/Unblock</th> <!-- New column for block/unblock -->
            </tr>
            <%
                try {
                    // Database Connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/indore", "root", "12345678");

                    // Retrieve user data
                    String selectQuery = "SELECT * FROM usersdata";
                    stmt = con.createStatement();
                    rs = stmt.executeQuery(selectQuery);

                    while (rs.next()) {
            %>
                    <tr>
                        <td><%= rs.getString("user_id") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("given_name") %></td>
                        <td><%= rs.getString("family_name") %></td>
                        <td><img src='<%= rs.getString("picture") %>' alt='Profile Picture'></td>
                        <td><%= rs.getString("locale") %></td>
                        <td>
                            <form action='deleteUsersData.jsp' method='post'>
                                <input type='hidden' name='user_id' value='<%= rs.getString("user_id") %>'>
                                <input type='submit' value='Delete'>
                            </form>
                        </td>
                        <td>
                            <form action='blockunblockusers.jsp' method='post'>
                                <input type='hidden' name='user_id' value='<%= rs.getString("user_id") %>'>
                                <input type='hidden' name='isBlocked' value='<%= rs.getBoolean("IsBlocked") ? "true" : "false" %>'>
                                <input type='submit' value='<%= rs.getBoolean("IsBlocked") ? "Unblock" : "Block" %>'>
                            </form>
                        </td>
                    </tr>
            <%
                    }
                    out.println("</table>");
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("Error retrieving user data: " + e.getMessage());
                } finally {
                    try {
                        if (rs != null) {
                            rs.close();
                        }
                        if (stmt != null) {
                            stmt.close();
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
        </table>
    </div>
</body>
</html>
