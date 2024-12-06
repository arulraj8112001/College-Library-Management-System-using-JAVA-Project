<%@ include file="Authentication.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="kaniraj.Dbconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--

 project=# ALTER SEQUENCE student_id_seq RESTART WITH 13;
ALTER SEQUENCE

 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Staff Delete page</title>
</head>
<body>
<%
try
{
	//int id=Integer.parseInt(request.getAttribute("id"));
//	String sid=(String)request.getAttribute("id");

HttpSession hs=request.getSession(false);
String sid=(String)hs.getAttribute("sid");

	
//	RequestDispatcher dispatcher = request.getRequestDispatcher("updatestaff");
//   dispatcher.forward(request, response);
    if (sid != null && !sid.trim().isEmpty()) {

    	int id=Integer.parseInt(sid);
	out.println(" id "+id);
//	id--;
	Connection con=Dbconnection.getConnection();
	//String str= "DELETE FROM STAFF WHERE id IN (SELECT id FROM STAFF OFFSET "+ id +" LIMIT 1)";
	String str="UPDATE STAFF SET delete = ? WHERE id = ?";
	PreparedStatement ps=con.prepareStatement(str);
	ps.setInt(1,1);
	ps.setInt(2,id);
	
	if(ps.executeUpdate()>0)
	{
		out.println(" alert(' data was deleted '); ");
		response.sendRedirect("allstaff.jsp");
	}
	else
	{
		out.println(" alert('sorry not delete the data '); ");
	}

	ps.close();
	con.close();
	
    }else {
        out.println("ID is missing. Please provide a valid ID.");
    }
	
}
catch(Exception e)
{
	e.printStackTrace();
}
%>




</body>
</html>