package Seller;

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
import java.util.ArrayList;

import JDBCConnection.ConnectionFactory;
/**
 * Servlet implementation class Dashboard


 */
public class Dashboard extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final String imageDirectory="C:/Users/NIMADITH/Desktop/Java File/javaproject/onlinespareparts_v2/src/main/webapp/image/";
     
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Dashboard() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ArrayList<Product> productList = new ArrayList<>();
		String username = request.getParameter("id");
		
		System.out.println(username);
		

		

		// Connect to the database and execute the query
		String selectQuery = "SELECT idproduct,pname, producttype, price, quantity, description, image,usrname FROM product WHERE usrname = ?;";
			try(Connection con=ConnectionFactory.getConnection();PreparedStatement ps = con.prepareStatement(selectQuery);){
				
			

				ps.setString(1, username);
				try (ResultSet rs = ps.executeQuery()) {
					while (rs.next()) {
						// Retrieve product details
						int idproduct = rs.getInt("idproduct");
						System.out.println(idproduct);
						String name = rs.getString("pname");
						System.out.println(name);
						String producttype = rs.getString("producttype");
						String price = rs.getString("price");
						String quantity = rs.getString("quantity");
						String description = rs.getString("description");
						String image = rs.getString("image");
						String Username=rs.getString("usrname");
						double Price=Double.parseDouble(price);
						int Quantity=Integer.parseInt(quantity);
						System.out.println(idproduct);
						// Set attributes and forward to profile page
						productList.add(new Product(idproduct, name, producttype,Price, Quantity,description,image,Username));
						
					} 
					request.setAttribute("productList", productList);
					request.getRequestDispatcher("/Dashboard.jsp").forward(request, response);
				}
				catch (SQLException e) {
					e.printStackTrace();
					request.setAttribute("norecord", "Database error: " + e.getMessage());
					System.out.println("1");
		            request.getRequestDispatcher("/register.jsp").forward(request, response);
				}
			}
			catch (SQLException e) {
				e.printStackTrace();
				System.out.println("2");
				request.setAttribute("norecord", "Database error: " + e.getMessage());
	            request.getRequestDispatcher("/register.jsp").forward(request, response);
			} catch (ClassNotFoundException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		
	}
	public class Product {
        private int idproduct;
        private String pname;
        private String producttype;
        private String username;
        private double price;
        private int quantity;
        private String decription;
        
        private String image;

		public Product(int idproduct, String pname, String producttype, double price, int quantity, String decription,
				String image,String username) {
			super();
			this.idproduct = idproduct;
			this.pname = pname;
			this.producttype = producttype;
			this.price = price;
			this.quantity = quantity;
			this.decription = decription;
			this.image = image;
			this.username=username;
		}

		public int getIdproduct() {
			return idproduct;
		}

		public String getPname() {
			return pname;
		}

		public String getProducttype() {
			return producttype;
		}

		public double getPrice() {
			return price;
		}

		public int getQuantity() {
			return quantity;
		}

		public String getDecription() {
			return decription;
		}

		public String getImage() {
			return image;
		}
		public String getUsername() {
			return username;
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
