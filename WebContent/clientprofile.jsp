<%
String email = (String) session.getAttribute("id"); // downcasting
%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ include file="db.jsp" %>
<% int total = 0; %>
<%
String qr = "select * from client where email='" + email + "'";

Statement st = con.createStatement();
ResultSet rs = st.executeQuery(qr);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        body {
            font-family: "Arial", sans-serif;
            background: linear-gradient(135deg, #3498DB, #E74C3C);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .profile-container {
            background-color: #FFFFFF;
            color: #495057;
            border: 1px solid #CED4DA;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 400px;
            width: 100%;
            text-align: center;
            padding: 20px;
        }

        .profile-container li {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 20px;
        }

        .profile-info {
            font-size: 18px;
            margin: 10px 0;
            line-height: 1.6;
            display: flex;
            justify-content: space-between;
            padding: 10px;
            border-radius: 5px;
            background-color: #F0F0F0;
        }

        .profile-info strong {
            color: #3498DB;
        }

        .edit-button {
            background-color: #3498DB;
            color: #fff;
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            font-size: 20px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 20px;
        }

        .edit-button:hover {
            background-color: #217DBB;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="profile-container">
                <i class="fas fa-user"></i>
                <h2>Profile</h2>

                <% 
                if (rs.next()) {
                    do {
                        String name = rs.getString("name");
                        String userEmail = rs.getString("email"); // Changed variable name to userEmail
                        String mobile = rs.getString("mobile");
                        String dob = rs.getString("dob");
                        String pan = rs.getString("pan");
                        String account = rs.getString("account");
                %>
                        <p class="profile-info"><i class="fas fa-user"></i> <strong></strong> <%= name %></p>
                        <p class="profile-info"><i class="fas fa-envelope"></i> <strong></strong> <%= userEmail %></p>
                        <p class="profile-info"><i class="fas fa-mobile-alt"></i> <strong></strong> <%= mobile %></p>
                        <p class="profile-info"><i class="fas fa-calendar-alt"></i> <strong></strong> <%= dob %></p>
                        <p class="profile-info"><i class="fas fa-id-card"></i> <strong></strong> <%= pan %></p>
                        <p class="profile-info"><i class="fas fa-university"></i> <strong></strong> <%= account %></p>
                <% 
                    } while (rs.next());
                } else {
                    out.println("Error found");
                }
                %>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
