import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ClientStatusUpdate")
public class ClientStatusUpdate extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle GET requests to display the update form
        displayUpdateForm(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle POST requests to update client records
        updateClientRecords(request, response);
    }

    private void displayUpdateForm(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Display the form for updating client records
        // You can use this method to render the form for updating client records.
        // Extract parameters and generate the form as needed.
    }

    private void updateClientRecords(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String idStr = request.getParameter("id");
            String email = request.getParameter("email");
            String customerPayStr = request.getParameter("customerpay");
            String netProfitStr = request.getParameter("netprofit");
            String netLossStr = request.getParameter("netloss");

            int id, customerPay, netProfit, netLoss;

            try {
                id = Integer.parseInt(idStr);
                customerPay = Integer.parseInt(customerPayStr);
                netProfit = Integer.parseInt(netProfitStr);
                netLoss = Integer.parseInt(netLossStr);
            } catch (NumberFormatException e) {
                response.getWriter().write("Invalid input: One or more parameters are not valid integers.");
                return;
            }

            String url = "jdbc:mysql://localhost:3306/indore";
            String username = "root";
            String password = "12345678";

            try (Connection con = DriverManager.getConnection(url, username, password)) {
                String sql = "UPDATE customerstatus SET email=?, customerpay=?, netprofit=?, netloss=? WHERE id=?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, email);
                ps.setInt(2, customerPay);
                ps.setInt(3, netProfit);
                ps.setInt(4, netLoss);
                ps.setInt(5, id);

                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("ClientStatus"); // Redirect back to the client records page
                } else {
                    response.getWriter().write("Not updated");
                }
            } catch (SQLException e) {
                response.getWriter().write("Database error: " + e.getMessage());
            }
        } catch (Exception e) {
            response.getWriter().write(e.getMessage());
        }
    }
}
