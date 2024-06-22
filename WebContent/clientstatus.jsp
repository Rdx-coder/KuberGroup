<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.io.*" %>
<%@ include file="db.jsp" %>
<%
String email = (String) session.getAttribute("id");
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobile Trading App Wallet</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 10px;
            padding: 10px;
        }

        .container {
            padding: 20px;
        }

        .card {
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            padding: 20px;
            margin-bottom: 20px;
        }

        .wallet-header {
            text-align: center;
            margin-bottom: 20px;
        }

        .wallet-title {
            font-size: 24px;
            color: #007bff;
            margin-bottom: 10px;
        }

        .wallet-subtitle {
            font-size: 18px;
            color: #555;
        }

        .balance {
            text-align: center;
            font-size: 36px;
            color: #28a745;
            margin-bottom: 20px;
        }

        .profit {
            color: #28a745;
            font-size: 20px;
            margin-bottom: 10px;
        }

        .loss {
            color: #dc3545;
            font-size: 20px;
            margin-bottom: 10px;
        }

        .btn-container {
            display: flex;
            justify-content: space-between;
        }

        .btn {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 10px;
            font-size: 18px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .withdraw-btn {
            background-color: #dc3545;
            color: #fff;
            margin-right: 10px;
        }

        .deposit-btn {
            background-color: #28a745;
            color: #fff;
            margin-left: 10px;
        }

        .history-btn {
            background-color: #ffc107;
            color: #fff;
        }

        .transaction-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .transaction-item {
            padding: 15px;
            border-radius: 10px;
            background-color: #f8f9fa;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .transaction-icon {
            font-size: 24px;
            margin-right: 10px;
        }

        .chart-container {
            margin-top: 20px;
            text-align: center;
        }

        @media (max-width: 576px) {
            .wallet-title {
                font-size: 20px;
            }

            .wallet-subtitle {
                font-size: 16px;
            }

            .balance {
                font-size: 24px;
            }

            .btn {
                font-size: 16px;
            }

            .transaction-item {
                font-size: 14px;
            }

            .transaction-icon {
                font-size: 20px;
            }
        }
    </style>
</head>

<body>
        

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
	  <div class="container">
	  <div class="card">
    <div class="card-body">
        <div class="wallet-header">
            <div class="wallet-title"><i class="fas fa-wallet balance-icon"></i> My Wallet</div>
            <div class="wallet-subtitle">Your investment wallet balance</div>
            <div class="balance"><i class="fas fa-coins"></i> <%= customerpay %></div>
            <div class="profit"><i class="fas fa-arrow-up"></i> Profit: <%= netprofit %></div>
            <div class="loss"><i class="fas fa-arrow-down"></i> Loss: <%= netloss %></div>
            <div class="current-amount">
                <i class="fas fa-hand-holding-usd"></i> Current Amount: <%= customerpay + netprofit - netloss %>
            </div>
        </div>
    </div>
</div>

    <div class="card">
        <h4 class="text-center">Profit & Loss Chart</h4>
        <div class="chart-container">
            <canvas id="profitLossChart" width="400" height="400"></canvas>
        </div>
    </div>
    
<div class="card">
        <div class="btn-container">
            <form action="withdraw.html" method="post">
                <input type="hidden" name="email" value="<%= email %>">
                <button type="submit" class="btn withdraw-btn"><i class="fas fa-money-bill-wave"></i> Withdraw</button>
            </form>
            <form action="addfund.html" method="post">
                <input type="hidden" name="email" value="<%= email %>">
                <button class="btn deposit-btn"><i class="fas fa-coins"></i> Deposit</button>
            </form>
        </div>
    </div>

    <div class="card">
        <div class="btn-container">
            <form action="withdrawhistory.jsp" method="post">
                <input type="hidden" name="email" value="<%= email %>">
                <button class="btn history-btn"><i class="fas fa-history"></i> View All Transactions</button>
            </form>
        </div>
    </div>
    </div>            
    

    
      

<%
    // Calculate percentage values for profit and loss
    double total = netprofit + netloss;
    double profitPercentage = (netprofit / total) * 100;
    double lossPercentage = (netloss / total) * 100;
%>

<script>
    var ctx = document.getElementById('profitLossChart').getContext('2d');
    var profitLossChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['Profit', 'Loss'],
            datasets: [{
                label: 'Profit & Loss',
                data: [<%= profitPercentage %>, <%= lossPercentage %>],
                backgroundColor: [
                    '#28a745',
                    '#dc3545',
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            legend: {
                display: true,
                position: 'bottom',
                labels: {
                    fontColor: '#333',
                    fontSize: 14,
                }
            }
        }
    });
</script>
            <%
                String profitClass = (netprofit > 0) ? "profit" : "";
                String lossClass = (netloss > 0) ? "loss" : "";
            %>
            
       		 <%
            } while (rs.next());
        	} else {
            %>
       <div class="container">
             <div class="card">
    <div class="card-body">
        <div class="wallet-header">
            <div class="wallet-title"><i class="fas fa-wallet balance-icon"></i> My Wallet</div>
            <div class="wallet-subtitle">Your investment wallet balance</div>
            <div class="balance"><i class="fas fa-coins"></i> 0</div>
            <div class="profit"><i class="fas fa-arrow-up"></i> Profit: 0</div>
            <div class="loss"><i class="fas fa-arrow-down"></i> Loss: 0</div>
            <div class="current-amount">
                <i class="fas fa-hand-holding-usd"></i> Current Amount: 0
            </div>
        </div>
    </div>
</div>
<div class="card">
        <div class="btn-container">
            <form action="withdraw.html" method="post">
                <input type="hidden" name="email" value="<%= email %>">
                <button type="submit" class="btn withdraw-btn"><i class="fas fa-money-bill-wave"></i> Withdraw</button>
            </form>
            <form action="addfund.html" method="post">
                <input type="hidden" name="email" value="<%= email %>">
                <button class="btn deposit-btn"><i class="fas fa-coins"></i> Deposit</button>
            </form>
        </div>
    </div>

    <div class="card">
        <div class="btn-container">
            <form action="withdrawhistory.jsp" method="post">
                <input type="hidden" name="email" value="<%= email %>">
                <button class="btn history-btn"><i class="fas fa-history"></i> View All Transactions</button>
            </form>
        </div>
    </div>
</div>            
            <%
        	}
      		  %>
    

<!-- Bootstrap JS and Font Awesome JS (Optional) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/js/all.min.js"></script>
</body>

</html>
