<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@include file="db.jsp" %>

<%
String email = (String) session.getAttribute("id");

if (email != null) {
    
    Statement st = null;
    ResultSet rs = null;
    int total = 0;

    try {
         // Implement this method in db.jsp to get a database connection
        st = con.createStatement();
        String query = "SELECT * FROM clienttradedata WHERE email = '" + email + "'";
        rs = st.executeQuery(query);
%>

<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
        }

        .container {
            width: 100%;
            display: flex;
            justify-content: center;
        }

        .table-container {
            background-color: #fff;
            box-shadow: 0 2px 5px 0 rgba(173, 181, 189, 0.6);
            width: 100%;
            margin: 20px;
            border-radius: 5px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #ff9a44;
            color: white;
        }

        .no-records {
            text-align: center;
            font-size: 18px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="table-container">
        <table>
            <tr>
                <th>Date</th>
                <th>Stock Name</th>
                <th>Buy Price</th>
                <th>Buy Quantity</th>
                <th>Sell Price</th>
                <th>Sell Quantity</th>
                <th>Profit</th>
                <th>Loss</th>
            </tr>
            <% if (rs.next()) { %>
                <%
                do {
                    String date = rs.getString("date");
                    String stockname = rs.getString("stockname");
                    int buyprice = rs.getInt("buyprice");
                    int buyquantity = rs.getInt("buyquantity");
                    int sellprice = rs.getInt("sellprice");
                    int sellquantity = rs.getInt("sellquantity");
                    int profit = rs.getInt("profit");
                    int loss = rs.getInt("loss");
                    total += buyprice;
                %>
                <tr>
                    <td><%= date %></td>
                    <td><%= stockname %></td>
                    <td><%= buyprice %></td>
                    <td><%= buyquantity %></td>
                    <td><%= sellprice %></td>
                    <td><%= sellquantity %></td>
                    <td><%= profit %></td>
                    <td><%= loss %></td>
                </tr>
                <%
                } while (rs.next());
                %>
            <% } else { %>
                <tr>
                    <td colspan="8" class="no-records">No records found</td>
                </tr>
            <% } %>
        </table>
    </div>
</div>

</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            // Close the resources
            if (rs != null) rs.close();
            if (st != null) st.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
} else {
    out.println("No session data found. Please log in.");
}
%>
