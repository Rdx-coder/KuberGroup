<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ include file="db.jsp" %>
<%
String email = (String) session.getAttribute("id");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Status</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 100%;
            display: flex;
            justify-content: center;
        }

        .table-container {
            background-color: #fff;
            box-shadow: 0 2px 5px 0 rgba(173, 181, 189, 0.6);
            width: 80%;
            margin: 20px auto;
            border-radius: 5px;
            padding: 20px;
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

        h1 {
            text-align: center;
            color: #ff9a44;
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
        <h1>Status</h1>
        <table>
            <tr>
                <th>Invested Amount</th>
                <th>Net Profit</th>
                <th>Net Loss</th>
            </tr>

            <%
            String qr = "select * from customerstatus where email='" + email + "'";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(qr);
            if (rs.next()) {
                do {
                    int customerpay = rs.getInt("customerpay");
                    int netprofit = rs.getInt("netprofit");
                    int netloss = rs.getInt("netloss");
            %>
            <tr>
                <td><%= customerpay %></td>
                <td><%= netprofit %></td>
                <td><%= netloss %></td>
            </tr>
            <%
                } while (rs.next());
            } else {
                %>
                <tr>
                    <td colspan="3" class="no-records">No records found</td>
                </tr>
                <%
            }
            %>
        </table>
    </div>
</div>

</body>
</html>
