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

import JDBCConnection.ConnectionFactory;

/**
 * Servlet implementation class BeforeUpdateSuggestion
 */
public class BeforeUpdateSuggestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BeforeUpdateSuggestion() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id = request.getParameter("id");

		// Check for null or empty username
		if (id == null || id.isEmpty()) {
			request.setAttribute("error", "Suggest id  is missing.");
			request.getRequestDispatcher("/home.jsp").forward(request, response);
			return;
		}

		
		int ID=Integer.parseInt(id);
		System.out.println(ID+"Itis a id");
		// Connect to the database and execute the query
		String selectQuery = "SELECT suggestionid, suggestiontype, feedback, image, email, username, reply from suggestion where suggestionid=?";
		try (Connection con = ConnectionFactory.getConnection();PreparedStatement ps = con.prepareStatement(selectQuery)) {
			
		
				ps.setInt(1, ID);
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						// Retrieve user details
						int suggestionid=rs.getInt("suggestionid");
						String suggestiontype = rs.getString("suggestiontype");
						String feedback = rs.getString("feedback");
						
						String email = rs.getString("email");
						String username = rs.getString("username");
						String image = rs.getString("image");
						String reply = rs.getString("reply");

						// Set attributes and forward to profile page
						request.setAttribute("suggestionid", suggestionid);
						request.setAttribute("suggestiontype", suggestiontype);
						request.setAttribute("feedback", feedback);
						request.setAttribute("email", email);
						request.setAttribute("username", username);
						request.setAttribute("image", image);
						request.setAttribute("reply", reply);
						

						request.getRequestDispatcher("/UpdateSuggestion.jsp").forward(request, response);
					} else {
						// User not found
						request.setAttribute("error", "Username not found. Please try again!");
						request.getRequestDispatcher("/home.jsp").forward(request, response);
					}
				}
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
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
