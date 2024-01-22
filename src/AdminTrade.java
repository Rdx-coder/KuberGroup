

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
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AdminTrade
 */
@WebServlet("/AdminTrade")
public class AdminTrade extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		String ids=request.getParameter("id");
		int id=Integer.parseInt(ids);
		
		String email=request.getParameter("email");
		
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
			HttpSession session=request.getSession();
			session.setAttribute("id", email);

			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/indore","root","12345678");
			String qr="insert into clienttradedata values(?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps=con.prepareStatement(qr);
			ps.setInt(1, id);
			ps.setString(2, email);
			ps.setString(3, date);
			ps.setString(4, stockname);
			ps.setInt(5, buyprice);
			ps.setInt(6, buyquantity);
			ps.setInt(7, sellprice);
			ps.setInt(8, sellquantity);
			ps.setInt(9, profit);
			ps.setInt(10, loss);
			
			int i=ps.executeUpdate();
			if(i>0)
			{
				out.println("trade added sucessfully");
			}
			else
			{
				out.println(" not added");
			}
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			out.println(e);
		}

	}

}
