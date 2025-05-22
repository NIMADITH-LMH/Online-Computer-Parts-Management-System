package Seller;

import jakarta.servlet.ServletException;
// Removed WebServlet import
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import orderproduct.OrdersProduct.Orderrs;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import JDBCConnection.ConnectionFactory;

/**
 * Servlet implementation class OrderedDetails
 */
// Removing WebServlet annotation as it's already defined in web.xml
public class OrderedDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderedDetails() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<Orderrs> productList = new ArrayList<>();
		
		// First check if we have a username parameter, or fallback to id parameter for backward compatibility
		String username = request.getParameter("username");
		if (username == null || username.isEmpty()) {
		    username = request.getParameter("id");  // Try the id parameter as fallback
		}
		
		System.out.println("Username parameter: " + username);
		
		// If still no username, use the session username
		if (username == null || username.isEmpty()) {
		    username = (String) request.getSession().getAttribute("username");
		    System.out.println("Using session username: " + username);
		}
		
		try(Connection connection = ConnectionFactory.getConnection()) {
		    // Check if the status column exists in orders table, if not, add it
            try {
                String checkColumnQuery = "SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'orders' AND COLUMN_NAME = 'status'";
                PreparedStatement checkColumnStmt = connection.prepareStatement(checkColumnQuery);
                ResultSet columnResult = checkColumnStmt.executeQuery();
                if (!columnResult.next()) {
                    // Column doesn't exist, add it
                    String addColumnQuery = "ALTER TABLE orders ADD COLUMN status VARCHAR(50) DEFAULT 'Pending'";
                    try (PreparedStatement addColumnStmt = connection.prepareStatement(addColumnQuery)) {
                        addColumnStmt.execute();
                        System.out.println("Added status column to orders table");
                    }
                }
            } catch (Exception e) {
                // If this fails, we'll proceed without the status column
                System.out.println("Could not add status column: " + e.getMessage());
            }
            
			// Different query for admin to see all orders
			String sql;
			PreparedStatement preparedStatement;
			
			if ("admin".equals(username)) {
				// Admin view - get all orders
				sql = "SELECT productid, pname, price, quantity, address, username, image, COALESCE(status, 'Pending') AS status " +
					 "FROM orders ORDER BY productid DESC";
				preparedStatement = connection.prepareStatement(sql);
			} else if (username != null) {
				// Seller view - get orders for their products
				sql = "SELECT productid, pname, price, quantity, address, username, image, COALESCE(status, 'Pending') AS status " +
					 "FROM orders WHERE productid IN (SELECT idproduct FROM product WHERE usrname=?)";
				preparedStatement = connection.prepareStatement(sql);
				preparedStatement.setString(1, username);
			}else {
				// No username provided
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Username parameter is required");
				return;
			}
					try (ResultSet resultSet = preparedStatement.executeQuery()) {
				while (resultSet.next()) {
					int ID = resultSet.getInt("productid");
					System.out.println(ID);
					String pname = resultSet.getString("pname");
					double price = resultSet.getDouble("price");
					int quantity = resultSet.getInt("quantity");
					String address = resultSet.getString("address");
					String orderUsername = resultSet.getString("username");
					String image = resultSet.getString("image");
					String status = resultSet.getString("status");
					
					// If status is null or empty, use "Pending" as default
					if (status == null || status.isEmpty()) {
						status = "Pending";
					}
					
					productList.add(new Orderrs(ID, pname, price, quantity, address, orderUsername, image, status));
				}
				
				request.setAttribute("productList", productList);
				request.setAttribute("userType", username);
				request.getRequestDispatcher("/OrderDetailsforSeller.jsp").forward(request, response);
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database connection error");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "SQL error");
		}
	}	public class Orderrs {
        private int productid;
        private String pname;
        private double Price;
        private int Quantity;
        private String Address;
        private String Username;
        private String Image;
        private String Status;
        
       

		

	public Orderrs(int productid, String pname, double price, int quantity, String address, String username,
				String image) {
			super();
			this.productid = productid;
			this.pname = pname;
			Price = price;
			Quantity = quantity;
			Address = address;
			Username = username;
			Image = image;
			this.Status = "Pending"; // Default status
		}
		
	public Orderrs(int productid, String pname, double price, int quantity, String address, String username,
				String image, String status) {
			super();
			this.productid = productid;
			this.pname = pname;
			Price = price;
			Quantity = quantity;
			Address = address;
			Username = username;
			Image = image;
			this.Status = status;
		}



	public int getProductid() {
		return productid;
	}



	public String getPname() {
		return pname;
	}



	public double getPrice() {
		return Price;
	}



	public int getQuantity() {
		return Quantity;
	}



	public String getAddress() {
		return Address;
	}



	public String getUsername() {
		return Username;
	}


	public String getImage() {
		return Image;
	}
	
	public String getStatus() {
		return Status;
	}




	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	}
}
