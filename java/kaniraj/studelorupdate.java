 	package kaniraj;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet implementation class studelorupdate
 */
public class studelorupdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public studelorupdate() {
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
		PrintWriter out=response.getWriter();
		try
		{
		String action1=request.getParameter("action");
		String staffid1=request.getParameter("staffid");
			
		System.out.println(" action "+action1);
		System.out.println(" staffid "+staffid1);
		
		
		if(action1!=null && staffid1!=null && !staffid1.trim().isEmpty())
		{

			//request.setAttribute("id",staffid1);
HttpSession hs=request.getSession();
hs.setAttribute("sid", staffid1);
			
			System.out.println(" studel id "+staffid1);
			System.out.println(" studel action "+action1);
			
			if(action1.equals("update"))
			{
				
				 response.sendRedirect("stuupdate.jsp");

//				RequestDispatcher rd=request.getRequestDispatcher("Update.jsp");
//				rd.include(request, response);

			}
			else if(action1.equals("delete"))
			{
				System.out.println(" delete hii ");
					
//				out.println("<script type='text/javascript'>");
//				out.println("window.location.href('studelete.jsp')");
//				out.println("</script>");
								response.sendRedirect("studelete.jsp");
//		RequestDispatcher rd=request.getRequestDispatcher("studelete.jsp");
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
	}
		doGet(request, response);
			
	}

}
