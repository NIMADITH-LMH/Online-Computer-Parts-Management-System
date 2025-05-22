package orderproduct;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import JDBCConnection.ConnectionFactory;

public class Ordertojava {
	private int idproduct;
    private int cartid;
    private String pname;
    private double price;
    private int quantity;
    private double totalAmount;
    private String address;
    private String username;
    private String image;
    private String cvv;
    private String expyear;
    private String expmonth;
    private String cardnumber;
    private String cname;
    ArrayList<Ordertojava> ojarr=new ArrayList<>();

    public Ordertojava(String username, String cvv, String expyear, String cardnumber, String cname,String expmonth) {
		super();
		this.username = username;
		this.cvv = cvv;
		this.expyear = expyear;
		this.expmonth=expmonth;
		this.cardnumber = cardnumber;
		this.cname = cname;
	}

	public Ordertojava(int idproduct, int cartid, double price, int quantity, String username, String address, String pname, String image) {
        this.image = image;
        this.idproduct = idproduct;
        this.cartid = cartid;
        this.pname = pname;
        this.price = price;
        this.quantity = quantity;
        this.totalAmount = price ;
        this.address = address;
        this.username = username;

        System.out.println(idproduct);
        System.out.println(cartid);
        System.out.println(price);
        System.out.println(pname);
        System.out.println(quantity);
        System.out.println(totalAmount);
        System.out.println(address);
    }

    public int getIdproduct() {
        return idproduct;
    }

    public int getCartid() {
        return cartid;
    }

    public String getPname() {
        return pname;
    }

    public double getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public String getAddress() {
        return address;
    }

    public String getUsername() {
        return username;
    }

    public String getImage() {
        return image;
    }

    public Ordertojava() {
		super();
	}
    

	public String getCvv() {
		return cvv;
	}

	

	public String getExpyear() {
		return expyear;
	}

	public String getExpmonth() {
		return expmonth;
	}

	public String getCardnumber() {
		return cardnumber;
	}

	public String getCname() {
		return cname;
	}

	public ArrayList<Ordertojava> getOjarr() {
		return ojarr;
	}

	public String selectCatrt() {
        try (Connection connection = ConnectionFactory.getConnection()) {
            try (PreparedStatement preparedStatement = connection.prepareStatement("SELECT pname FROM product WHERE idproduct=?")) {
                preparedStatement.setInt(1, idproduct);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        pname = resultSet.getString("pname");
                        System.out.println(pname);
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return pname;
    }

    public String selectaddress() {
        try (Connection connection = ConnectionFactory.getConnection()) {
            try (PreparedStatement preparedStatement = connection.prepareStatement("SELECT address FROM user WHERE username=?")) {
                preparedStatement.setString(1, username);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        address = resultSet.getString("address");
                        System.out.println(address);
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return address;
    }

    public void insert() {
     
        try (Connection connection = ConnectionFactory.getConnection()) {
            String query = "INSERT INTO orders(productid, pname, price, quantity, address, username,image) VALUES (?, ?, ?, ?, ?, ?,?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, idproduct);
                preparedStatement.setString(2, pname);
                preparedStatement.setDouble(3, price);
                preparedStatement.setInt(4, quantity);
                preparedStatement.setString(5, address);
                preparedStatement.setString(6, username);
                preparedStatement.setString(7, image);
                preparedStatement.executeUpdate();
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public void deleteCart() {
        try (Connection connection = ConnectionFactory.getConnection()) {
            String query = "DELETE FROM cart WHERE id=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, cartid);
                preparedStatement.executeUpdate();
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    public ArrayList<Ordertojava> selectCardDetails(String id) {
    	ojarr.clear();
    	try (Connection connection = ConnectionFactory.getConnection()) {
            try (PreparedStatement preparedStatement = connection.prepareStatement("SELECT username,cname,cardnumber,cvv,expmonth,expyear FROM card WHERE username=?")) {
                preparedStatement.setString(1, id);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        String cname = resultSet.getString("cname");
                        System.out.println(cname);
                        String username = resultSet.getString("username");
                        System.out.println(username);
                        String cvv = resultSet.getString("cvv");
                        System.out.println(cvv);
                        String expmonth = resultSet.getString("expmonth");
                        System.out.println(expmonth);
                        String cardnumber = resultSet.getString("cardnumber");
                        System.out.println(cardnumber);
                        String expyear = resultSet.getString("expyear");
                        System.out.println(expyear);
                        ojarr.add(new Ordertojava( username,  cvv,  expyear,  cardnumber,  cname,expmonth));
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    	return ojarr;
       
    }
    public ArrayList<Ordertojava> deleteOrders(String username,int id)	 {
    	try(Connection connection=ConnectionFactory.getConnection();){
			try(PreparedStatement preparedStatement = connection.prepareStatement("delete  from orders where productid=? and username=?")){
				preparedStatement.setInt(1, id);
				preparedStatement.setString(2, username);
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
			System.out.println(ojarr);
		return ojarr;
    }
    public void updateCardDetails(String username,String cname,String cvv,String expmonth,String cnumber, String expYears) {
    	try (Connection connection = ConnectionFactory.getConnection()) {
            String query = "UPDATE  card set username=?, cname=?,cardnumber=?, cvv=?, expmonth=?,expyear=?  where username=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            	
            	if(cnumber.length()<3) {
        			throw new IllegalArgumentException("Card number is too sort");
        		}
        		String lastThreedigit=cnumber.substring(cnumber.length()-3);
        		String mask="*".repeat(cnumber.length()-3);
        		String Amask=mask+lastThreedigit;
        		String Mask="*".repeat(cvv.length());
        		
            
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, cname);
                preparedStatement.setString(3, Amask);
                preparedStatement.setString(4, Mask);
                preparedStatement.setString(5, expmonth);
                preparedStatement.setString(6, expYears);
                preparedStatement.setString(7, username);
                
                preparedStatement.executeUpdate();
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
	public void DeleteCard(String username) {
		try(Connection connection=ConnectionFactory.getConnection();){
			try(PreparedStatement preparedStatement = connection.prepareStatement("delete  from card where username=? ")){
				
				preparedStatement.setString(1, username);
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
			System.out.println(ojarr);
		
	}
	
	public void updateQuantityAfterUpdate(int quantity, int idproduct ,int aQuantity) {
		try (Connection connection = ConnectionFactory.getConnection()) {
			
            String query = "UPDATE  product set quantity=? where idproduct=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            	
        		int q=aQuantity-quantity;
            
                preparedStatement.setInt(1, q);
                
                preparedStatement.setInt(2, idproduct);
                
                preparedStatement.executeUpdate();
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
	}
	public void updateQuantityAfterDelete(int quantity, int idproduct ,int aQuantity) {
		try (Connection connection = ConnectionFactory.getConnection()) {
			
            String query = "UPDATE  product set quantity=? where idproduct=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            	
        		int q=aQuantity+quantity;
            
                preparedStatement.setInt(1, q);
                
                preparedStatement.setInt(2, idproduct);
                
                preparedStatement.executeUpdate();
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
	}
	
	public int selectQuantity(int idp) {
		int quantityies=0;
		try (Connection connection = ConnectionFactory.getConnection()) {
            try (PreparedStatement preparedStatement = connection.prepareStatement("SELECT quantity FROM product WHERE idproduct=?")) {
                preparedStatement.setInt(1, idp);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                       quantityies = resultSet.getInt("quantity");
                        System.out.println(quantity);
                        
                        
                        
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
		return quantityies;
		
	}
}
