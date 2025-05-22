package suggestion;

import jakarta.servlet.ServletException;
// Removed WebServlet import
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import JDBCConnection.ConnectionFactory;

/**
 * Servlet implementation class UpdateSuggestion
 */
public class UpdateSuggestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateSuggestion() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id=request.getParameter("id");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id=request.getParameter("id");
		String Type=request.getParameter("suggestionType");
		String Feedback=request.getParameter("feedback");
		int ID=Integer.parseInt(id);
		String updateQuery = "UPDATE suggestion SET suggestiontype=?, feedback=? WHERE suggestionid=?;";
        // Connect to the database and execute the update query
        try (Connection con = ConnectionFactory.getConnection();PreparedStatement ps = con.prepareStatement(updateQuery)) {
          
            
                ps.setString(1, Type);
                ps.setString(2, Feedback);
               
                ps.setInt(3, ID);

                int rowsUpdated = ps.executeUpdate(); // Use executeUpdate for an update query
                if (rowsUpdated > 0) {
                    // Update successful
                	
                    request.getRequestDispatcher("/message.jsp").forward(request, response);
                } else {
                    // User not found
                    
                    
                    request.getRequestDispatcher("/home.jsp").forward(request, response);
                }
            } catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ClassNotFoundException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		
	}

}
