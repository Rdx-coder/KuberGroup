import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ClientLogout")
public class ClientLogout extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        HttpSession session = request.getSession();

        // Clear user-specific data or resources (if applicable)
        // For example, close files, release database connections, clean up resources, etc.

        // Optionally, clear specific session attributes if needed
        // session.removeAttribute("attributeName");

        // Invalidate the user's session
        session.invalidate();

        // Display a JavaScript alert to notify the user of successful logout
        out.println("<html><head><script>alert('Logout Successful');</script></head><body></body></html>");

        // Redirect the user to a different page after logout (in this case, "index.html")
        RequestDispatcher rd = request.getRequestDispatcher("index.html");
        rd.forward(request, response);
    }
}
