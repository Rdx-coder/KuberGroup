

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
 * Servlet implementation class Withdraw
 */
@WebServlet("/Withdraw")
public class Withdraw extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		String refrence_id=request.getParameter("refrence_id");
		String m_pin=request.getParameter("m_pin");
		String account_no=request.getParameter("account_no");
		String account_holder_name=request.getParameter("account_holder_name");
		String upi_id=request.getParameter("upi_id");
		String amount=request.getParameter("amount");
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/indore","root","12345678");
			String qr="insert into withdraw values(?,?,?,?,?,?)" ;
			PreparedStatement ps=con.prepareStatement(qr);
			ps.setString(1, refrence_id);
			ps.setString(2, m_pin);
			ps.setString(3, account_no);
			ps.setString(4, account_holder_name);
			ps.setString(5, upi_id);
			ps.setString(6, amount);

			int i=ps.executeUpdate();
			if(i>0)
			{
//				RequestDispatcher rd=request.getRequestDispatcher("clientlogin.html");
//				rd.include(request, response);
				out.println("<script>window.alert('sucessfully withdraw please wait for 24 hours ')</script>");
			}
			else
			{
				RequestDispatcher rd=request.getRequestDispatcher("withdraw.html");
				rd.include(request, response);
				out.println("<script>window.alert('withdraw failed')</script>");
			}
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			out.println(e);
		}

	}

}
