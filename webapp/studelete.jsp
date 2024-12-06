<%@ page import="java.sql.*" %>
<%@ page import="kaniraj.Dbconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Delete page</title>
</head>
<body>
<%
try
{
	//int id=Integer.parseInt(request.getAttribute("id"));
	//String sid=(String)request.getAttribute("id");
HttpSession hs=request.getSession(false);
String sid=(String)hs.getAttribute("sid");

	
//	RequestDispatcher dispatcher = request.getRequestDispatcher("updatestaff");
//   dispatcher.forward(request, response);
    
	int id=Integer.parseInt(sid);
	System.out.println(" del id "+id);
//	id--;
	Connection con=Dbconnection.getConnection();
	//String str= "DELETE FROM STAFF WHERE id IN (SELECT id FROM STAFF OFFSET "+ id +" LIMIT 1)";
	String str="UPDATE student SET delete = ? WHERE id = ?";
	PreparedStatement ps=con.prepareStatement(str);
	ps.setInt(1,1);
	ps.setInt(2,id);
	
	if(ps.executeUpdate()>0)
	{
	//	out.println(" alert(' data was deleted '); ");
					out.println("<script type='text/javascript'>");
					out.println(" alert(' data was deleted '); ");
					//out.println("window.location.href('viewStudents.jsp');");
				out.println("</script>");
		response.sendRedirect("viewStudents.jsp");
	
	}
	else
	{
		out.println(" alert('sorry not delete the data '); ");
	}
	
	
	

}
catch(Exception e)
{
	e.printStackTrace();
}

%>

</body>
</html>













<%-- 
<%@ page import="java.sql.*" %>
<%@ page import="kaniraj.Dbconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Data Delete page</title>
</head>
<body>

<% 
//int row=Integer.parseInt(request.getParameter("n"));
try
{
	int row=Integer.parseInt(request.getParameter("id"));
	out.println(" Answer "+row);
	row--;
	out.println(" Answer "+row);

	Connection con=Dbconnection.getConnection();
	String str="DELETE FROM student WHERE id IN(SELECT id from student OFFSET "+ row +" LIMIT 1)";
	PreparedStatement ps=con.prepareStatement(str);
	if(ps.executeUpdate()>0)
	{
		out.println(" alert('row was deleted ');");
		response.sendRedirect("viewStudents.jsp");
	}
	else
		out.println(" alert('row was not deleted');");
}
catch(Exception e)
{
	e.printStackTrace();
}
%>


</body>
</html>
--%>