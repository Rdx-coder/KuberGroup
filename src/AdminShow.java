import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AdminShow")
public class AdminShow extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        out.println("<html><head><title>Client Records</title></head><body>");
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
            String qr = "select * from client";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(qr);

            if (rs.next()) {
                out.println("<div class='container'>");
                out.println("<div class='table-container'>");
                out.println("<table>");
                out.println("<tr>");
                out.println("<th>Mobile</th>");
                out.println("<th>Name</th>");
                out.println("<th>Email</th>");
                out.println("<th>DOB</th>");
                out.println("<th>PAN</th>");
                out.println("<th>Account</th>");
                out.println("<th>Password</th>");
                out.println("<th>Action</th>");
                out.println("</tr>");

                do {
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String mobile = rs.getString("mobile");
                    String dob = rs.getString("dob");
                    String pan = rs.getString("pan");
                    String account = rs.getString("account");
                    String pwd = rs.getString("pwd");

                    out.println("<tr>");
                    out.println("<td>" + mobile + "</td>");
                    out.println("<td>" + name + "</td>");
                    out.println("<td>" + email + "</td>");
                    out.println("<td>" + dob + "</td>");
                    out.println("<td>" + pan + "</td>");
                    out.println("<td>" + account + "</td>");
                    out.println("<td>" +pwd + "</td>");
                    out.println("<td><a href='ClientDataDelete?mobile=" + mobile + "'>Delete</a></td>");
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
