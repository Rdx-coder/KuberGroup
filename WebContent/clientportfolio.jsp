<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ include file="db.jsp" %>

<%
String email = (String) session.getAttribute("id");

if (email != null) {
    
    Statement st = null;
    ResultSet rs = null;
    int totalProfit = 0;
    int totalLoss = 0;

    try {
         // Implement this method in db.jsp to get a database connection
        st = con.createStatement();
        String query = "SELECT * FROM clienttradedata WHERE email = '" + email + "'";
        rs = st.executeQuery(query);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portfolio</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to bottom right, #FFC0CB, #87CEFA);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            animation: fadeInUp 1s ease-in-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .container {
            width: 90%;
            margin: 20px auto;
        }

        .table-container {
            background-color: #fff;
            box-shadow: 0 2px 5px 0 rgba(173, 181, 189, 0.6);
            border-radius: 5px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }
		th, td {
            padding: 15px;
            text-align: center;
            border-bottom: 2px solid #fff;
            color: #333;
            font-weight: bold;
        }

        th {
            background-color: #FFA07A;
            color: #fff;
            font-size: 1.1em;
        }

        .profit {
            color: green;
        }

        .loss {
            color: red;
        }

        .no-records {
            text-align: center;
            font-size: 18px;
            padding: 12px;
        }

        .total {
            font-weight: bold;
            font-size: 18px;
        }
          h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
            font-size: 2em;
        }
       
    </style>
</head>
<body>

<div class="container">
        <h1>Portfolio</h1>
    
    <div class="table-container">
        <table>
            <thead>
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
            </thead>
            <tbody>
                <% if (rs != null && rs.next()) { %>
                    <% do { %>
                        <tr>
                            <td><%= rs.getString("date") %></td>
                            <td><%= rs.getString("stockname") %></td>
                            <td><%= rs.getInt("buyprice") %></td>
                            <td><%= rs.getInt("buyquantity") %></td>
                            <td><%= rs.getInt("sellprice") %></td>
                            <td><%= rs.getInt("sellquantity") %></td>
                            <% 
                                int profit = rs.getInt("profit");
                                int loss = rs.getInt("loss");
                                totalProfit += profit;
                                totalLoss += loss;
                            %>
                            <%-- Display profit in green and loss in red --%>
                            <%
                            if (profit >= 0) {
                            %>
                            <td class="profit"><%= profit %></td>
                            <% } else { %>
                            <td class="loss"><%= profit %></td>
                            <% } %>
                            <%
                            if (loss >= 0) {
                            %>
                            <td class="loss"><%= loss %></td>
                            <% } else { %>
                            <td class="loss"><%= loss %></td>
                            <% } %>
                        </tr>
                    <% } while (rs.next()); %>
                <% } else { %>
                    <tr>
                        <td colspan="8" class="no-records">No records found</td>
                    </tr>
                <% } %>
                <tr class="total">
                    <td colspan="6">Total</td>
                    <%-- Apply green color if total profit is positive, red if negative --%>
                    <%
                    if (totalProfit >= 0) {
                    %>
                    <td class="profit"><%= totalProfit %></td>
                    <% } else { %>
                    <td class="loss"><%= totalProfit %></td>
                    <% } %>
                    <%-- Apply green color if total loss is positive, red if negative --%>
                    <%
                    if (totalLoss >= 0) {
                    %>
                    <td class="loss"><%= totalLoss %></td>
                    <% } else { %>
                    <td class="loss"><%= totalLoss %></td>
                    <% } %>
                </tr>
            </tbody>
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
