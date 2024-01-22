

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
 * Servlet implementation class WithdrawShowUpdate
 */
@WebServlet("/WithdrawShowUpdate")
public class WithdrawShowUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		
		String account_no=request.getParameter("account_no");
		
		String upi_id=request.getParameter("upi_id");
		
	
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/indore","root","12345678");
			String qr="update withdraw set upi_id=? where account_no=?";
			PreparedStatement ps=con.prepareStatement(qr);
			ps.setString(2, account_no);
			
			ps.setString(1, upi_id);
			
			
			
			int i=ps.executeUpdate();
			RequestDispatcher rd=request.getRequestDispatcher("WithdrawShow");
			rd.include(request, response);
			if(i>0)
			{
				out.println(" updated sucessfully");
			}
			else
			{
				out.println("not updated");
			}
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			out.println(e);
		}

	}

}
