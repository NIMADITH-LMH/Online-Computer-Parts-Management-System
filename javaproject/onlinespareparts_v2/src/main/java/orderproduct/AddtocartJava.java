package orderproduct;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
// Removed ArrayList import
import java.util.HashSet;

import JDBCConnection.ConnectionFactory;
import Seller.Dashboard.Product;

public class AddtocartJava {
	HashSet<AddtocartJava> cart=new HashSet<>();
	private int id;
	private String image;
	private String description;
	private float totalAmount;
	private int quantity;
	private String username;
	private int ID;
	
	
	
	public AddtocartJava() {
		super();
	}
	public AddtocartJava(int id, String image, String description, float totalAmount, int quantity ,int ID) {
		this.ID=ID;
		this.id = id;
		this.image = image;
		this.description = description;
		this.totalAmount = totalAmount;
		this.quantity = quantity;
	}
	public int getId() {
		return id;
	}
	public String getImage() {
		return image;
	}
	public String getDescription() {
		return description;
	}
	public float getTotalAmount() {
		return totalAmount;
	}
	public int getQuantity() {
		return quantity;
	}
	public String getUsername() {
		return username;
	}
	public int getID() {
		return ID;
	}
	
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	
	
	
	
	public  HashSet<AddtocartJava> select( ) {
		System.out.println(ID);
		cart.clear();
		try(Connection connection=ConnectionFactory.getConnection();){
			try(PreparedStatement preparedStatement = connection.prepareStatement("select id,idproduct,image, description, totalamount, quantity from cart where username=?")){
				preparedStatement.setString(1, username);
				 try (ResultSet resultSet = preparedStatement.executeQuery()) {
	                 while (resultSet.next()) {
	                	 int ID=resultSet.getInt("id");
	                	 System.out.println(ID);
	                     int Id=resultSet.getInt("idproduct");
	                     String Image=resultSet.getString("image");
	                     String Description=resultSet.getString("description");
	                     float TotalAmount=resultSet.getFloat("totalamount");
	                     int Quantities=resultSet.getInt("quantity");
	                     cart.add(new AddtocartJava(Id,Image,Description,TotalAmount,Quantities,ID));
	                     
	                 } 
	                 
				
	             }
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			System.out.println(cart);
		return cart;
		
	}
	public  HashSet<AddtocartJava> delete(){
		
		try(Connection connection=ConnectionFactory.getConnection();){
			try(PreparedStatement preparedStatement = connection.prepareStatement("delete  from cart where id=?")){
				preparedStatement.setInt(1, id);
				int resultSet = preparedStatement.executeUpdate();
				if(resultSet>0) {
					
				}
				else {
					
				}
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			System.out.println(cart);
		return cart;
	}
	
	
	
}
