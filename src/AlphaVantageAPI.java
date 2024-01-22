import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class AlphaVantageAPI {
    public static void main(String[] args) {
        String apiKey = "M90R01O5QL5OTJYZ";
        List<String> symbols = new ArrayList<>();
         // Replace with the stock symbols you want to retrieve data for.
        symbols.add("MSFT");
        symbols.add("GOOGL");

        for (String symbol : symbols) {
            try {
                URL url = new URL("https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol=" + symbol + "&apikey=" + apiKey);
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                connection.setRequestMethod("GET");

                int responseCode = connection.getResponseCode();
                if (responseCode == HttpURLConnection.HTTP_OK) {
                    BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                    String line;
                    StringBuilder apiResponse = new StringBuilder();

                    while ((line = reader.readLine()) != null) {
                        apiResponse.append(line);
                    }

                    reader.close();
                    connection.disconnect();

                    // Process the API response here for each symbol
                    System.out.println("API Response for " + symbol + ":");
                    System.out.println(apiResponse.toString());
                } else {
                    System.out.println("HTTP request failed with response code: " + responseCode);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
