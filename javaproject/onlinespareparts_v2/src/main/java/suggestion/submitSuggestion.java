package suggestion;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
// Removed WebServlet import
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import JDBCConnection.ConnectionFactory;

/**
 * Servlet implementation class submitSuggestion
 */
@MultipartConfig
public class submitSuggestion extends HttpServlet {	private static final long serialVersionUID = 1L;
	private static final String imageDirectory="C:/Users/NIMADITH/Desktop/Java File/javaproject/onlinespareparts_v2/src/main/webapp/feedback/";   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public submitSuggestion() {
        super();
        // TODO Auto-generated constructor stub
    }	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Check if the user is admin
		String userType = (String) request.getSession().getAttribute("type");
		
		if ("admin".equals(userType)) {
			// If admin, redirect directly to view all suggestions
			response.sendRedirect("suggestionDetails?action=listAll");
		} else {
			// For regular users, show the submission form
			request.getRequestDispatcher("/suggestion.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get parameters from form submission
		String username = request.getParameter("username");
		String suggestionType = request.getParameter("suggestionType");
		String feedback = request.getParameter("feedback");
		String email = request.getParameter("email");
		
		// Handle image upload
		String imageFileName = "";
		Part imagePart = request.getPart("image");  // Match the name in the form
		
		// Only process image if one was uploaded
		if (imagePart != null && imagePart.getSize() > 0 && imagePart.getSubmittedFileName() != null 
		    && !imagePart.getSubmittedFileName().isEmpty()) {
		    
		    imageFileName = imagePart.getSubmittedFileName();
		    System.out.println("Selected image name is " + imageFileName);
		    
		    // Create the directory if it doesn't exist
		    java.io.File uploadDir = new java.io.File(imageDirectory);
		    if (!uploadDir.exists()) {
		        uploadDir.mkdirs();
		    }
		    
		    String uploadpath = imageDirectory + imageFileName;
		    try {
		        FileOutputStream fos = new FileOutputStream(uploadpath);
		        InputStream is = imagePart.getInputStream();
		        byte[] data = new byte[is.available()];
		        is.read(data);
		        fos.write(data);
		        fos.close();
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		}       try (Connection connection = ConnectionFactory.getConnection();
               PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO suggestion (suggestiontype, feedback, image, email, username) VALUES (?, ?, ?, ?, ?)")) {

              preparedStatement.setString(1, suggestionType);
              preparedStatement.setString(2, feedback);
              preparedStatement.setString(3, imageFileName); // Will be empty string if no image was uploaded
              preparedStatement.setString(4, email);
              preparedStatement.setString(5, username);
                int row = preparedStatement.executeUpdate();
              if (row > 0) {
                  // Suggestion was successfully added
                  System.out.println("Suggestion submitted successfully for user: " + username);
                  
                  // Create a dedicated view for after submission
                  request.setAttribute("message", "Your suggestion has been submitted successfully!");
                  request.setAttribute("username", username);
                    // Directly fetch the user's suggestions and show them
                  PreparedStatement stmt = connection.prepareStatement(
                      "SELECT suggestionid, suggestiontype, feedback, image, email, username, reply " +
                      "FROM suggestion WHERE username=? ORDER BY suggestionid DESC");
                  stmt.setString(1, username);                  
                  ArrayList<suggestionDetails.suggestion> userSuggestions = new ArrayList<>();
                  try (ResultSet rs = stmt.executeQuery()) {while (rs.next()) {
                          int suggestionid = rs.getInt("suggestionid");
                          String suggestiontype = rs.getString("suggestiontype");
                          String feedbackText = rs.getString("feedback");
                          String image = rs.getString("image");
                          String emailAddr = rs.getString("email");
                          String user = rs.getString("username");
                          String reply = rs.getString("reply");
                          
                          // Use static inner class constructor directly
                          suggestionDetails.suggestion sug = new suggestionDetails.suggestion(suggestionid, suggestiontype, feedbackText, 
                                                  image, emailAddr, user, reply);
                          userSuggestions.add(sug);
                      }
                  }
                  
                  request.setAttribute("suggestions", userSuggestions);
                  request.getRequestDispatcher("/suggest.jsp").forward(request, response);
              }
          } catch (SQLException sqlEx) {
              sqlEx.printStackTrace();
              response.getWriter().print("SQL error: " + sqlEx.getMessage());
          } catch (Exception e) {
              e.printStackTrace();
              response.getWriter().print("Error adding product: " + e.getMessage());
          }
	}

}
