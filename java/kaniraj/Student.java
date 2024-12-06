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
 * Servlet implementation class Student
 */

@WebServlet("/student")
public class Student extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Student() {
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
		String batch=request.getParameter("batch_type");
		String dept=request.getParameter("dept");
		int year=Integer.parseInt(request.getParameter("year"));		
		long regno=Long.parseLong(request.getParameter("regno"));
		long contactno=Long.parseLong(request.getParameter("contactno"));
		String address=request.getParameter("address");
boolean b=true;		
		
		try {
			Connection con=Dbconnection.getConnection();
//			String str="select count(*) from student where regno=? and phno=?";
			String str="select count(*) from student where regno=?";
			PreparedStatement pst=con.prepareStatement(str);
			pst.setLong(1, regno);
			//pst.setLong(2, contactno);
			ResultSet rs=pst.executeQuery();
			rs.next();
			System.out.println("rs 0 value  "+rs.getInt(1));
			if(rs.getInt(1)>0)
			{
				out.println("<script type='text/javascript'>");
				out.println("alert(' You already booked ');");
				out.println("window.location.href='student.jsp';");
				out.println("</script>");
//				out.println("response.sendRedirect('student.jsp');");
//RequestDispatcher rd=request.getRequestDispatcher("student.jsp");
//rd.include(request, response);
				b=false;
//				break;		

			}
			
			/*
			PreparedStatement pst=con.prepareStatement("select * from student");
			ResultSet rs=pst.executeQuery();
			
			while(rs.next())
			{
				System.out.println("1 "+rs.getInt(1));
				System.out.println("2 "+rs.getString(2));
				System.out.println("3 "+rs.getString(3));
				System.out.println("4 "+rs.getInt(4));
				System.out.println("5 "+rs.getLong(5));
				System.out.println("6 "+rs.getLong(6));
				System.out.println("7 "+rs.getString(7));
				
				
				
				
if(name.equals(rs.getString(2)) && batch.equals(rs.getString(3)) && year==rs.getInt(4) &&  regno==rs.getLong(5) && contactno==rs.getLong(6) && address.equals(rs.getString(7)) )
{
	out.println("<script type='text/javascript'>");
	out.println("alert(' You already booked ');");
//	out.println("window.location.href='student.jsp';");
	out.println("</script>");

	b=false;
	break;		

}

			}
			
			*/
			
			if(b)
			{
			PreparedStatement ps=con.prepareStatement("INSERT INTO student(name,Degreetype,joiningyear,regno,phno,address,department,delete,buy) values(?,?,?,?,?,?,?,?,?)");
		ps.setString(1, name);
		ps.setString(2, batch);
		ps.setInt(3, year);
		ps.setLong(4, regno);
		ps.setLong(5, contactno);
		ps.setString(6, address);
		ps.setString(7, dept);
		ps.setInt(8, 0);
		ps.setInt(9, 0);		
		if(ps.executeUpdate()>0)
		{
		//	out.println("<h1> data inserted successfully.... ");
			out.println("<script type='text/javascript'>");
			out.println("alert(' New Student Added successfully... ');");
			out.println("window.location.href='student.jsp';");
			out.println("</script>");		
		//response.sendRedirect("student.jsp");
		}
		else
		{
			out.println("<h1> data not inserted.... ");
			out.println("<script type='text/javascript'>");
			out.println("alert(' You are not booked... ');");
			//out.println("window.location.href='student.jsp';");
			out.println("</script>");		
		}
		
		
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		doGet(request, response);
	}

}
