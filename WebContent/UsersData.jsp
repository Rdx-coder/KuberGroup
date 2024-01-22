<%@page import="java.sql.*, java.io.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>User Management</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0;
        margin: 0;
        padding: 0;
    }

    .userManagement {
        width: 95%; /* Adjusted for smaller screens */
        margin: 20px auto;
        background-color: #fff;
        box-shadow: 0 2px 5px rgba(173, 181, 189, 0.6);
        border-radius: 5px;
        padding: 10px; /* Reduced padding for smaller screens */
    }

    h2 {
        text-align: center;
        color: #ff9a44;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 8px; /* Reduced padding for smaller screens */
        text-align: center;
    }

    th {
        background-color: #ff9a44;
        color: white;
    }

    /* Responsive CSS for smaller screens */
    @media (max-width: 768px) {
        .userManagement {
            width: 100%; /* Full width for very small screens */
        }

        table {
            font-size: 14px; /* Adjust font size for readability */
        }

        /* You can further customize styles for very small screens here */
    }
</style>

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
