package kaniraj;

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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

/**
 * Servlet implementation class returnbookadd
 */
public class returnbookadd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public returnbookadd() {
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
		try {
			
			/*
			 * int accessno=Integer.parseInt(request.getParameter("accessno")); String
			 * type=request.getParameter("sort"); String
			 * sname=request.getParameter("sname"); // System.out.println("sname "+sname);
			 * long sregno=0l; if(type.equals("Student"))
			 * sregno=Long.parseLong(request.getParameter("sregno")); //
			 * System.out.println("sregno "+sregno); long
			 * phoneno=Long.parseLong(request.getParameter("phoneno")); //
			 * System.out.println("phone"+phoneno);
			 * 
			 * String rdate=request.getParameter("ReturnDate");
			 */
			
			
			int accessno=Integer.parseInt(request.getParameter("accessno"));
			System.out.println("accessno "+accessno);
//			String type=request.getParameter("sort");
//			System.out.println("stype "+type);
//	       
			HttpSession aa2 = request.getSession(false);
			String type=(String)aa2.getAttribute("sort"); // request.getParameter("sname");
			System.out.println("sname "+type);
			
			String sname=request.getParameter("sname");
			System.out.println("sname "+sname);
			
			long sregno=0l;
			if(type.equals("Student"))
				sregno=Long.parseLong(request.getParameter("sregno"));
			System.out.println("sregno "+sregno);
			long phoneno=Long.parseLong(request.getParameter("phoneno"));
			System.out.println("phoneno "+phoneno);
			LocalDate date=LocalDate.now();

			String query="";
			if(type.equals("Student"))
				query="select count(*) from buybookdetails where accessno=? and type=? and phoneno=? and val=? and sregno=?";
			else
				query="select count(*) from buybookdetails where accessno=? and type=? and phoneno=? and val=?";
				
			Connection con=Dbconnection.getConnection();
			PreparedStatement ps=con.prepareStatement(query);
			ps.setInt(1, accessno);
			ps.setString(2, type);
			ps.setLong(3, phoneno);
			ps.setInt(4, 0);
			if(type.equals("Student"))
				ps.setLong(5, sregno);
			ResultSet rs=ps.executeQuery();
			
			if(rs.next() && rs.getInt(1)==1)
			{
				if(type.equals("Student"))
					query="update buybookdetails set rdate=?,val=? where accessno=? and type=? and phoneno=? and sregno=? and rdate='NoReturn'";
				else
					query="update buybookdetails set rdate=?,val=? where accessno=? and type=? and phoneno=? and rdate='NoReturn'";
				ps=con.prepareStatement(query);
				ps.setString(1, date.toString());
				ps.setInt(2, 1);
				ps.setInt(3, accessno);
				ps.setString(4, type);
				ps.setLong(5, phoneno);
				if(type.equals("Student"))
					ps.setLong(6, sregno);
				if(ps.executeUpdate()>0)
				{
					//
					
					PreparedStatement psn=null;
					 query="select available from bookinformation where accessno=?";
					 psn=con.prepareStatement(query);
					psn.setInt(1, accessno);
					ResultSet rsn=psn.executeQuery();
					rsn.next();
					int no=rsn.getInt(1);
/*					if(no==0)
					{
						out.println("<script type='text/javascript'>alert('Book was no stock'); window.location.href='sallbooks.jsp'; </script>");					
					}
					else
					{
					*/
					no++;
					query="update bookinformation set available=? where accessno=?";
					 psn=con.prepareStatement(query);
					psn.setInt(1, no);
					psn.setInt(2, accessno);
					if(psn.executeUpdate()>0)
					{
						if(type.equals("Student"))
							query="Update student set buy=(select COALESCE(SUM(buy), 0) from student where name=? and phno=? and regno=?)-1 where name=? and phno=? and regno=?";
						else
							query="Update staff set buy=(select COALESCE(SUM(buy), 0) from staff where name=? and contactno=?)-1 where name=? and contactno=?";
						
						
						psn=con.prepareStatement(query);
						psn.setString(1, sname);
						psn.setLong(2, phoneno);
						if(type.equals("Student"))
						{
							psn.setLong(3, sregno);
							psn.setString(4,sname);
							psn.setLong(5, phoneno);
							psn.setLong(6, sregno);
						}
						else	
						{
							psn.setString(3, sname);
							psn.setLong(4, phoneno);
						}
						
						String st="";
					if(type.equals("Student"))
						st="UPDATE student SET buybookno = array_remove(buybookno, ?) WHERE name=? and phno=? and regno=?";
					else
						st="UPDATE staff SET buybookno = array_remove(buybookno, ?) WHERE name=? and contactno=?";
					
					PreparedStatement sp=con.prepareStatement(st);
					sp.setInt(1, accessno);
					sp.setString(2, sname);
					sp.setLong(3, phoneno);
					if(type.equals("Student"))
					{
						sp.setLong(4, sregno);
					}
					
						if(psn.executeUpdate()>0 && sp.executeUpdate()>0 )
							out.println("<script type='text/javascript'>alert('you are book was returned..'); window.location.href='home.html';</script>");
						else
							out.println("<script type='text/javascript'>alert('you are book was already returned..'); window.location.href='home.html';</script>");
							
					}	
							//out.println("<script type='text/javascript'>alert('Book was buyed'); window.location.href='SearchBook.jsp'; </script>");
//						
//					}
					

					
					//
					
				}
				out.println("<script type='text/javascript'>alert('invalid details  '); window.location.href='home.html'; </script>");
				
				
				
				
			}
			else
			{
				out.println("<script type='text/javascript'>alert(' you are already returned this book'); window.location.href='returnbook.jsp';</script>");
			}
			
		
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		
		doGet(request, response);
	}

}
