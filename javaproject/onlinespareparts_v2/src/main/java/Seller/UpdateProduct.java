package Seller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
// Removed WebServlet import
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import JDBCConnection.ConnectionFactory;
import Seller.Dashboard.Product;

/**
 * Servlet implementation class UpdateProduct
 */
@MultipartConfig
public class UpdateProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
	  private static final String imageDirectory="C:/Users/NIMADITH/Desktop/Java File/javaproject/onlinespareparts_v2/src/main/webapp/image/";   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateProduct() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ArrayList<Product> productList = new ArrayList<>();
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String pname = request.getParameter("pname");
        String producttype = request.getParameter("producttype");
        String price = request.getParameter("price");
        String quantity = request.getParameter("quantity");
        String description = request.getParameter("description");
        String id = request.getParameter("id");
        Part imagePart = request.getPart("image");
        String imageFileName=imagePart.getSubmittedFileName();
        System.out.println("Selected image name is "+imageFileName);
        String uploadpath=imageDirectory+imageFileName;
       try {
    	   FileOutputStream fos=new FileOutputStream(uploadpath);
           InputStream is=imagePart.getInputStream();
           byte[] data=new byte[is.available()];
           is.read(data);
           fos.write(data);
           fos.close();
           
       }catch(Exception e) {
    	   e.printStackTrace();
       }
        

       
        String updateQuery = "UPDATE product SET pname=?, producttype=?, price=?, quantity=?, description=?, image=? WHERE idproduct=?;";
        // Connect to the database and execute the update query
        try (Connection con = ConnectionFactory.getConnection();PreparedStatement ps = con.prepareStatement(updateQuery)) {
          
            
                ps.setString(1, pname);
                ps.setString(2, producttype);
                ps.setString(3, price);
                ps.setString(4, quantity);
                ps.setString(5, description);
                ps.setString(6, imageFileName);
                ps.setString(7, id);

                int rowsUpdated = ps.executeUpdate(); // Use executeUpdate for an update query
                if (rowsUpdated > 0) {
                    // Update successful
                	request.setAttribute("productList", productList);
                    request.getRequestDispatcher("/home.jsp").forward(request, response);
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
