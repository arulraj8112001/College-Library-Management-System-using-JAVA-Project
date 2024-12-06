package kaniraj;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet implementation class adddata
 */
public class adddataservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public adddataservlet() {
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

		System.out.println(" insid page  ");
	
	ServletContext sc=getServletContext();
		String s=(String) sc.getAttribute("added");
System.out.println(" now "+s);
		String query="";
		String q1="";
		String ndept="";
		String nsttype="";
		int nshift=0;
		if(s.equals("department"))
		{
			 ndept=request.getParameter("dept");
			q1="SELECT COUNT(*) FROM staffdetails where department=?";  //'"ndept+"'";
			query="insert into staffdetails(department) values('"+ndept+"')";
		}
		else if(s.equals("stafftype"))
		{
			 nsttype=request.getParameter("staff");
			q1="SELECT COUNT(*) FROM staffdetails where stafftype=?";  //'"+nsttype+"'";
			query="insert into staffdetails(stafftype) values('"+nsttype+"')";
		}
		else
		{
			 nshift=Integer.parseInt(request.getParameter("shift"));
			q1="SELECT COUNT(*) FROM staffdetails where shift=?";  //+nshift;
			query="insert into staffdetails(shift) values("+nshift+")";				
		}
		
		System.out.println(" all data geting page  ");

			Connection con=Dbconnection.getConnection();
			PreparedStatement pst=con.prepareStatement(q1);
			if(s.equals("department")) 
				pst.setString(1,ndept);
			else if(s.equals("stafftype"))
				pst.setString(1, nsttype);
			else if(s.equals("shift"))
				pst.setInt(1, nshift);
			
			ResultSet rs=pst.executeQuery();
			rs.next();
			//System.out.println("value "+rs.getInt(1));
			System.out.println("value "+rs.getInt(1));
			
			
			if(rs.getInt(1)==0 )
			{
			PreparedStatement ps=con.prepareStatement(query);
		if(ps.executeUpdate()>0)
		{
			out.println("<script type='text/javascript'>alert(' data was inserted  '); window.location.href='staff.jsp'; </script>");
			//out.println("alert(' data was inserted ');");
			}
		else
			out.println("alert(' data was not inserted ');");
			}
			else
			{
				out.println("<script type='text/javascript'>alert(' data was already inserted  '); window.location.href='staff.jsp'; </script>");
				//out.println("alert(' data was duplicate');");				
			}
		
		}		
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println(" exception line  ");
		}
		System.out.println(" last line  ");
		

		doGet(request, response);
	}

}
