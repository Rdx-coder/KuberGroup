

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
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ClientPortfolio
 */
@WebServlet("/ClientPortfolio")
public class ClientPortfolio extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		try {
			HttpSession session=request.getSession();
			String email =(String) session.getAttribute("id");//downcasting

			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/indore","root","12345678");
			String qr="select * from clienttradedata where email='"+email+"'";
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery(qr);
			if(rs.next())
			{
				out.println("<table align='center' border='1px' >");
				do
				{
//					int id=rs.getInt("id");
				//	String email=rs.getString("email");
					String date=rs.getString("date");
					String stockname=rs.getString("stockname");
					int buyprice=rs.getInt("buyprice");
					int buyquantity=rs.getInt("buyquantity");
					int sellprice=rs.getInt("sellprice");
					int sellquantity=rs.getInt("sellquantity");
					out.println("<form action=ClientPortfolio >");
					
					out.println("<th>");
					out.println("<td>");
					out.println("DATE");
					out.println("</td>");
					out.println("<td>");
					out.println("STOCK NAME");
					out.println("</td>");
					out.println("<td>");
					out.println("BUY PRICE");
					out.println("</td>");
					out.println("<td>");
					out.println("BUY QUANTITY");
					out.println("</td>");
					out.println("<td>");
					out.println("SELL PRICE");
					out.println("</td>");
					out.println("<td>");
					out.println("SELL QUANTITY");
					out.println("</td>");
					
					out.println("</t>");

					
					
					out.println("<tr>");
					out.println("<td>");
					out.println(date);
					out.println("</td>");
					out.println("<td>");
					out.println(stockname);
					out.println("</td>");
					out.println("<td>");
					out.println(buyprice);
					out.println("</td>");
					out.println("<td>");
					out.println(buyquantity);
					out.println("</td>");
					out.println("<td>");
					out.println(sellprice);
					out.println("</td>");
					out.println("<td>");
					out.println(sellquantity);
					out.println("</td>");
					out.println("</form>");
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
