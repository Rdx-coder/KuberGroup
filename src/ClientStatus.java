import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;	
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ClientStatus")
public class ClientStatus extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle GET requests to display client records
        displayClientRecords(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if it's an update or delete request
        if (request.getParameter("update") != null) {
            updateClientRecords(request, response);
        } else if (request.getParameter("delete") != null) {
            deleteClientRecord(request, response);
        } else {
            // Handle other POST requests if needed
        }
    }

    private void displayClientRecords(HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        out.println("<style>");
        out.println("body { font-family: Arial, sans-serif; background-color: #f0f0f0; }");
        out.println(".container { width: 100%; display: flex; justify-content: center; }");
        out.println(".table-container { background-color: #fff; box-shadow: 0 2px 5px 0 rgba(173, 181, 189, 0.6); width: 100%; margin: 20px; border-radius: 5px; }");
        out.println("table { width: 100%; border-collapse: collapse; }");
        out.println("th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }");
        out.println("th { background-color: #ff9a44; color: white; }");
        out.println(".no-records { text-align: center; font-size: 18px; margin-top: 20px; }");
        out.println("</style>");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/indore", "root", "12345678");
            String qr = "select * from customerstatus";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(qr);

            out.println("<html><head><title>Client Status</title></head><body>");
            out.println("<form action='ClientStatus' method='post'>");
            out.println("<table align='center' border='1px'>");
            out.println("<tr>");
            out.println("<th>ID</th>");
            out.println("<th>Email</th>");
            out.println("<th>Customer Pay</th>");
            out.println("<th>Net Profit</th>");
            out.println("<th>Net Loss</th>");
            out.println("<th>Action</th>");
            out.println("</tr>");

            while (rs.next()) {
                int id = rs.getInt("id");
                String email = rs.getString("email");
                int customerpay = rs.getInt("customerpay");
                int netprofit = rs.getInt("netprofit");
                int netloss = rs.getInt("netloss");

                out.println("<tr>");
                out.println("<td>" + id + "</td>");
                out.println("<td>" + email + "</td>");
                out.println("<td><input type='text' name='customerpay_" + id + "' value='" + customerpay + "'></td>");
                out.println("<td><input type='text' name='netprofit_" + id + "' value='" + netprofit + "'></td>");
                out.println("<td><input type='text' name='netloss_" + id + "' value='" + netloss + "'></td>");
                out.println("<td>");
                out.println("<button type='submit' name='update' value='" + id + "'>Update</button>");
                out.println("<button type='submit' name='delete' value='" + id + "'>Delete</button>");
                out.println("</td>");
                out.println("</tr>");
            }

            out.println("</table>");
            out.println("</form>");
            out.println("</body></html>");
            con.close();
        } catch (Exception e) {
            out.println(e);
        }
    }

    private void updateClientRecords(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Implement your update logic here
        // Extract the ID and other updated fields from the request parameters
        int id = Integer.parseInt(request.getParameter("update"));
        int customerPay = Integer.parseInt(request.getParameter("customerpay_" + id));
        int netProfit = Integer.parseInt(request.getParameter("netprofit_" + id));
        int netLoss = Integer.parseInt(request.getParameter("netloss_" + id));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/indore", "root", "123456");
            String sql = "UPDATE customerstatus SET customerpay=?, netprofit=?, netloss=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, customerPay);
            ps.setInt(2, netProfit);
            ps.setInt(3, netLoss);
            ps.setInt(4, id);

            int rowsAffected = ps.executeUpdate();
            con.close();

            if (rowsAffected > 0) {
                response.getWriter().write("Record with ID " + id + " updated successfully.<br>");
            } else {
                response.getWriter().write("Record with ID " + id + " was not updated.<br>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            response.getWriter().write("Error: " + e.getMessage());
        }
    }

    private void deleteClientRecord(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Implement your delete logic here
        // Extract the ID from the request parameters
        int id = Integer.parseInt(request.getParameter("delete"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/indore", "root", "123456");
            String sql = "DELETE FROM customerstatus WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            int rowsAffected = ps.executeUpdate();
            con.close();

            if (rowsAffected > 0) {
                response.getWriter().write("Record with ID " + id + " Deleted Successfully.");
            } else {
                response.getWriter().write("Record with ID " + id + " was not Deleted.");
            }
        } catch (ClassNotFoundException | SQLException e) {
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}
