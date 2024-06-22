

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ClientLoginApp
 */
@WebServlet("/ClientLoginApp")
public class ClientLoginApp extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		String email=request.getParameter("email");
		String pwd=request.getParameter("pwd");
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/indore","root","12345678");
			String qr="select * from client where email=? and pwd=?";
			PreparedStatement ps=con.prepareStatement(qr);
			ps.setString(1, email);
			ps.setString(2, pwd);
			ResultSet rs=ps.executeQuery();
			if(rs.next())
			{
				HttpSession session=request.getSession();
				session.setAttribute("id", email);
				response.sendRedirect("clienthomepageweb.html");
				//RequestDispatcher rd=request.getRequestDispatcher("clienthomepage.html");
				//rd.include(request,response);
			}
			else
			{
				RequestDispatcher rd=request.getRequestDispatcher("clienthomepageweb.html");
				rd.include(request, response);
				out.println("<script>window.alert('Invalid id or password');</script>");
			}
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			out.println(e);
		}

	}

}
