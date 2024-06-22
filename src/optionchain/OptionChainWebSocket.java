package optionchain;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

@ServerEndpoint("/websocket")
public class OptionChainWebSocket {

    private static final Set<Session> sessions = new CopyOnWriteArraySet<>();

    @OnOpen
    public void onOpen(Session session) {
        sessions.add(session);
        sendOptionChainData(session); // Send data to the newly connected client
    }

    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        // Handle incoming messages if necessary
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        // Handle errors if necessary
    }

    private void sendOptionChainData(Session session) {
        try {
            URL url = new URL("https://www.nseindia.com/api/option-chain-indices?symbol=NIFTY");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("User-Agent", "Mozilla/5.0");

            int responseCode = conn.getResponseCode();
            if (responseCode == 200) {
                Scanner scanner = new Scanner(url.openStream());
                StringBuilder response = new StringBuilder();
                while (scanner.hasNext()) {
                    response.append(scanner.nextLine());
                }
                scanner.close();
                session.getBasicRemote().sendText(response.toString());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Utility method to broadcast data to all connected clients
    private static void broadcast(String message) {
        for (Session session : sessions) {
            if (session.isOpen()) {
                try {
                    session.getBasicRemote().sendText(message);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // Call this method periodically to update all clients
    public static void updateAllClients() {
        try {
            URL url = new URL("https://www.nseindia.com/api/option-chain-indices?symbol=NIFTY");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("User-Agent", "Mozilla/5.0");

            int responseCode = conn.getResponseCode();
            if (responseCode == 200) {
                Scanner scanner = new Scanner(url.openStream());
                StringBuilder response = new StringBuilder();
                while (scanner.hasNext()) {
                    response.append(scanner.nextLine());
                }
                scanner.close();
                broadcast(response.toString());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
