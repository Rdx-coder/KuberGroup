import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Withdraw")
public class Withdraw extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        String reference_id = request.getParameter("reference_id");
        String m_pin = request.getParameter("m_pin");
        String account_no = request.getParameter("account_no");
        String account_holder_name = request.getParameter("account_holder_name");
        String upi_id = request.getParameter("upi_id");
        String amount = request.getParameter("amount");
        String email_id = request.getParameter("email_id"); // New parameter for email id
        String status = "pending"; // Default status

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/indore", "root", "12345678");
            String qr = "insert into withdraw (reference_id, m_pin, account_no, account_holder_name, upi_id, amount, email_id, status) values(?,?,?,?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(qr);
            ps.setString(1, reference_id);
            ps.setString(2, m_pin);
            ps.setString(3, account_no);
            ps.setString(4, account_holder_name);
            ps.setString(5, upi_id);
            ps.setString(6, amount);
            ps.setString(7, email_id); // Set email id
            ps.setString(8, status); // Set status

            int i = ps.executeUpdate();
            if (i > 0) {
                out.println("<script>window.alert('Successfully withdrawn. Please wait for 24 hours.')</script>");
                RequestDispatcher rd = request.getRequestDispatcher("clientstatus.jsp");
                rd.include(request, response);
            } else {
                RequestDispatcher rd = request.getRequestDispatcher("withdraw.html");
                rd.include(request, response);
                out.println("<script>window.alert('Withdrawal failed.')</script>");
            }
            con.close();
        } catch (Exception e) {
            out.println(e);
        }
    }
}
