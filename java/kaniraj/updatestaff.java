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
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class updatestaff
 */
public class updatestaff extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updatestaff() {
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

//		HttpSession st=request.getSession(false);
//		String sid=(String)st.getAttribute("sid");
//		
		try
		{
			String id=request.getParameter("nid");
			System.out.println("nid "+id);
			
			HttpSession session=request.getSession(false);
		String col=(String)session.getAttribute("col");

		if (id != null && !id.trim().isEmpty()) {
		Connection con=Dbconnection.getConnection();
String updateQuery;
        if (col.equals("shift") || col.equals("phoneno")) {
        
        if(col.equals("shift"))	
        	updateQuery = "UPDATE staff SET " + col + " = ? WHERE id = ?";
        else
        	updateQuery = "UPDATE staff SET contactno= ? WHERE id = ?";
        	
        
        } else {
            updateQuery = "UPDATE staff SET " + col + " = ? WHERE id = ?";
        }

     PreparedStatement ps = con.prepareStatement(updateQuery);

        if (col.equals("shift")) {
            ps.setInt(1, Integer.parseInt(request.getParameter("val")));
        } else if (col.equals("phoneno")) {
            ps.setLong(1, Long.parseLong(request.getParameter("val")));
        } else {
            ps.setString(1, request.getParameter("val"));
        }
        
        ps.setInt(2, Integer.parseInt(id));

        int rowsUpdated = ps.executeUpdate();
        if (rowsUpdated > 0) {
        	out.println("<script type='text/javascript'>");
            out.println("alert('Data updated successfully');");
            out.println("window.location.href='allstaff.jsp'");
            out.println("</script>");
//        RequestDispatcher rd=request.getRequestDispatcher("Update.jsp");
//        rd.forward(request, response);

        } else {
        	out.println("<script type='text/javascript'>");
            out.println("alert('Failed to update data.');");
        	out.println("</script>");
            RequestDispatcher rd=request.getRequestDispatcher("Update.jsp");
            rd.forward(request, response);

        	//            response.sendRedirect("Update.jsp");
        }
		
		
        
		} else {
            out.println("ID is null or empty.");
        }
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		doGet(request, response);
	}

}
