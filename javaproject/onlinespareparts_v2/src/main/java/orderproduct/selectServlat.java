package orderproduct;

import jakarta.servlet.ServletException;
// Removed WebServlet import
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
// Removed ArrayList import
import java.util.HashSet;

/**
 * Servlet implementation class selectServlat
 */
public class selectServlat extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HashSet<AddtocartJava> cart=new HashSet<AddtocartJava>();
    AddtocartJava add=new AddtocartJava();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public selectServlat() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		cart.clear();
		String user=request.getParameter("id");
		System.out.println(user);
		add.setUsername(user);
		if(user!=null) {
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
		
		
		//doGet(request, response);
	}

}
