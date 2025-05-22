package homeServlat;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
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

/**
 * Servlet implementation class homeservlat
 */
@WebServlet(name = "homeservlat", urlPatterns = {"/homeservlat", "/"})
public class homeservlat extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public homeservlat() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
    	ArrayList<ProductData> productList = new ArrayList<>();
		String username = request.getParameter("id");
		System.out.println("Username parameter: " + username);
		
		// Connect to the database and execute the query
		String selectQuery = "SELECT idproduct, pname, producttype, price, quantity, description, image FROM product";
		try {
            Connection con = ConnectionFactory.getConnection(); 
            if (con == null) {
                System.err.println("Database connection is null");
                request.setAttribute("products", new ArrayList<ProductData>()); // Send empty list
                request.getRequestDispatcher("/home.jsp").forward(request, response);
                return;
            }
            
            PreparedStatement ps = con.prepareStatement(selectQuery);
			ResultSet rs = ps.executeQuery();
				
            if (rs != null) {
                while (rs.next()) {
                    try {
                        // Retrieve product details with null checks
                        int idproduct = rs.getInt("idproduct");
                        String name = rs.getString("pname") != null ? rs.getString("pname") : "Unknown";
                        String producttype = rs.getString("producttype") != null ? rs.getString("producttype") : "Other";
                        String price = rs.getString("price") != null ? rs.getString("price") : "0";
                        String quantity = rs.getString("quantity") != null ? rs.getString("quantity") : "0";
                        String description = rs.getString("description") != null ? rs.getString("description") : "";
                        String image = rs.getString("image") != null ? rs.getString("image") : "";
                        
                        // Parse with safety checks
                        double Price;
                        try {
                            Price = Double.parseDouble(price);
                        } catch (NumberFormatException e) {
                            Price = 0.0;
                        }
                        
                        int Quantity;
                        try {
                            Quantity = Integer.parseInt(quantity);
                        } catch (NumberFormatException e) {
                            Quantity = 0;
                        }
                        
                        // Create a Product object using our own ProductData class
                        ProductData product = new ProductData(idproduct, name, description, producttype, Price, Quantity, image, "");
                        productList.add(product);
                        System.out.println("Added product: " + name);
                    } catch (SQLException e) {
                        System.err.println("Error processing a product: " + e.getMessage());
                        // Continue to next product instead of failing completely
                    }
                }                // Close resources to prevent leaks
                if (rs != null) {
                    try {
                        rs.close();
                    } catch (SQLException e) {
                        System.err.println("Error closing ResultSet: " + e.getMessage());
                    }
                }
                if (ps != null) {
                    try {
                        ps.close();
                    } catch (SQLException e) {
                        System.err.println("Error closing PreparedStatement: " + e.getMessage());
                    }
                }
                if (con != null) {
                    try {
                        con.close();
                    } catch (SQLException e) {
                        System.err.println("Error closing Connection: " + e.getMessage());
                    }
                }
            }
            
            // Set the products attribute and forward to home.jsp
            request.setAttribute("products", productList);
            request.getRequestDispatcher("/home.jsp").forward(request, response);
            
        } catch (SQLException e) {
            System.err.println("SQL Exception in homeservlat: " + e.getMessage());
            e.printStackTrace();
            // Send user to home page with empty product list instead of login page
            request.setAttribute("products", new ArrayList<ProductData>());
            request.getRequestDispatcher("/home.jsp").forward(request, response);
        } catch (ClassNotFoundException e) {
            System.err.println("Class not found in homeservlat: " + e.getMessage());
            e.printStackTrace();
            // Send user to home page with empty product list
            request.setAttribute("products", new ArrayList<ProductData>());
            request.getRequestDispatcher("/home.jsp").forward(request, response);
        } catch (Exception e) {
            // Catch any other exceptions
            System.err.println("General exception in homeservlat: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("products", new ArrayList<ProductData>());
            request.getRequestDispatcher("/home.jsp").forward(request, response);
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
	
	// Create our own Product class to avoid inner class issues
	public static class ProductData {
        private int id;
        private String name;
        private String description;
        private String type;
        private double price;
        private int quantity;
        private String image;
        private String seller;
        
        public ProductData() {
        }
        
        public ProductData(int id, String name, String description, String type, double price, int quantity, String image, String seller) {
            this.id = id;
            this.name = name;
            this.description = description;
            this.type = type;
            this.price = price;
            this.quantity = quantity;
            this.image = image;
            this.seller = seller;
        }
        
        public int getId() {
            return id;
        }
        
        public void setId(int id) {
            this.id = id;
        }
        
        public String getName() {
            return name;
        }
        
        public void setName(String name) {
            this.name = name;
        }
        
        public String getDescription() {
            return description;
        }
        
        public void setDescription(String description) {
            this.description = description;
        }
        
        public String getType() {
            return type;
        }
        
        public void setType(String type) {
            this.type = type;
        }
        
        public double getPrice() {
            return price;
        }
        
        public void setPrice(double price) {
            this.price = price;
        }
        
        public int getQuantity() {
            return quantity;
        }
        
        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }
        
        public String getImage() {
            return image;
        }
        
        public void setImage(String image) {
            this.image = image;
        }
        
        public String getSeller() {
            return seller;
        }
        
        public void setSeller(String seller) {
            this.seller = seller;
        }
    }
}
