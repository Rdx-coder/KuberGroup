

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

/**
 * Servlet implementation class AdminTradeShow
 */
@WebServlet("/CustomerPayShow")
public class CustomerPayShow extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/indore","root","12345678");
			String qr="select * from customerstatus";
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery(qr);
			if(rs.next())
			{
				out.println("<table align='center' border='1px' >");
				do
				{
					int id=rs.getInt("id");
					String email=rs.getString("email");
					
					int customerpay=rs.getInt("customerpay");
					int netprofit=rs.getInt("netprofit");
					int netloss=rs.getInt("netloss");
					out.println("<tr>");
					out.println("<td>Id</td> ");
					out.println("<td>Email</td> ");
					
					out.println("<td>Costomer Pay</td> ");
					out.println("<td>Net Profit</td> ");
					out.println("<td>Net Loss</td> ");
					out.println("</tr>");
					out.println("<form action=ClientStatusUpdate >");
					out.println("<tr>");
					out.println("<td>");
					out.println(id+"<input type=hidden name=id value="+id+" />");
					out.println("</td>");
					out.println("<td>");
					out.println("<input type=text name=date value="+email+" />");
					out.println("</td>");
					
					out.println("<td>");
					out.println("<input type=text name=sellquantity value="+customerpay+" />");
					out.println("</td>");
					out.println("<td>");
					out.println("<input type=text name=profit value="+netprofit+" />");
					out.println("</td>");
					out.println("<td>");
					out.println("<input type=text name=loss value="+netloss+" />");
					out.println("</td>");
					out.println("<td>");
					out.println("<input type=submit value=Update />");
					out.println("</td>");
					out.println("</form>");
					out.println("<td>");
					//out.println("<a href=AdminTradeShowDelete?id="+id+">Delete</a>");
					out.println("</td>");
					out.println("</tr>");
					
				}while(rs.next());
				out.println("</table>");
			}
			else
			{
				out.println("no records found");
			}
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			out.println(e);
		}

	}

}
