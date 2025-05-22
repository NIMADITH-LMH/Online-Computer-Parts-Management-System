package orderproduct;

import jakarta.servlet.ServletException;
// Removed WebServlet import
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class DeleteOrders
 */
public class DeleteOrders extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Ordertojava otj=new Ordertojava();  
	ArrayList<Ordertojava> arr=new ArrayList<>();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteOrders() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username=request.getParameter("username");
		String id=request.getParameter("id");
		String quantity=request.getParameter("quantity");
		int Quantity=Integer.parseInt(quantity);
		int ID=Integer.parseInt(id);
		otj.deleteOrders(username,ID);
		
		System.out.println(quantity);
		int q=otj.selectQuantity(ID);
		System.out.println(q);
		otj.updateQuantityAfterDelete(Quantity, ID,q);
		request.getRequestDispatcher("/Orders.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
