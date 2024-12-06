package kaniraj;

import jakarta.servlet.RequestDispatcher;
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
import java.sql.SQLException;

/**
 * Servlet implementation class Staff
 */

@WebServlet("/staff")
public class Staff extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Staff() {
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
		
		String name=request.getParameter("name");
		String coursetype=request.getParameter("courseType");		
		//String staffType=request.getParameter("staffType");
		int shift=Integer.parseInt(request.getParameter("shift"));
		long contactNo=Long.parseLong(request.getParameter("contactNo"));
				String rr=Long.toString(contactNo);
//				boolean ab=true;
				if(rr.length()!=10)
				{
	//				ab=false;
					RequestDispatcher rd=request.getRequestDispatcher("staff.html");
					rd.include(request, response);
				}
//				else
//					ab=true;
//			
				try {
			Connection con=Dbconnection.getConnection();
			boolean b=true;

			
			String str="select count(*) from staff where name=? and contactno=?";
			PreparedStatement pst=con.prepareStatement(str);
			pst.setString(1, name);
			pst.setLong(2, contactNo);
			ResultSet rs=pst.executeQuery();
			rs.next();
			System.out.println(" 1st row "+rs.getInt(1));
			if(rs.getInt(1)>0)
			{
				b=false;
				out.println("<script type='text/javascript'> ");
				out.println(" alert('This staff details already added'); ");
				out.println("window.location.href='staff.html'; ");
				out.println(" </script> ");
				out.println();	
			}
			
			
			
			/*
			PreparedStatement pst=con.prepareStatement("SELECT * FROM staff");
			ResultSet rs=pst.executeQuery();
			boolean b=true;
			
			while(rs.next())
			{
				//if(rs.getString(2).equals(name) && rs.getString(3).equals(coursetype) && rs.getString(4).equals(staffType) && rs.getInt(5)==shift && rs.getLong(6)==contactNo )
				
				if(rs.getString(2).equals(name) && rs.getString(3).equals(coursetype) && rs.getInt(5)==shift && rs.getLong(6)==contactNo )
				{
					b=false;
					out.println("<script type='text/javascript'> ");
					out.println(" alert('This staff details already added'); ");
					out.println("window.location.href='staff.html'; ");
					out.println(" </script> ");
					out.println();
				}
			}
			*/
			
			if(b)
			{		
//			PreparedStatement ps=con.prepareStatement("INSERT INTO staff(name,department,staffType,shift,contactNo) values(?,?,?,?,?)");
			
			PreparedStatement ps=con.prepareStatement("INSERT INTO staff(name,department,shift,contactNo) values(?,?,?,?)");
			
			ps.setString(1, name);
		ps.setString(2, coursetype);
//		ps.setString(3, staffType);
		ps.setInt(3, shift);
		ps.setLong(4, contactNo);
		
		if( ps.executeUpdate()>0)
		{
			out.println("<script type='text/javascript'>");
			out.println(" alert(' New staff details added... '); ");
			out.println("window.location.href='staff.html'; ");
//			out.println("window.location.href=window.location.href;");
			out.println("</script> ");
		}
		else
		{
			out.println("<script type='text/javascript'>");
			out.println(" alert('staff details not added  insert problem'); ");
			out.println("window.location.href='staff.html'; ");
			out.println("</script> ");
		}
		
		
		}
			
//			else
//			{
//				out.println("<script type='text/javascript'>");
//				out.println(" alert('staff details not added  insert problem'); ");
//				out.println("window.location.href='staff.html'; ");
//				out.println("</script> ");
//					
//			}
//			

			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		
		doGet(request, response);
	}

}



