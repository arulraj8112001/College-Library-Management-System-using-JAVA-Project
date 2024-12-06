package kaniraj;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException; 

/**
 * Servlet implementation class Bookinformation
 */
public class Bookinformation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Bookinformation() {
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
		
		int accessno=Integer.parseInt(request.getParameter("accessno"));
		String bookname=request.getParameter("bookname");
		String authorname=request.getParameter("authorname");
		String edition=request.getParameter("edition");
		String publisher=request.getParameter("publisher");
		String date=request.getParameter("date");
		int noofbooks=Integer.parseInt(request.getParameter("noofbooks"));
		boolean b=true;
		try {
		Connection con=Dbconnection.getConnection();
		String s="select count(*) from bookinformation where accessno=? and bookname=? and authorname=? and edition=? and publisher=?";
		PreparedStatement pst=con.prepareStatement(s);
		pst.setInt(1, accessno);
		pst.setString(2, bookname);
		pst.setString(3, authorname);
		pst.setString(4, edition);
		pst.setString(5, publisher);
		ResultSet rs=pst.executeQuery();
		rs.next();
		if(rs.getInt(1)>0)
		{
			out.println("<script type='text/javascript'>");
			out.println("alert(' This book already stored in the Library ');");
			out.println("window.location.href='index.html';");
			out.println("</script>");
			b=false;
		}
		/*
		while(rs.next())
		{
			if(accessno==rs.getInt(1) && bookname.equals(rs.getString(2)) && authorname.equals(rs.getString(3)) && edition.equals(rs.getString(4)) && publisher.equals(rs.getString(5)) && date.equals(rs.getString(6)) )
			{
			out.println("<script type='text/javascript'>");
			out.println("alert(' You already booked ');");
			out.println("window.location.href='index.html';");
			out.println("</script>");

			b=false;
			break;		
			}
			
		}
		
		*/
		
		if(b)
		{
		String query="Insert into bookinformation(accessno,bookname,authorname,edition,publisher,date,noofbooks,available) values(?,?,?,?,?,?,?,?)";
		PreparedStatement ps=con.prepareStatement(query);
		ps.setInt(1, accessno);
		ps.setString(2,bookname);
		ps.setString(3, authorname);
		ps.setString(4, edition);
		ps.setString(5, publisher);
		ps.setDate(6, java.sql.Date.valueOf(date));
		ps.setInt(7, noofbooks);
		ps.setInt(8, noofbooks);
		if(ps.executeUpdate()>0)
		{
			out.println("<h1> data inserted successfully.... ");
			out.println("<script type='text/javascript'>");
			out.println("alert(' New book Added successfully... ');");
			out.println("window.location.href='index.html';");
			out.println("</script>");		
		}
		else
		{
			out.println("<h1> data not inserted.... ");
			out.println("<script type='text/javascript'>");
			out.println("alert(' New book are not Added... ');");
			out.println("window.location.href='index.html';");
			out.println("</script>");		
		}
		
		}	
		
		
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		doGet(request, response);
	}

}
