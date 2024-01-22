

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Show
 */
@WebServlet("/ClientProfile")
public class ClientProfile extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		try {
			HttpSession session=request.getSession();
			String email =(String) session.getAttribute("id");//downcasting

			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/indore","root","12345678");
			String qr="select * from client where email='"+email+"'";
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery(qr);
			
			
			if(rs.next())
				
			{  
				RequestDispatcher rd=request.getRequestDispatcher("clientprofile.html");
				rd.include(request, response);
				out.println("<div style=background-color:red ; width: 200px;height 200px;>");
				do
				{
					String name=rs.getString("name");
				//	String email=rs.getString("email");
					String mobile=rs.getString("mobile");
					String dob=rs.getString("dob");
					String pan=rs.getString("pan");
					String account=rs.getString("account");
					
					out.println("<form action= >");
					out.println("NAME  : "+name);
					
					out.println("<br>");
					out.println("<br>");
					
					out.println("EMAIL  : "+email);
					
					out.println("<br>");
					out.println("<br>");
					
					out.println("MOBILE  : "+mobile);
					
					out.println("<br>");
					out.println("<br>");
				
					out.println("DOB  : "+dob);
					
					out.println("<br>");
					out.println("<br>");
			
					out.println("PAN  : "+pan);
					
					out.println("<br>");
					out.println("<br>");
					
					out.println("ACCOUNT  : "+account);
					
					out.println("</form>");
					

					
				}while(rs.next());
				out.println("</div>");
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
