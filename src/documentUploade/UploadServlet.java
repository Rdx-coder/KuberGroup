package documentUploade;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/UploadServlet")
@MultipartConfig
public class UploadServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Part adharCardPart = request.getPart("adharCard");
            Part panCardPart = request.getPart("panCard");
            Part bankPassbookPart = request.getPart("bankPassbook");

            saveToDatabase(adharCardPart, "AdharCard");
            saveToDatabase(panCardPart, "PanCard");
            saveToDatabase(bankPassbookPart, "BankPassbook");

            // Set success message
            request.setAttribute("successMessage", "Documents uploaded successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            // Set error message
            request.setAttribute("errorMessage", "Error uploading documents. Please try again.");
        }

     // Redirect to the uploadSuccess.jsp page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/DocumentuploadSuccess.jsp");
        dispatcher.forward(request, response);
    }
	private void saveToDatabase(Part part, String documentType) throws IOException {
        try (InputStream inputStream = part.getInputStream()) {
            byte[] content = new byte[inputStream.available()];
            int bytesRead = inputStream.read(content);
            if (bytesRead > 0) {
                DatabaseUtil.saveDocument(documentType, content);
            } else {
                throw new IOException("Error reading document content.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new IOException("Error saving document to database.", e);
        }
    }
}