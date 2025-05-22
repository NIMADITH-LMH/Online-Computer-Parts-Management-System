package orderproduct;

import jakarta.servlet.ServletException;
// Removed WebServlet import
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashSet;

/**
 * Servlet implementation class DeleteCartServlat
 */
public class DeleteCartServlat extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HashSet<AddtocartJava> cart=new HashSet<AddtocartJava>();
    AddtocartJava add=new AddtocartJava();  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteCartServlat() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		cart.clear();
		String id=request.getParameter("id");
		String user=request.getParameter("username");
		int Id=Integer.parseInt(id);
		System.out.println(Id);
		
		if(id!=null) {
			cart.clear();
			add.setId(Id);
			add.setUsername(user);
			add.delete();
			cart=add.select();
			request.setAttribute("cart", cart);
			request.getRequestDispatcher("/cartInterface.jsp").forward(request, response);
			System.out.println(cart);
		}
		else {
			request.getRequestDispatcher("/home.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

}
