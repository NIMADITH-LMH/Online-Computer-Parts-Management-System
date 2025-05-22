package suggestion;

import jakarta.servlet.ServletException;
// Removed WebServlet import
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
// Removed File import
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import JDBCConnection.ConnectionFactory;

/**
 * Servlet implementation class DeleteSuggestion
 */
public class DeleteSuggestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 private static final String IMAGE_DIRECTORY = "C:/Users/NIMADITH/Desktop/Java File/javaproject/onlinespareparts_v2/src/main/webapp/feedback/";   
   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteSuggestion() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id=request.getParameter("id");
		int idproduct=Integer.parseInt(id);        if (id == null || id.isEmpty()) {
            // Redirect to home page if no ID is provided
            response.sendRedirect(request.getContextPath() + "/home.jsp");
            return;
        }

        try (Connection connection = ConnectionFactory.getConnection()) {
            // Step 1: Retrieve the image file name from the database using the product ID
            String selectSQL = "SELECT image FROM suggestion WHERE suggestionid = ?";
            String imageFileName = null;

            try (PreparedStatement selectStatement = connection.prepareStatement(selectSQL)) {
                selectStatement.setInt(1, idproduct);
                try (ResultSet resultSet = selectStatement.executeQuery()) {
                    if (resultSet.next()) {
                        imageFileName = resultSet.getString("image");
                    } else {
                        // Redirect to suggestions list if suggestion not found
                        String userType = (String) request.getSession().getAttribute("type");
                        String username = (String) request.getSession().getAttribute("username");
                        
                        if ("admin".equals(userType)) {
                            response.sendRedirect(request.getContextPath() + "/suggestionDetails?action=listAll");
                        } else {
                            response.sendRedirect(request.getContextPath() + "/suggestionDetails?username=" + username);
                        }
                        return;
                    }
                }
            }

            // Step 2: Delete the product from the database
            String deleteSQL = "DELETE FROM suggestion WHERE suggestionid = ?";
            try (PreparedStatement deleteStatement = connection.prepareStatement(deleteSQL)) {
                deleteStatement.setInt(1, idproduct);                int rowsAffected = deleteStatement.executeUpdate();

                if (rowsAffected > 0) {
                    // Try to delete image file if it exists
                    if (imageFileName != null && !imageFileName.isEmpty()) {
                        File imageFile = new File(IMAGE_DIRECTORY + imageFileName);
                        if (imageFile.exists()) {
                            imageFile.delete(); // Try to delete but continue regardless
                        }
                    }
                    
                    // Get user type to determine where to redirect
                    String userType = (String) request.getSession().getAttribute("type");
                    String username = (String) request.getSession().getAttribute("username");
                    
                    if ("admin".equals(userType)) {
                        // Admin users should see all suggestions
                        response.sendRedirect(request.getContextPath() + "/suggestionDetails?action=listAll");
                    } else {
                        // Regular users should see their own suggestions
                        response.sendRedirect(request.getContextPath() + "/suggestionDetails?username=" + username);
                    }
                } else {
                    // No rows affected means the suggestion doesn't exist
                    response.sendRedirect(request.getContextPath() + "/home.jsp");
                }
            }        } catch (SQLException sqlEx) {
            sqlEx.printStackTrace();
            // Log the error but redirect user back to a safe page
            System.err.println("SQL error in DeleteSuggestion: " + sqlEx.getMessage());
            response.sendRedirect(request.getContextPath() + "/suggestionDetails?action=listAll");
        } catch (Exception e) {
            e.printStackTrace();
            // Log the error but redirect user back to a safe page
            System.err.println("Error in DeleteSuggestion: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/suggestionDetails?action=listAll");
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
