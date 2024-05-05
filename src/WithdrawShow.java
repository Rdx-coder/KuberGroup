import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/WithdrawShow")
public class WithdrawShow extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        out.println("<html><head><title>Withdraw Records</title></head><body>");
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
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/indore", "root", "12345678");
            String qr = "select * from withdraw";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(qr);

            if (rs.next()) {
                out.println("<div class='container'>");
                out.println("<div class='table-container'>");
                out.println("<table>");
                out.println("<tr>");
                out.println("<th>Account No</th>");
                out.println("<th>MPIN</th>");
                out.println("<th>Account Holder Name</th>");
                out.println("<th>UPI ID</th>");
                out.println("<th>Amount</th>");
                out.println("<th>Email ID</th>");
                out.println("<th>Status</th>");
                out.println("<th>Time</th>");
                out.println("<th>Date</th>");
                out.println("<th>Action</th>");
                out.println("</tr>");

                SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

                do {
                    String accountNo = rs.getString("account_no");
                    String mPin = rs.getString("m_pin");
                    String accountHolderName = rs.getString("account_holder_name");
                    String upiId = rs.getString("upi_id");
                    String amount = rs.getString("amount");
                    String emailId = rs.getString("email_id");
                    String status = rs.getString("status");
                    String time = timeFormat.format(rs.getTimestamp("time"));
                    String date = dateFormat.format(rs.getDate("date"));

                    out.println("<tr>");
                    out.println("<td>" + accountNo + "</td>");
                    out.println("<td>" + mPin + "</td>");
                    out.println("<td>" + accountHolderName + "</td>");
                    out.println("<td>" + upiId + "</td>");
                    out.println("<td>" + amount + "</td>");
                    out.println("<td>" + emailId + "</td>");
                    out.println("<form action='WithdrawShowUpdate' method='post'>");
                    out.println("<input type='hidden' name='account_no' value='" + accountNo + "'>");
                    out.println("<td><input type='text' name='status' value='" + status + "'></td>");
                    out.println("<td>" + time + "</td>");
                    out.println("<td>" + date + "</td>");
                    out.println("<td><input type='submit' value='Update' onclick='return confirm(\"Are you sure you want to update?\")'></td>");
                    out.println("</form>");
                    out.println("<td><a href='WithdrawShowDelete?account_no=" + accountNo + "' onclick='return confirm(\"Are you sure you want to delete?\")'>Delete</a></td>");
                    out.println("</tr>");
                } while (rs.next());

                out.println("</table>");
                out.println("</div>");
                out.println("</div>");
            } else {
                out.println("<div class='no-records'>No records found.</div>");
            }
            con.close();
        } catch (Exception e) {
            out.println(e);
        }

        out.println("</body></html>");
    }
}
