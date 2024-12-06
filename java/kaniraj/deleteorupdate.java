package kaniraj;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet implementation class deleteorupdate
 */
public class deleteorupdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteorupdate() {
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

		response.setContentType("text/html");
//		String action=request.getParameter("action");
//		String staffid=request.getParameter("staffid");
		
		try
		{
		String action1=request.getParameter("action");
		String staffid1=request.getParameter("staffid");
			
		System.out.println(" action "+action1);
		System.out.println(" staffid "+staffid1);
		
		
		if(action1!=null && staffid1!=null && !staffid1.trim().isEmpty())
		{

//			request.setAttribute("id",staffid1);
HttpSession hs=request.getSession();
hs.setAttribute("sid", staffid1);
			
			System.out.println(" id "+staffid1);
			if(action1.equals("update"))
			{
				
				 response.sendRedirect("Update.jsp");

//				RequestDispatcher rd=request.getRequestDispatcher("Update.jsp");
//				rd.include(request, response);

			}
			else if(action1.equals("delete"))
			{

//				window.location.href("Delete.jsp");
				response.sendRedirect("Delete.jsp");
//		RequestDispatcher rd=request.getRequestDispatcher("Delete.jsp");
//				rd.forward(request,response);
			}
			else
				System.out.println(" request parsing error ");
			
		}
		else
			System.out.println(" null String parsing error ");				
		
	}
	catch(Exception e)
	{
		e.printStackTrace();
		
		doGet(request, response);
	}

}
}