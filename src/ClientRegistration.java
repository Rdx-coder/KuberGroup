

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
 * Servlet implementation class ClientRegistration
 */
@WebServlet("/ClientRegistration")
public class ClientRegistration extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		String name=request.getParameter("name");
		String email=request.getParameter("email");
		String mobile=request.getParameter("mobile");
		String dob=request.getParameter("dob");
		String pan=request.getParameter("pan");
		String account=request.getParameter("account");
		
		String pwd=request.getParameter("pwd");
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/indore","root","12345678");
			String qr="insert into client values(?,?,?,?,?,?,?)" ;
			PreparedStatement ps=con.prepareStatement(qr);
			ps.setString(1, name);
			ps.setString(2, email);
			ps.setString(3, mobile);
			ps.setString(4, dob);
			ps.setString(5, pan);
			ps.setString(6, account);
			ps.setString(7, pwd);
			int i=ps.executeUpdate();
			if(i>0)
			{
				RequestDispatcher rd=request.getRequestDispatcher("DocumentUploader.jsp");
				rd.include(request, response);
				out.println("<script>window.alert('sucessfully signed up')</script>");
			}
			else
			{
				RequestDispatcher rd=request.getRequestDispatcher("clientregistration.html");
				rd.include(request, response);
				out.println("<script>window.alert('registration failed')</script>");
			}
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			out.println(e);
		}

	}

}
