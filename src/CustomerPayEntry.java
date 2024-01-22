

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
@WebServlet("/CustomerPayEntry")
public class CustomerPayEntry extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		String ids=request.getParameter("id");
		int id=Integer.parseInt(ids);
		
		String email=request.getParameter("email");
		
	
		String sellquantitys=request.getParameter("customerpay");
		int customerpay=Integer.parseInt(sellquantitys);
		
		String profits=request.getParameter("netprofit");
		int netprofit=Integer.parseInt(profits);

		String losss=request.getParameter("netloss");
		int netloss=Integer.parseInt(losss);
		
		try {
			HttpSession session=request.getSession();
			session.setAttribute("id", email);

			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/indore","root","12345678");
			String qr="insert into customerstatus values(?,?,?,?,?)";
			PreparedStatement ps=con.prepareStatement(qr);
			ps.setInt(1, id);
			ps.setString(2, email);
			
			ps.setInt(3, customerpay);
			ps.setInt(4, netprofit);
			ps.setInt(5, netloss);
			
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
