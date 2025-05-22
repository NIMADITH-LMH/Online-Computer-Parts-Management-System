package orderproduct;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import JDBCConnection.ConnectionFactory;

public class PaymentJava {
	private String number;
	private String cvv;
	private String username;
	private String expyear;
	private double totalAmount;
	private String cname;
	private String expmonth;
	
	public String getNumber() {
		return number;
	}
	public String getCvv() {
		return cvv;
	}
	public String getUsername() {
		return username;
	}
	
	public String getExpyear() {
		return expyear;
	}
	public String getExpmonth() {
		return expmonth;
	}
	public double getTotalAmount() {
		return totalAmount;
	}
	public String getCname() {
		return cname;
	}
	
	
	public PaymentJava(String number, String cvv, String username, String expyear, double totalAmount, String cname,
			String expmonth) {
		super();
		this.number = number;
		this.cvv = cvv;
		this.username = username;
		this.expyear = expyear;
		this.totalAmount = totalAmount;
		this.cname = cname;
		this.expmonth = expmonth;
	}
	public  static String maskCardnumber(String card) {
		if(card.length()<3) {
			throw new IllegalArgumentException("Card number is too sort");
		}
		String lastThreedigit=card.substring(card.length()-3);
		String mask="*".repeat(card.length()-3);
		return mask+lastThreedigit;
	}
	public static String maskcvvnumber(String cvv) {
		String mask="*".repeat(cvv.length());
		return mask;
	}
	public void insertPayment() {
		try (Connection connection = ConnectionFactory.getConnection()) {
            String query = "INSERT INTO payment(username, totalamount, cname, cvv, expmonth, cardnumber,expyear) VALUES (?, ?, ?, ?, ?, ?,?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, username);
                preparedStatement.setDouble(2, totalAmount);
                preparedStatement.setString(3, cname);
                preparedStatement.setString(4, cvv);
                preparedStatement.setString(5, expmonth);
                preparedStatement.setString(6, number);
                preparedStatement.setString(7, expyear);
                preparedStatement.executeUpdate();
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
	}
	public void insertCard() {
		try (Connection connection = ConnectionFactory.getConnection()) {
            String query = "INSERT INTO card(username, cname,cardnumber,cvv,expmonth,expyear) VALUES (?, ?,?,?,?,?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, cname);
                preparedStatement.setString(3, number);
                preparedStatement.setString(4, cvv);
                preparedStatement.setString(5, expmonth);
                preparedStatement.setString(6, expyear);
                preparedStatement.executeUpdate();
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
	}
	
}
