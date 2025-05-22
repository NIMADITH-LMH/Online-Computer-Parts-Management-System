package orderproduct;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;

import JDBCConnection.ConnectionFactory;
/**
 * Servlet implementation class AddToCartServlat
 */
public class AddToCartServlat extends HttpServlet {
	private static final long serialVersionUID = 1L;
    AddtocartJava addjava=new AddtocartJava();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddToCartServlat() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HashSet<AddtocartJava> cart=new HashSet<>();
		String idproduct=request.getParameter("productId");
		String totalAmount=request.getParameter("totalAmount");
		String description=request.getParameter("description");
		String image=request.getParameter("image");
		String quantity=request.getParameter("quantity");
		String username=request.getParameter("username");
		int id=Integer.parseInt(idproduct);
		int Quantity=Integer.parseInt(quantity);
		float totalamount=Float.parseFloat(totalAmount);
		System.out.println(idproduct);
		System.out.println(totalAmount);
		System.out.println(description);
		System.out.println(image);
		System.out.println(quantity);
		System.out.println(username);
		try(Connection connection = ConnectionFactory.getConnection();){
			
		
		try( PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO cart (idproduct,image, description, totalamount, quantity,username) VALUES (?, ?, ?,?,?,?)")){
			preparedStatement.setInt(1, id);
			preparedStatement.setString(2, image);
			preparedStatement.setString(3, description);
			preparedStatement.setFloat(4, totalamount);
			preparedStatement.setInt(5, Quantity);
			preparedStatement.setString(6, username);
			int row = preparedStatement.executeUpdate();
			addjava.setUsername(username);
			cart.clear();
			cart=addjava.select();
			int Id=addjava.getID();
			request.setAttribute("cart", cart);
			request.setAttribute("ID", Id);
			request.getRequestDispatcher("/cartInterface.jsp").forward(request, response);
		} 
		
	} catch (ClassNotFoundException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	} catch (SQLException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}  
		
		
		
	}

}
