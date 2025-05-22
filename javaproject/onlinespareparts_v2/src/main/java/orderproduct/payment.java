package orderproduct;

import jakarta.servlet.ServletException;
// Removed WebServlet import
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class payment
 */
public class payment extends HttpServlet {
	private static final long serialVersionUID = 1L;
    PaymentJava pj;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public payment() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 try {
	            String username = request.getParameter("username");
	            System.out.println(username);
	            String expYr = request.getParameter("year");
	            System.out.println(expYr);
	            String expMonth = request.getParameter("month");
	            System.out.println(expMonth);
	            String totalAmount = request.getParameter("totalAmount");  	

	            if (totalAmount == null || totalAmount.isEmpty()) {
	                throw new IllegalArgumentException("Total amount is missing or invalid.");
	            }

	            double amount = Double.parseDouble(totalAmount);

	            String cardNumber = request.getParameter("cardNumber");
	            String cname = request.getParameter("cname");
	            String cvv = request.getParameter("cvv");

	            if (username == null || cardNumber == null || cvv == null || expYr == null || expMonth == null || cname == null) {
	                throw new IllegalArgumentException("One or more required fields are missing.");
	            }

	            
	            cardNumber = PaymentJava.maskCardnumber(cardNumber);
	            cvv = PaymentJava.maskcvvnumber(cvv);

	            pj = new PaymentJava(cardNumber, cvv, username, expMonth, amount, cname,expYr);
	            String store=request.getParameter("store");
	            if(store==null) {
	            	 pj.insertPayment();
	            }
	            else {
	            	 pj.insertPayment();
	            	 pj.insertCard();
	            }
	           

	            request.setAttribute("message", "Payment made successfully!");
	            request.getRequestDispatcher("/paymentsuccess.jsp").forward(request, response);
	        } catch (NumberFormatException e) {
	            request.setAttribute("message", "Invalid amount format.");
	            request.getRequestDispatcher("/paymenterror.jsp").forward(request, response);
	        } catch (IllegalArgumentException e) {
	            request.setAttribute("message", e.getMessage());
	            request.getRequestDispatcher("/paymenterror.jsp").forward(request, response);
	        }
	}

}
