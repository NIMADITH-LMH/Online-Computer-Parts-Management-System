package orderproduct;

import jakarta.servlet.ServletException;
// Removed WebServlet import
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class BeforeCardUpdate
 */
public class BeforeCardUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Ordertojava oj=new Ordertojava();    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BeforeCardUpdate() {
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
		ArrayList<Ordertojava> ojr=new ArrayList<>();
		String username=request.getParameter("username");
		ojr.clear();
		ojr=oj.selectCardDetails(username);
		request.setAttribute("cards", ojr);
        request.getRequestDispatcher("/Upcard.jsp").forward(request, response);
	}

}
