<%@ page import="java.sql.*" %>
<%@ page import="kaniraj.Dbconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Information</title>
    <style type="text/css">
        /* General Body Styling */
        body {
            background-color: #f3e5f5; /* Light lavender background */
            font-family: Arial, sans-serif;
            color: #333;
        }

        /* Center the title */
        h1 {
            color: #6a1b9a; /* Dark purple for heading */
            font-size: 36px;
            text-align: center;
        }

        /* Fixed Buttons (Staff and Home) at the top-right corner */
        .fixed-buttons {
            position: absolute;
            top: 20px;
            right: 20px;
            display: flex;
            gap: 15px; /* Space between the buttons */
        }

        .btn {
            background-color: #ff9800; /* Bright orange button */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            display: flex;
            align-items: center;
        }

        .btn i {
            margin-right: 8px; /* Space between icon and text */
        }

        .btn:hover {
            background-color: #fb8c00; /* Darker orange on hover */
        }

        /* Table Styling */
        table {
            margin: 20px auto;
            width: 90%;
            border-collapse: collapse;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Light shadow */
        }

        th, td {
            padding: 15px;
            text-align: center;
            border: 2px solid #ce93d8; /* Soft purple border */
        }

        th {
            background-color: #8e24aa; /* Medium purple for headers */
            color: white;
            font-size: 20px;
        }

        td {
            font-size: 18px;
            background-color: #f3e5f5; /* Light lavender for table rows */
            transition: background-color 0.3s ease;
        }

        tr:nth-child(even) td {
            background-color: #e1bee7; /* Alternating purple row color */
        }

        tr:hover td {
            background-color: #ba68c8; /* Darker purple for hover effect */
        }

        /* Button Styling in Table */
        .action-button {
            background-color: #d50000; /* Vivid red for action buttons */
            color: white;
            border: none;
            padding: 8px 16px;
            font-size: 16px;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .action-button:hover {
            background-color: #b71c1c; /* Darker red on hover */
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            th, td {
                font-size: 16px;
            }

            h1 {
                font-size: 28px;
            }

            .btn {
                font-size: 14px;
                padding: 8px 16px;
            }
        }
    </style>

    <script>
        function Update(a) {
            alert("Given input is: " + a);
            window.location.href = "Update.jsp?id=" + a;
        }

        function Delete(rowId) {
            if (confirm("Are you sure you want to delete this record? " + rowId)) {
                window.location.href = "Delete.jsp?id=" + rowId;
            }
        }
        function check(val)
        {
        	if(val==0)
        		{
        		alert('this book is currently not available... ');
 				return false;
        		}
        	
        	return true;
        }
        
        
    </script>
</head>
<body>

    <div class="fixed-buttons">
<%-- 
        <button class="btn" onclick="window.location.href='staff.html'">
            <i class="fas fa-user-tie"></i> Staff
        </button>
    --%>    
        <button class="btn" onclick="window.location.href='home.jsp'">
            <i class="fas fa-home"></i> Home
        </button>
    </div>

    <h1>Library Book Details</h1>

    <%
    try {
        HttpSession hs = request.getSession(false);
        String col = (String) hs.getAttribute("col");
        String val = request.getParameter("value");
        System.out.println("col " + col + " val " + val);

        String str1 = "SELECT count(*) FROM bookinformation WHERE " + col + "=?";
        Connection con1 = Dbconnection.getConnection();
        PreparedStatement ps1 = con1.prepareStatement(str1);

        if (col.equals("accessno") || col.equals("id")) {
            ps1.setInt(1, Integer.parseInt(val));
        } else {
            ps1.setString(1, val);
        }
        
        ResultSet rs1 = ps1.executeQuery();
    	rs1.next();
        if(rs1.getInt(1)==0)
        {
        //	out.println("<script type='text/javascript'> alert(' No Books are available '); window.location.href='SearchBook.jsp'; </script> ");
        response.sendRedirect("SearchBook.jsp");
        }
        else
        {
        
        
        
        
        
        String str = "SELECT * FROM bookinformation WHERE " + col + "=?";
        Connection con = Dbconnection.getConnection();
        PreparedStatement ps = con.prepareStatement(str);

        if (col.equals("accessno") || col.equals("id")) {
            ps.setInt(1, Integer.parseInt(val));
        } else {
            ps.setString(1, val);
        }
        
        ResultSet rs = ps.executeQuery();
    
    %>

    <table border="2">
        <tr>
            <th>ID</th>
            <th>Access No</th>
            <th>Book Name</th>
            <th>Author Name</th>
            <th>Edition</th>
            <th>Publisher</th>
            <th>Date</th>
            <th>No. of Books</th>
            <th>Available Books</th>
            <th>Buy Book</th>
        </tr>

        <% while (rs.next()) { %>
        <tr>
            <td><%= rs.getInt(8) %></td>
            <td><%= rs.getInt(1) %></td>
            <td><%= rs.getString(2) %></td>
            <td><%= rs.getString(3) %></td>
            <td><%= rs.getString(4) %></td>
            <td><%= rs.getString(5) %></td>
            <td><%= rs.getString(6) %></td>
            <td><%= rs.getInt(7) %></td>
            <td><%= rs.getInt(9) %></td>
            <td>
            <%
            int no=rs.getInt(9);
            int n = rs.getInt(1);
            HttpSession sess = request.getSession();
            sess.setAttribute("ssid", n);
		%>
                <form action="buybook.jsp" method="post" onsubmit="return check(<%= no %>);">
                    <input type="hidden" name="id" value="<%= rs.getInt(1) %>">
                    <button class="action-button" type="submit" >Buy a Book</button>
                </form>
                
            </td>
        </tr>
        <% } %>
    </table>

    <%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>
    
    <!-- Font Awesome CDN for icons -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
</body>
</html>










<%-- 
<%@ page import="java.sql.*"  %>
<%@ page import="kaniraj.Dbconnection" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
try
{
	HttpSession hs=request.getSession(false);
	String col=(String)hs.getAttribute("col");
	String val=request.getParameter("value");
	System.out.println("col "+col+" val "+val);
	//String str="Select * from bookinformation where "+ col +"=?";

	String str="Select * from bookinformation where "+ col +"=?";
	Connection con=Dbconnection.getConnection();
	PreparedStatement ps=con.prepareStatement(str);
//	ps.setString(1,col);
	if(col.equals("accessno") || col.equals("id"))
	{
		ps.setInt(1,Integer.parseInt(val));
		}
	else
	{
		ps.setString(1,val);
		
	}
		ResultSet rs=ps.executeQuery();
		



%>
 <table border="2">
        <tr>
            <th>ID</th>
            <th>Accessno</th>
            <th>Book-name</th>
            <th>Author-name</th>
            <th>Edition</th>
            <th>Publisher</th>
            <th>Date</th>
            <th>NoofBooks</th>
            <th>Buy books</th>
        </tr>

<%	
/* 	if(!rs.next())
	{
		out.println("<script type='text/javascript'>");
		out.println("alert(' no books in library '); ");
		out.println("</script>");
	}
	else
	{

 */
 while(rs.next())
	{
%>
	 <tr>
            <td><%= rs.getInt(8) %></td>
            <td><%= rs.getInt(1) %></td>
            <td><%= rs.getString(2) %></td>
            <td><%= rs.getString(3) %></td>
            <td><%= rs.getString(4) %></td>
            <td><%= rs.getString(5) %></td>
            <td><%= rs.getString(6) %></td>              
            <td><%= rs.getInt(7) %></td>   	
			<form action="buybook.jsp" method="post">
 			<td>
 				<input type="hidden" name="id" value="<%= rs.getInt(1) %>">
       			
       			<% 
       			int n=rs.getInt(1);
       	System.out.println("parsevalue "+n);
       			HttpSession aa2=request.getSession();
					aa2.setAttribute("ssid",n);
					

				%>
       			<button type="submit">Buy a Book</button>
--%>
<%--               <button type="submit" name="action"  value="update">Update</button> --%>
<%-- 					
         			</td>
			</form>
     </tr>
<% 	}	%>
</table>
<%
}
catch(Exception e)
{
	e.printStackTrace();
}

%>


</body>
</html>

--%>