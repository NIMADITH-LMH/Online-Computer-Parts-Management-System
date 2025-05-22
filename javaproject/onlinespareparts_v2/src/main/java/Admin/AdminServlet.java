package Admin;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import JDBCConnection.ConnectionFactory;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdminServlet
 */
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    // Inner User class to replace the centralized model
    public static class User {
        private int id;
        private String username;
        private String password;
        private String email;
        private String userType;
        private String fullName;
        private String address;
        private String phone;
        
        public User() {
        }
        
        public User(int id, String username, String password, String email, String userType, String fullName, String address, String phone) {
            this.id = id;
            this.username = username;
            this.password = password;
            this.email = email;
            this.userType = userType;
            this.fullName = fullName;
            this.address = address;
            this.phone = phone;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getUserType() {
            return userType;
        }

        public void setUserType(String userType) {
            this.userType = userType;
        }

        public String getFullName() {
            return fullName;
        }

        public void setFullName(String fullName) {
            this.fullName = fullName;
        }

        public String getAddress() {
            return address;
        }

        public void setAddress(String address) {
            this.address = address;
        }

        public String getPhone() {
            return phone;
        }

        public void setPhone(String phone) {
            this.phone = phone;
        }
        
        // Added getter/setter for name to match JSP expectations
        public String getName() {
            return fullName;
        }
        
        public void setName(String name) {
            this.fullName = name;
        }
    }
    
    // Inner Seller class to replace the centralized model
    public static class Seller {
        private int id;
        private String username;
        private String password;
        private String email;
        private String fullName;
        private String address;
        private String phone;
        private String shopName;
        private String shopDescription;
        
        public Seller() {
        }
        
        public Seller(int id, String username, String password, String email, String fullName, String address, String phone, String shopName, String shopDescription) {
            this.id = id;
            this.username = username;
            this.password = password;
            this.email = email;
            this.fullName = fullName;
            this.address = address;
            this.phone = phone;
            this.shopName = shopName;
            this.shopDescription = shopDescription;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getFullName() {
            return fullName;
        }

        public void setFullName(String fullName) {
            this.fullName = fullName;
        }

        public String getAddress() {
            return address;
        }

        public void setAddress(String address) {
            this.address = address;
        }

        public String getPhone() {
            return phone;
        }

        public void setPhone(String phone) {
            this.phone = phone;
        }

        public String getShopName() {
            return shopName;
        }

        public void setShopName(String shopName) {
            this.shopName = shopName;
        }

        public String getShopDescription() {
            return shopDescription;
        }

        public void setShopDescription(String shopDescription) {
            this.shopDescription = shopDescription;
        }
        
        // Added getter/setter for name to match JSP expectations
        public String getName() {
            return fullName;
        }
        
        public void setName(String name) {
            this.fullName = name;
        }
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get the action parameter to determine what operation to perform
		String action = request.getParameter("action");
		
		if (action == null) {
		    action = "dashboard"; // Default action is to show dashboard
		}
				switch (action) {
		    case "addCustomer":
		        addUser(request, response, "user");
		        break;
		    case "addSeller":
		        addUser(request, response, "seller");
		        break;
		    case "deleteUser":
		        deleteUser(request, response);
		        break;
		    case "convertUser":
		        convertUser(request, response);
		        break;
		    case "listUsers":
		        listUsers(request, response);
		        break;
		    case "dashboard":
		        loadDashboard(request, response);
		        break;
		    default:
		        // Invalid action, redirect to home
		        response.sendRedirect("home.jsp");
		        break;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Just call doGet to handle all requests
		doGet(request, response);
	}
	
	/**
	 * Add a new user (customer or seller)
	 */
	private void addUser(HttpServletRequest request, HttpServletResponse response, String userType) throws ServletException, IOException {
		String username = request.getParameter("username");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String telephone = request.getParameter("phone");
        String password = request.getParameter("password");
        String cpassword = request.getParameter("cpassword");
        String type = request.getParameter("id");

        if (!password.equals(cpassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("/addCustomersorSellers.jsp").forward(request, response);
            return;
        }

        try (Connection con = ConnectionFactory.getConnection()) {
            // Check if username already exists
            String selectQuery = "SELECT COUNT(username) AS count FROM user WHERE username = ?";
            try (PreparedStatement stmt = con.prepareStatement(selectQuery)) {
                stmt.setString(1, username);
                
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next() && rs.getInt("count") > 0) {
                        // Username already exists
                        request.setAttribute("error", "Username already exists. Please choose a different username.");
                        request.getRequestDispatcher("/addCustomersorSellers.jsp").forward(request, response);
                        return;
                    }
                }
            }
            
            // Username is available, proceed with insertion
            String insertQuery = "INSERT INTO user (username, name, address, dob, gender, email, phone, password, type) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = con.prepareStatement(insertQuery)) {
                pstmt.setString(1, username);
                pstmt.setString(2, name);
                pstmt.setString(3, address);
                pstmt.setString(4, dob);
                pstmt.setString(5, gender);
                pstmt.setString(6, email);
                pstmt.setString(7, telephone);
                pstmt.setString(8, password);
                pstmt.setString(9, type);
                
                int rowsAffected = pstmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    // If user is a seller, add seller-specific information
                    if ("seller".equals(userType)) {
                        // For simplicity, we're not collecting shop info during registration
                        // You can extend this to add seller-specific information
                    }
                    
                    // Redirect with success message
                    String successMsg = URLEncoder.encode(userType.equals("seller") ? "Seller added successfully!" : "Customer added successfully!", StandardCharsets.UTF_8.toString());
                    response.sendRedirect("addCustomersorSellers.jsp?success=" + successMsg);
                } else {
                    // Insert failed
                    request.setAttribute("error", "Failed to add user. Please try again.");
                    request.getRequestDispatcher("/addCustomersorSellers.jsp").forward(request, response);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/addCustomersorSellers.jsp").forward(request, response);
        }
	}
	
	/**
	 * Delete a user (customer or seller)
	 */
	private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String username = request.getParameter("username");
	    String userType = request.getParameter("userType");
	    
	    if (username == null || username.trim().isEmpty()) {
	        response.sendRedirect("deleteUser.jsp?error=" + URLEncoder.encode("Username is required", StandardCharsets.UTF_8.toString()));
	        return;
	    }
	    
	    try (Connection con = ConnectionFactory.getConnection()) {
	        // Check if user exists
	        String checkQuery = "SELECT COUNT(*) AS count FROM user WHERE username = ? AND type = ?";
	        try (PreparedStatement checkStmt = con.prepareStatement(checkQuery)) {
	            checkStmt.setString(1, username);
	            checkStmt.setString(2, userType);
	            
	            try (ResultSet rs = checkStmt.executeQuery()) {
	                if (!rs.next() || rs.getInt("count") == 0) {
	                    response.sendRedirect("deleteUser.jsp?error=" + URLEncoder.encode("User not found", StandardCharsets.UTF_8.toString()));
	                    return;
	                }
	            }
	        }
	        
	        // User exists, proceed with deletion
	        String deleteQuery = "DELETE FROM user WHERE username = ?";
	        try (PreparedStatement deleteStmt = con.prepareStatement(deleteQuery)) {
	            deleteStmt.setString(1, username);
	            
	            int rowsAffected = deleteStmt.executeUpdate();
	            
	            if (rowsAffected > 0) {
	                // Delete successful
	                response.sendRedirect("deleteUser.jsp?success=" + URLEncoder.encode("User deleted successfully", StandardCharsets.UTF_8.toString()));
	            } else {
	                // Delete failed
	                response.sendRedirect("deleteUser.jsp?error=" + URLEncoder.encode("Failed to delete user", StandardCharsets.UTF_8.toString()));
	            }
	        }
	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	        response.sendRedirect("deleteUser.jsp?error=" + URLEncoder.encode("Database error: " + e.getMessage(), StandardCharsets.UTF_8.toString()));
	    }
	}
	
	/**
	 * Convert a user between customer and seller
	 */
	private void convertUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String username = request.getParameter("username");
	    String userType = request.getParameter("userType");
	    String shopName = request.getParameter("shopName");
	    String shopDescription = request.getParameter("shopDescription");
	    
	    if (username == null || username.trim().isEmpty()) {
	        response.sendRedirect("convertUser.jsp?error=" + URLEncoder.encode("Username is required", StandardCharsets.UTF_8.toString()));
	        return;
	    }
	    
	    try (Connection con = ConnectionFactory.getConnection()) {
	        // Check if user exists
	        String checkQuery = "SELECT * FROM user WHERE username = ?";
	        try (PreparedStatement checkStmt = con.prepareStatement(checkQuery)) {
	            checkStmt.setString(1, username);
	            
	            try (ResultSet rs = checkStmt.executeQuery()) {
	                if (!rs.next()) {
	                    response.sendRedirect("convertUser.jsp?error=" + URLEncoder.encode("User not found", StandardCharsets.UTF_8.toString()));
	                    return;
	                }
	                
	                // User exists, get current type
	                String currentType = rs.getString("type");
	                String newType = "user".equals(currentType) ? "seller" : "user";
	                
	                // Update user type
	                String updateQuery = "UPDATE user SET type = ? WHERE username = ?";
	                try (PreparedStatement updateStmt = con.prepareStatement(updateQuery)) {
	                    updateStmt.setString(1, newType);
	                    updateStmt.setString(2, username);
	                    
	                    int rowsAffected = updateStmt.executeUpdate();
	                    
	                    if (rowsAffected > 0) {
	                        // If converting to seller, add seller-specific info
	                        if ("seller".equals(newType) && shopName != null && !shopName.trim().isEmpty()) {
	                            // In a real application, you would have a seller_info table to store this data
	                            // For now, we'll just show a success message
	                        }
	                        
	                        // Conversion successful
	                        String successMsg = "user".equals(currentType) 
	                                ? "User converted to seller successfully" 
	                                : "Seller converted to customer successfully";
	                        response.sendRedirect("convertUser.jsp?success=" + URLEncoder.encode(successMsg, StandardCharsets.UTF_8.toString()));
	                    } else {
	                        // Conversion failed
	                        response.sendRedirect("convertUser.jsp?error=" + URLEncoder.encode("Failed to convert user", StandardCharsets.UTF_8.toString()));
	                    }
	                }
	            }
	        }
	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	        response.sendRedirect("convertUser.jsp?error=" + URLEncoder.encode("Database error: " + e.getMessage(), StandardCharsets.UTF_8.toString()));
	    }
	}
	
	/**
	 * List all users (customers and sellers)
	 */	private void listUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    try (Connection con = ConnectionFactory.getConnection()) {
	        // Get customers
	        List<User> customers = new ArrayList<>();
	        String customerQuery = "SELECT * FROM user WHERE type = 'user'";
	        try (Statement stmt = con.createStatement();
	            ResultSet rs = stmt.executeQuery(customerQuery)) {
	            
	            while (rs.next()) {
	                User user = new User();
	                user.setId(rs.getInt("id"));
	                user.setUsername(rs.getString("username"));
	                user.setFullName(rs.getString("name"));
	                user.setEmail(rs.getString("email"));
	                user.setPhone(rs.getString("phone"));
	                user.setAddress(rs.getString("address"));
	                user.setUserType(rs.getString("type"));
	                user.setPassword(rs.getString("password"));
	                
	                customers.add(user);
	            }
	        }
	        
	        // Get sellers
	        List<Seller> sellers = new ArrayList<>();
	        String sellerQuery = "SELECT * FROM user WHERE type = 'seller'";
	        try (Statement stmt = con.createStatement();
	            ResultSet rs = stmt.executeQuery(sellerQuery)) {
	            
	            while (rs.next()) {
	                Seller seller = new Seller();
	                seller.setId(rs.getInt("id"));
	                seller.setUsername(rs.getString("username"));
	                seller.setFullName(rs.getString("name"));
	                seller.setEmail(rs.getString("email"));
	                seller.setPhone(rs.getString("phone"));
	                seller.setAddress(rs.getString("address"));
	                seller.setPassword(rs.getString("password"));
	                seller.setShopName(""); // Default value for shop name
	                seller.setShopDescription(""); // Default value for shop description
	                
	                sellers.add(seller);
	            }
	        }
	        
	        // Set attributes and forward to JSP
	        String view = request.getParameter("view");
	        if ("delete".equals(view)) {
	            request.setAttribute("customers", customers);
	            request.setAttribute("sellers", sellers);
	            request.getRequestDispatcher("/deleteUser.jsp").forward(request, response);
	        } else if ("convert".equals(view)) {
	            request.setAttribute("customers", customers);
	            request.setAttribute("sellers", sellers);
	            request.getRequestDispatcher("/convertUser.jsp").forward(request, response);
	        } else {
	            // Default view
	            request.setAttribute("customers", customers);
	            request.setAttribute("sellers", sellers);
	            request.getRequestDispatcher("/manageUsers.jsp").forward(request, response);
	        }
	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	        response.sendRedirect("home.jsp?error=" + URLEncoder.encode("Database error: " + e.getMessage(), StandardCharsets.UTF_8.toString()));
	    }
	}
	
	/**
	 * Load admin dashboard with summary data
	 */
	private void loadDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    try (Connection con = ConnectionFactory.getConnection()) {
	        // Get user counts
	        int customerCount = 0;
	        int sellerCount = 0;
	        
	        String countQuery = "SELECT type, COUNT(*) as count FROM user GROUP BY type";
	        try (Statement stmt = con.createStatement();
	             ResultSet rs = stmt.executeQuery(countQuery)) {
	             
	            while (rs.next()) {
	                String type = rs.getString("type");
	                int count = rs.getInt("count");
	                
	                if ("user".equals(type)) {
	                    customerCount = count;
	                } else if ("seller".equals(type)) {
	                    sellerCount = count;
	                }
	            }
	        }
	        
	        // Get recent users (last 5 registered)
	        List<User> recentUsers = new ArrayList<>();
	        String recentUsersQuery = "SELECT * FROM user ORDER BY id DESC LIMIT 5";
	        try (Statement stmt = con.createStatement();
	             ResultSet rs = stmt.executeQuery(recentUsersQuery)) {
	             
	            while (rs.next()) {
	                User user = new User();
	                user.setId(rs.getInt("id"));
	                user.setUsername(rs.getString("username"));
	                user.setFullName(rs.getString("name"));
	                user.setEmail(rs.getString("email"));
	                user.setPhone(rs.getString("phone"));
	                user.setAddress(rs.getString("address"));
	                user.setUserType(rs.getString("type"));
	                
	                recentUsers.add(user);
	            }
	        }
	        
	        // Set attributes and forward to dashboard
	        request.setAttribute("customerCount", customerCount);
	        request.setAttribute("sellerCount", sellerCount);
	        request.setAttribute("recentUsers", recentUsers);
	        request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
	        
	    } catch (SQLException | ClassNotFoundException e) {
	        e.printStackTrace();
	        response.sendRedirect("home.jsp?error=" + URLEncoder.encode("Database error: " + e.getMessage(), StandardCharsets.UTF_8.toString()));
	    }
	}
}
