<%@ page import="java.sql.*" %>
<%@ page import="kaniraj.Dbconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Book</title>
    <style>
        body {
            font-family: 'Trebuchet MS', sans-serif;
            background: linear-gradient(to right, #f8b500, #fceabb);
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
            padding: 30px;
            width: 350px;
        }
        h2 {
            text-align: center;
            color: #4b0082;
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
            color: #4b0082;
        }
        select, input[type="text"], input[type="number"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin: 12px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        select {
            background-color: #f8f8f8;
        }
        input[type="submit"] {
            background-color: #4b0082;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #6a0dad;
        }
        
         /* Home Button Styling */
        .fixed-buttons {
            position: absolute;
            top: 20px;
            right: 20px;
        }

        .btn {
            background-color: #ff7043;
            color: #ffffff;
            padding: 12px 20px;
            font-size: 16px;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn:hover {
            background-color: #e64a19;
            transform: translateY(-3px);
        }
        
    </style>
</head>
<body>
<!--         <button class="btn" onclick="window.location.href='viewallbooks.'">
            <i class="fas fa-book"></i> view books Book
        </button>
 -->
    <div class="fixed-buttons">
        <button class="btn" onclick="window.location.href='home.jsp'">
        <i class="fas fa-home"></i> HOME
        </button>


    </div>

    <div class="container">
        <h2>Search for a Book</h2>
        <form action="SearchBook.jsp" method="post">
            <%
                Connection con = Dbconnection.getConnection();
                PreparedStatement ps = con.prepareStatement("select bcolumn from book");
                ResultSet rs = ps.executeQuery();
                String selectedColumn = request.getParameter("val");
                %>
            <label for="column">Select Column:</label>
            <select name="val" onchange="this.form.submit()">
                <option value=""></option>
                <% 
                while (rs.next()) {
                	String column = rs.getString("bcolumn");
                %>
<%--               <option value="<%= rs.getString("bcolumn") %>"><%= rs.getString("bcolumn") %></option>  --%>
                    <option value="<%= column %>" <%= (column.equals(selectedColumn)) ? "selected" : "" %>><%= column %></option>

                <% } %>
            </select>
        </form>

        <form action="sallbooks.jsp" method="post">
            <%
                String col = request.getParameter("val");
                HttpSession hs = request.getSession();
                hs.setAttribute("col", col);

                if (request.getParameter("val") != null) {
            %>
            <label for="value">Search <%= col %>:</label>
            <% 
                if (col.equals("accessno") || col.equals("id")) {
            %>
                    <input type="number" name="value">
            <% 
                } else {
            %>
                    <input type="text" name="value">
            <% 
                }
            %>
            <input type="submit" value="Submit" name="sub">
            <% } %>
        </form>
    </div>
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
<title>Insert title here</title>
</head>
<body>
<form action="" method="post">
<%
try
{
Connection con=Dbconnection.getConnection();
PreparedStatement ps=con.prepareStatement("select bcolumn from book");
ResultSet rs=ps.executeQuery();
%>SELECT COLUMN : 
<select name="val"  onchange="this.form.submit()">
<option value=""></option>
<% 
while(rs.next())
{
%>
<option value="<%= rs.getString("bcolumn") %>"><%= rs.getString("bcolumn")  %></option>
<% }%>
</select>
<%
}catch(Exception e)
{
	e.printStackTrace();
}
%>
</form>


<form action="sallbooks.jsp" method="post" onchange="this.form.submit()">
--%>
 <%-- sallbooks.jsp  --%>
<%-- 
<%
//try
//{
String col=request.getParameter("val");
HttpSession hs=request.getSession();
hs.setAttribute("col",col);

if(request.getParameter("val")!=null)
{
%>
SEARCH <%= col %> : 
<% 
if(col.equals("accessno") || col.equals("id"))
{
	%>
<input type="number" name="value">
<% 
}
else
{
	%>
<input type="text" name="value"> 
<% 	
}

/*
}
catch(Exception e)
{
	e.printStackTrace();
}
*/
%>

<input type="submit" value="Submit">
<% } %>
</form>
--%>
<%--

String name=request.getParameter("sub");
if(name.equals("Submit"))
{	
	System.out.println("kkkkkkkk");
}

--%>

<%-- 
</body>
</html>

--%>