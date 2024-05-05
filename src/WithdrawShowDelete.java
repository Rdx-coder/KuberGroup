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

@WebServlet("/WithdrawShowDelete")
public class WithdrawShowDelete extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        String account_no = request.getParameter("account_no");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/indore", "root", "12345678");
            String qr = "delete from withdraw where account_no=?";
            PreparedStatement ps = con.prepareStatement(qr);
            ps.setString(1, account_no);

            int i = ps.executeUpdate();
            if (i > 0) {
                out.println("Record deleted successfully");
            } else {
                out.println("Record not deleted");
            }
            con.close();
        } catch (Exception e) {
            out.println(e);
        }
    }
}
