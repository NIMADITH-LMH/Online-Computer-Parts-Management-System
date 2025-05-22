package Seller;

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
import JDBCConnection.ConnectionFactory;
/**
 * Servlet implementation class BeforeUpdateProduct
 */
public class BeforeUpdateProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BeforeUpdateProduct() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String id = request.getParameter("id");

		// Check for null or empty username
		if (id == null || id.isEmpty()) {
			request.setAttribute("error", "Username is missing.");
			request.getRequestDispatcher("/home.jsp").forward(request, response);
			return;
		}

		
		int ID=Integer.parseInt(id);

		// Connect to the database and execute the query
		String selectQuery = "SELECT idproduct, pname, producttype, price, quantity, description, image FROM product WHERE idproduct = ?;";
		try (Connection con = ConnectionFactory.getConnection();PreparedStatement ps = con.prepareStatement(selectQuery)) {
			
		
				ps.setInt(1, ID);
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						// Retrieve user details
						int Id=rs.getInt("idproduct");
						String pname = rs.getString("pname");
						String producttype = rs.getString("producttype");
						String price = rs.getString("price");
						String quantity = rs.getString("quantity");
						String description = rs.getString("description");
						String image = rs.getString("image");
						

						// Set attributes and forward to profile page
						request.setAttribute("id", Id);
						request.setAttribute("pname", pname);
						request.setAttribute("producttype", producttype);
						request.setAttribute("price", price);
						request.setAttribute("quantity", quantity);
						request.setAttribute("image", image);
						request.setAttribute("description", description);
						

						request.getRequestDispatcher("/UpdateProduct.jsp").forward(request, response);
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
