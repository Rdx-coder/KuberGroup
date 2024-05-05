<%@ page import="java.io.*, java.net.*, org.json.simple.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="java.io.*, java.net.*, org.json.simple.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Fetch Option Chain Data</title>
</head>
<body>
<%
    // Replace 'YOUR_API_KEY' with your actual API key
    String API_KEY = "ZA7Q4IIPEJFXL6R0";
    String symbol = "AAPL"; // Example stock symbol
    
    try {
        // Construct the URL for the API request
        String url = "https://www.alphavantage.co/query?function=OPTION_CHAIN&symbol=" + symbol + "&apikey=" + API_KEY;

        // Create a HTTP connection
        URL apiUrl = new URL(url);
        HttpURLConnection connection = (HttpURLConnection) apiUrl.openConnection();
        connection.setRequestMethod("GET");

        // Get the response code
        int responseCode = connection.getResponseCode();
        
        if (responseCode == HttpURLConnection.HTTP_OK) {
            // Read the response
            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            StringBuilder responseData = new StringBuilder();
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                responseData.append(inputLine);
            }
            in.close();

            // Parse JSON response
            JSONParser parser = new JSONParser();
            JSONObject jsonResponse = (JSONObject) parser.parse(responseData.toString());

            // Output JSON response
            out.println("<pre>" + jsonResponse.toJSONString() + "</pre>");
        } else {
            out.println("Failed to fetch option chain data. HTTP Error Code: " + responseCode);
        }
    } catch (Exception e) {
        out.println("An error occurred: " + e.getMessage());
        e.printStackTrace();
    }
%>
</body>
</html>
