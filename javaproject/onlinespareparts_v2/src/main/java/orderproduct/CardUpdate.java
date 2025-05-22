package orderproduct;

import jakarta.servlet.ServletException;
// Removed WebServlet import
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class CardUpdate
 */
public class CardUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Ordertojava otj=new Ordertojava();   
	ArrayList<Ordertojava> cd=new ArrayList<Ordertojava>();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CardUpdate() {
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
		String username=request.getParameter("username");
		String cname=request.getParameter("cname");
		String cvv=request.getParameter("cvv");
		String expmonth=request.getParameter("expmonth");
		String cnumber=request.getParameter("cnumber");
		String expyear=request.getParameter("expyear");
		otj.updateCardDetails(username,cname,cvv,expmonth,cnumber,expyear);
		cd=otj.selectCardDetails(username);
		request.setAttribute("cards", cd);
        request.getRequestDispatcher("/Cards.jsp").forward(request, response);
	}

}
