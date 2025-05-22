package orderproduct;

import jakarta.servlet.ServletException;
// Removed WebServlet import
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class order
 */
public class order extends HttpServlet {
	private static final long serialVersionUID = 1L;
    Ordertojava orders;  
    ArrayList<Ordertojava> arr=new ArrayList<>();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public order() {
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
		String[] selectedProductIds = request.getParameterValues("selectedProducts");
        if (selectedProductIds == null || selectedProductIds.length == 0) {
            request.setAttribute("error", "No products selected.");
            request.getRequestDispatcher("/shopping-cart.jsp").forward(request, response);
            return;
        }

        String username = request.getParameter("username");
        ArrayList<Ordertojava> arr = new ArrayList<>();
       
        for (String productId : selectedProductIds) {
            String idproduct = request.getParameter("idproduct");
            String cartid = request.getParameter("cartid");
            String total = request.getParameter("total");
            String quantity = request.getParameter("quantity");
            String image = request.getParameter("image");

            int Idproduct = Integer.parseInt(idproduct);
            System.out.println(Idproduct);
            int CartId = Integer.parseInt(cartid);
            double Total = Double.parseDouble(total);
            int Quantity = Integer.parseInt(quantity);

           
            Ordertojava orders = new Ordertojava( Idproduct,  CartId,  Total,  Quantity,  username,  " ", " ",  image);
            System.out.println(Idproduct);
            orders.selectCatrt(); // Fetch pname
            orders.selectaddress(); // Fetch address

            // Insert the order and delete the cart entry
            orders.insert();
            orders.deleteCart();
            int q=orders.selectQuantity(Idproduct);
            System.out.println(q);
            orders.updateQuantityAfterUpdate(Quantity, Idproduct,q);
            arr.add(orders); 	
        }

        
        request.setAttribute("array", arr);
        request.getRequestDispatcher("/Payment.jsp").forward(request, response);
		
	}

}
