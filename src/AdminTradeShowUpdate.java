

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

/**
 * Servlet implementation class AdminTradeShowUpdate
 */
@WebServlet("/AdminTradeShowUpdate")
public class AdminTradeShowUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		String ids=request.getParameter("id");
		int id=Integer.parseInt(ids);
		
		String date=request.getParameter("date");
		
		String stockname=request.getParameter("stockname");
		
		String buyprices=request.getParameter("buyprice");
		int buyprice=Integer.parseInt(buyprices);
		
		String buyquantitys=request.getParameter("buyquantity");
		int buyquantity=Integer.parseInt(buyquantitys);
		
		String sellprices=request.getParameter("sellprice");
		int sellprice=Integer.parseInt(sellprices);
		
		String sellquantitys=request.getParameter("sellquantity");
		int sellquantity=Integer.parseInt(sellquantitys);
		
		String profits=request.getParameter("profit");
		int profit=Integer.parseInt(profits);
		
		String losss=request.getParameter("loss");
		int loss=Integer.parseInt(losss);
		

		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/indore","root","12345678");
			String qr="update clienttradedata set stockname=?,buyprice=?,buyquantity=?,sellprice=?,sellquantity=?,profit=?,loss=? where id=?";
			PreparedStatement ps=con.prepareStatement(qr);
			ps.setInt(8, id);
			//ps.setString(1, date);
			ps.setString(1, stockname);
			ps.setInt(2, buyprice);
			ps.setInt(3, buyquantity);
			ps.setInt(4, sellprice);
			ps.setInt(5, sellquantity);
			ps.setInt(6, profit);
			ps.setInt(7, loss);
			
			int i=ps.executeUpdate();
			RequestDispatcher rd=request.getRequestDispatcher("AdminTradeShow");
			
			if(i>0)
			{
				rd.include(request, response);
				out.println("Update sucessfully");
			}
			else
			{
				rd.include(request, response);
				out.println("Not Updated");
			}
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			out.println(e);
		}

	}

}
