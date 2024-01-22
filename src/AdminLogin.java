
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdminLogin
 */
@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out =response.getWriter();
		response.setContentType("text/html");
		String id=request.getParameter("id");
		String pwd=request.getParameter("pwd");
		if(id.equals("admin")&&pwd.equals("Kuber@Group"))
		{
			response.sendRedirect("adminhome.html");
			//response.sendRedirect("Adminhome");
			//Cookie ck=new Cookie("uid",id);
			//response.addCookie(ck);
			///RequestDispatcher rd=request.getRequestDispatcher("Adminhome");
			//rd.forward(request, response);
		}
		else
		{
			RequestDispatcher rd=request.getRequestDispatcher("adminlogin.html");
			rd.include(request, response);
			//out.println("Invalid id and password");
			out.println("<script>window.alert('Invalid id and password')</script>");
		}

	}

}
