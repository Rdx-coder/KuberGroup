import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/WithdrawShowUpdate")
public class WithdrawShowUpdate extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        String account_no = request.getParameter("account_no");
        String status = request.getParameter("status");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/indore", "root", "12345678");
            String qr = "update withdraw set status=? where account_no=?";
            PreparedStatement ps = con.prepareStatement(qr);
            ps.setString(1, status);
            ps.setString(2, account_no);

            int i = ps.executeUpdate();
            if (i > 0) {
                out.println("Status updated successfully");
            } else {
                out.println("Status not updated");
            }
            con.close();
        } catch (Exception e) {
            out.println(e);
        }
    }
}
