package suggestion;

import jakarta.servlet.ServletException;
// Removed WebServlet import
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import JDBCConnection.ConnectionFactory;
import Seller.OrderedDetails.Orderrs;

/**
 * Servlet implementation class suggestionDetails
 */
public class suggestionDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public suggestionDetails() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get parameters
		String username = request.getParameter("username");
		String action = request.getParameter("action");
		ArrayList<suggestion> suggestions = new ArrayList<>();
		
		// Debug info
		System.out.println("suggestionDetails servlet called with username=" + username + ", action=" + action);
		
		// If no username is provided, use the session username
		if ((username == null || username.isEmpty()) && action == null) {
			username = (String) request.getSession().getAttribute("username");
			System.out.println("Using session username instead: " + username);
		}
		
		try(Connection connection=ConnectionFactory.getConnection();){
			PreparedStatement preparedStatement;
			
			// Check if we should list all suggestions (for admin) or user-specific suggestions
			if ("listAll".equals(action)) {
				// Admin case - list all suggestions
				preparedStatement = connection.prepareStatement("SELECT suggestionid, suggestiontype, feedback, image, email, username, reply from suggestion ORDER BY suggestionid DESC");
				System.out.println("Listing all suggestions for admin");
			} else if (username != null && !username.isEmpty()) {
				// User case - list suggestions by username
				preparedStatement = connection.prepareStatement("SELECT suggestionid, suggestiontype, feedback, image, email, username, reply from suggestion where username=? ORDER BY suggestionid DESC");
				preparedStatement.setString(1, username);
				System.out.println("Listing suggestions for user: " + username);
			} else {
				// No valid parameter - redirect to home
				response.sendRedirect("home.jsp");
				return;
			}
			
			try (ResultSet resultSet = preparedStatement.executeQuery()) {
	                 while (resultSet.next()) {
	                	 int suggestionid=resultSet.getInt("suggestionid");
	                	 System.out.println(suggestionid);
	                     String suggestiontype=resultSet.getString("suggestiontype");
	                     String feedback=resultSet.getString("feedback");
	                     String image=resultSet.getString("image");
	                     String email=resultSet.getString("email");                     String Username=resultSet.getString("username");
                     String reply=resultSet.getString("reply");
                     // Use static inner class constructor directly
                     suggestions.add(new suggestion(suggestionid, suggestiontype, feedback,image, email,Username,reply));
	                     
	                 }	                 request.setAttribute("suggestions", suggestions);
					request.getRequestDispatcher("/suggest.jsp").forward(request, response);
	             }
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			System.out.println();
		
	}	// Make class static so it can be referenced directly
	public static class suggestion {
        private int suggestid;
        private String suggestiontype;
        private String feedback;
        private String image;
        private String email;
        private String username;
        private String reply;
        
		public int getSuggestid() {
			return suggestid;
		}
		
		public String getSuggestiontype() {
			return suggestiontype;
		}
		
		public String getFeedback() {
			return feedback;
		}
		
		public String getImage() {
			return image;
		}
		
		public String getEmail() {
			return email;
		}
		
		public String getUsername() {
			return username;
		}
		
		public String getReply() {
			return reply;
		}
		
		public suggestion(int suggestid, String suggestiontype, String feedback, String image, String email,
				String username, String reply) {
			super();
			this.suggestid = suggestid;
			this.suggestiontype = suggestiontype;
			this.feedback = feedback;
			this.image = image;
			this.email = email;
			this.username = username;
			this.reply = reply;
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
