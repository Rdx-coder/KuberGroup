<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
// Retrieve the client's email from the session
String email = (String) session.getAttribute("id");

// Check if the client email is not null or empty
if (email == null || email.isEmpty()) {
    // If client email is not available in the session, redirect to login page or handle the situation accordingly
    response.sendRedirect("login.jsp");
} else {
    // Database connection variables
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // Establish database connection
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/indore", "root", "12345678");

        // SQL query to retrieve withdrawal history for the client
        String sql = "SELECT amount, upi_id, status, time, date FROM withdraw WHERE email_id=?";
        
        // Prepare the statement
        ps = con.prepareStatement(sql);
        ps.setString(1, email);

        // Execute the query
        rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Client Withdraw History</title>
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Custom CSS -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            padding: 20px;
        }
        .transaction-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            padding: 20px;
            transition: transform 0.3s;
        }
        .transaction-card:hover {
            transform: translateY(-5px);
        }
        .transaction-amount {
            font-size: 24px;
            font-weight: bold;
            color: #28a745;
        }
        .transaction-details {
            margin-top: 10px;
            color: #333;
        }
        .transaction-details i {
            margin-right: 5px;
        }
        .transaction-time {
            color: #666;
        }
    </style>
</head>
<body>

<div class="container">
    <h4 class="text-center mb-4">Withdraw History</h4>
    <% 
    // Iterate over the result set and display data in transaction cards
    while (rs.next()) { 
    %>
    <div class="transaction-card">
        <div class="transaction-amount">₹<%= rs.getString("amount") %></div>
        <div class="transaction-details">
            <i class="fas fa-wallet"></i> UPI ID: <%= rs.getString("upi_id") %>
        </div>
        <div class="transaction-details">
            <i class="fas fa-info-circle"></i> Status: <%= rs.getString("status") %>
        </div>
        <div class="transaction-details">
            <i class="far fa-clock"></i> Time: <%= rs.getString("time") %>
        </div>
    </div>
    <% } %>
</div>

</body>
</html>

<%
    } catch (ClassNotFoundException | SQLException e) {
        // Handle exceptions
        e.printStackTrace();
    } finally {
        // Close resources
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            // Handle SQL exceptions
            e.printStackTrace();
        }
    }
}
%>
