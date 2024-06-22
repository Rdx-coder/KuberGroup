<%@ page import="optionchain.OptionChainWebSocket" %>
<%@ page import="optionchain.OptionChainServlet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nifty Option Chain</title>
    <style>
        /* Add your CSS styles here */
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h2>Nifty Option Chain</h2>
    <table id="optionChainTable">
        <thead>
            <tr>
                <th>Strike Price</th>
                <th>Call OI</th>
                <th>Call LTP</th>
                <th>Put LTP</th>
                <th>Put OI</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>

    <script>
        const socket = new WebSocket("ws://localhost:8080/KuberGroup/websocket");

        socket.onopen = function() {
            console.log("WebSocket connection established");
        };

        socket.onmessage = function(event) {
            const data = JSON.parse(event.data);
            updateTable(data);
        };

        socket.onclose = function(event) {
            if (event.wasClean) {
                console.log(`WebSocket connection closed cleanly, code=${event.code}, reason=${event.reason}`);
            } else {
                console.error(`WebSocket connection closed unexpectedly, code=${event.code}`);
            }
        };

        socket.onerror = function(error) {
            console.error("WebSocket error:", error);
        };

        function updateTable(data) {
            const tableBody = document.getElementById('optionChainTable').getElementsByTagName('tbody')[0];
            tableBody.innerHTML = ''; // Clear existing data

            data.records.data.forEach(option => {
                const row = tableBody.insertRow();
                row.insertCell(0).innerText = option.strikePrice;
                row.insertCell(1).innerText = option.CE ? option.CE.openInterest : '';
                row.insertCell(2).innerText = option.CE ? option.CE.lastPrice : '';
                row.insertCell(3).innerText = option.PE ? option.PE.lastPrice : '';
                row.insertCell(4).innerText = option.PE ? option.PE.openInterest : '';
            });
        }
    </script>
</body>
</html>
