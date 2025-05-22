package homeServlat;

import jakarta.servlet.ServletException;
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
 * Servlet implementation class productDetails
 */
public class productDetails extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public productDetails() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<Product> productList = new ArrayList<>();
        String productType = request.getParameter("id");  // Renamed 'username' to 'productType'
        System.out.println(productType);

        if (productType == null || productType.isEmpty()) {
            request.setAttribute("error", "Product ID is missing.");
            request.getRequestDispatcher("/home.jsp").forward(request, response);
            return;
        }

        // Query for fetching product details
        String selectQuery = "SELECT idproduct, pname, producttype, price, quantity, description, image FROM product WHERE producttype = ?;";

        try (Connection con = ConnectionFactory.getConnection(); 
             PreparedStatement ps = con.prepareStatement(selectQuery)) {

            ps.setString(1, productType);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int idproduct = rs.getInt("idproduct");
                    String name = rs.getString("pname");
                    String producttype = rs.getString("producttype");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    String description = rs.getString("description");
                    String image = rs.getString("image");

                    Product product = new Product(idproduct, name, description, producttype, price, quantity, image, "");
                    productList.add(product);
                }

                request.setAttribute("productList", productList);
                request.getRequestDispatcher("/productAll.jsp").forward(request, response);

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("norecord", "Database error: " + e.getMessage());
                request.getRequestDispatcher("/error.jsp").forward(request, response);  // Forward to a meaningful error page
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("norecord", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (ClassNotFoundException e1) {
            e1.printStackTrace();
            request.setAttribute("norecord", "Class not found error: " + e1.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    public static class Product {
        private int id;
        private String name;
        private String description;
        private String type;
        private double price;
        private int quantity;
        private String image;
        private String seller;
        
        public Product() {
        }
        
        public Product(int id, String name, String description, String type, double price, int quantity, String image, String seller) {
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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
