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
	@WebServlet("/AdminTradeShow")
	public class AdminTradeShow extends HttpServlet {
	    private static final long serialVersionUID = 1L;
	
	    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // TODO Auto-generated method stub
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
	            Class.forName("com.mysql.jdbc.Driver");
	            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/indore", "root", "12345678");
	            String qr = "select * from clienttradedata";
	            Statement st = con.createStatement();
	            ResultSet rs = st.executeQuery(qr);
	            if (rs.next()) {
	                out.println("<table>");
	                out.println("<tr>");
	                out.println("<th>Id</th>");
	                out.println("<th>Email</th>");
	                out.println("<th>Date</th>");
	                out.println("<th>Stock Name</th>");
	                out.println("<th>Buy Price</th>");
	                out.println("<th>Buy Quantity</th>");
	                out.println("<th>Sell Price</th>");
	                out.println("<th>Sell Quantity</th>");
	                out.println("<th>Profit</th>");
	                out.println("<th>Loss</th>");
	                out.println("<th>Action</th>");
	                out.println("</tr>");
	
	            	do
					{
						int id=rs.getInt("id");
						String email=rs.getString("email");
						String date=rs.getString("date");
						String stockname=rs.getString("stockname");
						int buyprice=rs.getInt("buyprice");
						int buyquantity=rs.getInt("buyquantity");
						int sellprice=rs.getInt("sellprice");
						int sellquantity=rs.getInt("sellquantity");
						int profit=rs.getInt("profit");
						int loss=rs.getInt("loss");
						out.println("<form action=AdminTradeShowUpdate >");
						out.println("<tr>");
						out.println("<td>");
						out.println(id+"<input type=hidden name=id value="+id+" />");
						out.println("</td>");
						out.println("<td>");
						out.println(email);
						out.println("</td>");
						out.println("<td>");
						out.println("<input type=date name=date value="+date+" />");
						out.println("</td>");
						out.println("<td>");
						out.println("<input type=text name=stockname value="+stockname+" />");
						out.println("</td>");
						out.println("<td>");
						out.println("<input type=text name=buyprice value="+buyprice+" />");
						out.println("</td>");
						out.println("<td>");
						out.println("<input type=text name=buyquantity value="+buyquantity+" />");
						out.println("</td>");
						out.println("<td>");
						out.println("<input type=text name=sellprice value="+sellprice+" />");
						out.println("</td>");
						out.println("<td>");
						out.println("<input type=text name=sellquantity value="+sellquantity+" />");
						out.println("</td>");
						out.println("<td>");
						out.println("<input type=text name=profit value="+profit+" />");
						out.println("</td>");
						out.println("<td>");
						out.println("<input type=text name=loss value="+loss+" />");
						out.println("</td>");
						out.println("<td>");
						out.println("<input type=submit value=Update />");
						out.println("<a href=AdminTradeShowDelete?id="+id+">Delete</a>");
						out.println("</td>");
						out.println("</tr>");
						out.println("</form>");
						
					}  while (rs.next());
	
	                out.println("</table>");
	            } else {
	                out.println("No records found");
	            }
	            con.close();
	        } catch (Exception e) {
	            // TODO Auto-generated catch block
	            out.println(e);
	        }
	    }
	}
