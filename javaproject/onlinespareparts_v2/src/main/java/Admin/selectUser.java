package Admin;

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
 * Servlet implementation class selectUser
 */
public class selectUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public selectUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Fetch all user data and dashboard statistics
		ArrayList<user> users = new ArrayList<>();
		int customerCount = 0;
		int sellerCount = 0;
		int productCount = 0;
		int pendingOrders = 0;
		
		try(Connection connection = ConnectionFactory.getConnection()) {
			// Get user data
			try(PreparedStatement preparedStatement = connection.prepareStatement("SELECT username, name, address, dob, gender, email, phone, type FROM user")) {
				try (ResultSet resultSet = preparedStatement.executeQuery()) {
					while (resultSet.next()) {
						String Username = resultSet.getString("username");
						String Name = resultSet.getString("name");
						String Address = resultSet.getString("address");
						String Dob = resultSet.getString("dob");
						String Gender = resultSet.getString("gender");
						String Email = resultSet.getString("email");
						String Phone = resultSet.getString("phone");
						String Type = resultSet.getString("type");
						
						users.add(new user(Username, Name, Address, Dob, Gender, Email, Phone, Type));
						
						// Count customers and sellers
						if ("user".equals(Type)) {
							customerCount++;
						} else if ("seller".equals(Type)) {
							sellerCount++;
						}
					}
				}
			}
			
			// Get product count
			try(PreparedStatement productStatement = connection.prepareStatement("SELECT COUNT(*) as product_count FROM product")) {
				try (ResultSet resultSet = productStatement.executeQuery()) {
					if (resultSet.next()) {
						productCount = resultSet.getInt("product_count");
					}
				}
			}
			
			// Get pending orders count (orders where status is not 'Delivered' or 'Cancelled')
			try(PreparedStatement orderStatement = connection.prepareStatement("SELECT COUNT(*) as pending_count FROM orders WHERE status <> 'Delivered' AND status <> 'Cancelled'")) {
				try (ResultSet resultSet = orderStatement.executeQuery()) {
					if (resultSet.next()) {
						pendingOrders = resultSet.getInt("pending_count");
					}
				}
			} catch (SQLException e) {
				// Table might not exist or column might be different, handle gracefully
				System.out.println("Could not get pending orders count: " + e.getMessage());
			}
			
			// Set attributes for the dashboard
			request.setAttribute("userList", users);
			request.setAttribute("customerCount", customerCount);
			request.setAttribute("sellerCount", sellerCount);
			request.setAttribute("productCount", productCount);
			request.setAttribute("pendingOrders", pendingOrders);
			
			// Forward to the dashboard page
			request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			request.setAttribute("error", "Database connection error: " + e.getMessage());
			request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("error", "SQL error: " + e.getMessage());
			request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
		}
		
	}
	public class user {
        private String username;
        private String name;
        private String address;
        private String dob;
        private String gender;
        private String email;
        private String phone;
        private String type;
        
       

		

	

	public String getUsername() {
			return username;
		}







		public String getName() {
			return name;
		}







		public String getAddress() {
			return address;
		}







		public String getDob() {
			return dob;
		}







		public String getGender() {
			return gender;
		}







		public String getEmail() {
			return email;
		}







		public String getPhone() {
			return phone;
		}







		public String getType() {
			return type;
		}







	public user(String username, String name, String address, String dob, String gender, String email, String phone,
				String type) {
			super();
			this.username = username;
			this.name = name;
			this.address = address;
			this.dob = dob;
			this.gender = gender;
			this.email = email;
			this.phone = phone;
			this.type = type;
		}







	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}}
