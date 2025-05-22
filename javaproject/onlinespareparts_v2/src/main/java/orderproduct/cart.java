package orderproduct;

import jakarta.servlet.ServletException;
// Removed WebServlet import
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
// Removed DriverManager import
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import JDBCConnection.ConnectionFactory;
/**
 * Servlet implementation class cart
 */
public class cart extends HttpServlet {
	private static final long serialVersionUID = 1L;
	  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public cart() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id=request.getParameter("id");
		int id1=Integer.parseInt(id);
		System.out.println(id1);
		String selectQuery = "SELECT idproduct,pname, producttype, price, quantity, description, image FROM product WHERE idproduct = ?;";
		try (Connection con = ConnectionFactory.getConnection();PreparedStatement ps = con.prepareStatement(selectQuery);) {
			
			
				ps.setInt(1, id1);
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						// Retrieve user details
						int idproduct = rs.getInt("idproduct");
						System.out.println(idproduct);
						String name = rs.getString("pname");
						System.out.println(name);
						String producttype = rs.getString("producttype");
						String price = rs.getString("price");
						String quantity = rs.getString("quantity");
						String description = rs.getString("description");
						String image = rs.getString("image");
						double Price=Double.parseDouble(price);
						int Quantity=Integer.parseInt(quantity);
						String type=rs.getString("producttype");
						System.out.println(idproduct);
						// Set attributes and forward to profile page
						request.setAttribute("idproduct", idproduct);
						request.setAttribute("name", name);
						request.setAttribute("price", Price);
						request.setAttribute("quantity", Quantity);
						request.setAttribute("description", description);
						request.setAttribute("image", image);
						request.setAttribute("type", type);
						
						request.getRequestDispatcher("/cart.jsp").forward(request, response);
					} 
					
					
				}
				catch (SQLException e) {
					e.printStackTrace();
					request.setAttribute("norecord", "Database error: " + e.getMessage());
		            request.getRequestDispatcher("/register.jsp").forward(request, response);
				}
			}
			catch (SQLException e) {
				e.printStackTrace();
				request.setAttribute("norecord", "Database error: " + e.getMessage());
	            request.getRequestDispatcher("/register.jsp").forward(request, response);
			} catch (ClassNotFoundException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
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
