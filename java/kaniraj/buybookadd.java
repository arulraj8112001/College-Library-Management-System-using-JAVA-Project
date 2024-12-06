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
import java.time.LocalDate;

/**
 * Servlet implementation class buybookadd
 */
public class buybookadd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public buybookadd() {
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
	out.println("servlet file ");
	try
	{
        HttpSession aa2 = request.getSession(false);
        Integer i = (Integer) aa2.getAttribute("ssid");
        String ide = i + "";
//        out.println("buybookcol " + ide);

        int accessno = 0;
        if (ide != null && !ide.isEmpty()) 
            accessno = Integer.parseInt(ide);
    		System.out.println("accessed id "+accessno);

    		String bname=(String)aa2.getAttribute("bname");
    		System.out.println("accessed name "+bname);

	String type=(String)aa2.getAttribute("sort");
	System.out.println("type "+type);

	String sname=request.getParameter("sname");
	System.out.println("sname "+sname);
	long sregno=0l;
	if(type.equals("Student"))
		sregno=Long.parseLong(request.getParameter("sregno"));
	System.out.println("sregno "+sregno);
	long phoneno=Long.parseLong(request.getParameter("phoneno"));
	System.out.println("phone"+phoneno);
	String bdate=request.getParameter("borrowDate");
	LocalDate date=LocalDate.now();
	
	System.out.println("accessno "+accessno+"bname"+bname+"type"+type+"sname"+sname);
	System.out.println("sregno "+sregno+"phoneno"+phoneno+"bdate"+bdate);
	
	
		Connection con=Dbconnection.getConnection();
		String doo="";
		if(type.equals("Student"))
			doo="select count(*) from Student where name=? and phno=? and regno=?";
		else
			doo="select count(*) from Staff where name=? and contactno=?";
		PreparedStatement p=con.prepareStatement(doo);
		p.setString(1, sname);
		p.setLong(2, phoneno);
	if(type.equals("Student"))
		p.setLong(3,sregno);
	ResultSet rst=p.executeQuery();
	
	if(rst.next() && rst.getInt(1)==0)
		{
			out.println("<script type='text/javascript'> alert(' you are not student or staff you are not eligible for buy book ');  ");		
			out.println("window.location.href='SearchBook.jsp';</script>");
		}
		else
		{
			//out.println("<script type='text/javascript'> alert('you are already executed');</script> ");			

			String str="";
		if(type.equals("Student"))
			str="select count(*) from buybookdetails where accessno=? and type=? and sregno=? and phoneno=? and val=0";
		else
			str="select count(*) from buybookdetails where accessno=? and type=? and phoneno=? and val=0";
		PreparedStatement ps=con.prepareStatement(str);
		ps.setInt(1,accessno);
		ps.setString(2, type);
		if(type.equals("Student"))
		{
			ps.setLong(3, sregno);
			ps.setLong(4, phoneno);
		}
		else
			ps.setLong(3, phoneno);
		
		ResultSet rs=ps.executeQuery();
		rs.next();
		if(rs.getInt(1)==1)
		{
			out.println("<script type='text/javascript'> alert('you are already this book was taken'); window.location.href='SearchBook.jsp'; </script> ");
		}
		else
		{
		if(type.equals("Student"))
			str="Insert into buybookdetails(accessno,bookname,type,sname,phoneno,bdate,sregno) values(?,?,?,?,?,?,?)";		
		else
			str="Insert into buybookdetails(accessno,bookname,type,sname,phoneno,bdate) values(?,?,?,?,?,?)";
		
		PreparedStatement pst=con.prepareStatement(str);
		if(type.equals("Student")) {
		pst.setInt(1, accessno);
		pst.setString(2, bname);
		pst.setString(3, type);
		pst.setString(4, sname);
		pst.setLong(5, phoneno);
		pst.setString(6, date.toString());
		pst.setLong(7, sregno);
		}
		else
		{
			pst.setInt(1, accessno);
			pst.setString(2, bname);
			pst.setString(3, type);
			pst.setString(4, sname);
			pst.setLong(5, phoneno);
			pst.setString(6, bdate.toString());
		}
		if(pst.executeUpdate()>0)
		{
			PreparedStatement psn=null;
			String query="select available from bookinformation where accessno=?";
			 psn=con.prepareStatement(query);
			psn.setInt(1, accessno);
			ResultSet rsn=psn.executeQuery();
			rsn.next();
			int no=rsn.getInt(1);
			if(no==0)
			{
				out.println("<script type='text/javascript'>alert('Book was no stock'); window.location.href='sallbooks.jsp'; </script>");					
			}
			else
			{
			no--;
			query="update bookinformation set available=? where accessno=?";
			 psn=con.prepareStatement(query);
			psn.setInt(1, no);
			psn.setInt(2, accessno);
			if(psn.executeUpdate()>0)
			{
				if(type.equals("Student"))
					query="Update student set buy=(select COALESCE(SUM(buy), 0) from student where name=? and phno=? and regno=?)+1 where name=? and phno=? and regno=?";
				else
					query="Update staff set buy=(select COALESCE(SUM(buy), 0) from staff where name=? and contactno=?)+1 where name=? and contactno=?";
				
				
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
				st="UPDATE student SET buybookno = array_append(buybookno, ?) WHERE name=? and phno=? and regno=?";
			else
				st="UPDATE staff SET buybookno = array_append(buybookno, ?) WHERE name=? and contactno=?";
			
			PreparedStatement sp=con.prepareStatement(st);
			sp.setInt(1, accessno);
			sp.setString(2, sname);
			sp.setLong(3, phoneno);
			if(type.equals("Student"))
			{
				sp.setLong(4, sregno);
			}
			
			
			
			/*
			 * Preparedstatement
			 *    
			 * 
			 * 
			 * 
			 */
				if(psn.executeUpdate()>0 && sp.executeUpdate()>0 )
					out.println("<script type='text/javascript'>alert('Book was buyed'); window.location.href='SearchBook.jsp'; </script>");
				
			}
			}
		}
		else
		{
			out.println("<script type='text/javascript'>alert('Book was buyed some input errors'); window.location.href='SearchBook.jsp';</script>");	
		}
		
		}
}
	
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
		
		doGet(request, response);
	}

}
