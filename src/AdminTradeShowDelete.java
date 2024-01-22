

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
 * Servlet implementation class AdminTradeShowDelete
 */
@WebServlet("/AdminTradeShowDelete")
public class AdminTradeShowDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		String ids=request.getParameter("id");
		int id=Integer.parseInt(ids);
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/indore","root","12345678");
			String qr="delete from clienttradedata where id=?";
			PreparedStatement ps=con.prepareStatement(qr);
			ps.setInt(1, id);
			int i=ps.executeUpdate();
			RequestDispatcher rd=request.getRequestDispatcher("AdminTradeShow");
			if(i>0)
			{
				rd.include(request, response);
				out.println("Trade deleted sucessfully");
			}
			else
			{
				rd.include(request, response);
				out.println("Trade not deleted");
			}
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			out.println(e);
		}

	}

}
