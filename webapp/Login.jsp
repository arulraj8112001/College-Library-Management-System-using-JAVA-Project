<%@ page import="java.sql.*" %>
<%@ page import="kaniraj.Dbconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, jakarta.servlet.*, jakarta.servlet.http.*" %>

<%
String uname = request.getParameter("name");
String password = request.getParameter("pass");
String error = null;

if (uname != null && password != null) {
    try {
        Connection con = Dbconnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT name, password FROM login WHERE name = ?");
        ps.setString(1, uname);
        ResultSet rs = ps.executeQuery();
        
        // Check if a user with the given username exists
        if (rs.next()) {
            String dbPassword = rs.getString("password");
            // Check if the password matches
            if (password.equals(dbPassword)) {
                HttpSession sesion = request.getSession();
                sesion.setAttribute("username", uname);
                response.sendRedirect("home.jsp"); // Redirect to home.jsp or any other protected page
            } else {
                error = "Incorrect username or password";
            }
        } else {
            error = "Incorrect username or password";
        }
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        error = "An error occurred. Please try again.";
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f0f5;
            margin: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h1 {
            margin-bottom: 30px;
            color: #4e73df;
            font-size: 32px;
        }

        form {
            background-color: #4e73df;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            width: 350px;
        }

        h2 {
            text-align: center;
            color: #fff;
            font-size: 24px;
            margin-bottom: 25px;
            letter-spacing: 1px;
        }

        label {
            color: #fff;
            font-size: 14px;
            margin-bottom: 8px;
            display: block;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: none;
            border-radius: 6px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        input[type="submit"], input[type="reset"] {
            width: 48%;
            padding: 12px;
            margin-top: 15px;
            border: none;
            border-radius: 6px;
            background-color: #1cc88a;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover, input[type="reset"]:hover {
            background-color: #17a673;
        }

        .button-container {
            display: flex;
            justify-content: space-between;
        }

        .error-message {
            color: #e74a3b;
            font-size: 30px;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>COLLEGE LIBRARY MANAGEMENT SYSTEM</h1>

    <form method="post">
        <h2>Login Form</h2>
        <label for="username">Username:</label>
        <input type="text" id="username" name="name" maxlength="8" required>

        <label for="password">Password:</label>
        <input type="password" id="password" name="pass" maxlength="3" required>

        <div class="button-container">
            <input type="submit" value="Submit">
            <input type="reset" value="Reset" onclick="window.location.href='Login.jsp'">
        </div>

        <% if (error != null) { %>
            <b><p class="error-message"><%= error %></p></b>
        <% } %>
    </form>
</div>

</body>
</html>
























<%--
<%@ page import="java.sql.*" %>
<%@ page import="kaniraj.Dbconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, jakarta.servlet.*, jakarta.servlet.http.*" %>

<%
String uname = request.getParameter("name");
String password = request.getParameter("pass");
String error = null;

if (uname != null && password != null) {
    try {
        Connection con = Dbconnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT name, password FROM login WHERE name = ?");
        ps.setString(1, uname);
        ResultSet rs = ps.executeQuery();
        
        // Check if a user with the given username exists
        if (rs.next()) {
            String dbPassword = rs.getString("password");
            // Check if the password matches
            if (password.equals(dbPassword)) {
                HttpSession sesion = request.getSession();
                sesion.setAttribute("username", uname);
                response.sendRedirect("home.jsp"); // Redirect to home.jsp or any other protected page
            } else {
                error = "Incorrect username or password";
            }
        } else {
            error = "Incorrect username or password";
        }
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        error = "An error occurred. Please try again.";
    }
}
%>


<%--
String uname = request.getParameter("name");
String password = request.getParameter("pass");
String error = null;

if (uname != null && password != null) {
	try
	{
	Connection con=Dbconnection.getConnection();
	PreparedStatement ps=con.prepareStatement("select * from login");
    ResultSet rs=ps.executeQuery();
    rs.next();
	if (uname.equals(rs.getString(1)) && password.equals(rs.getString(2))) {
        response.sendRedirect("home.html"); //admin
    } else {
        error = "Incorrect username or password";
    }
	}catch(Exception e)
	{
		e.printStackTrace();
	}
}
--%>




 <!--  
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f0f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        form {
            background-color: #4e73df;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            width: 350px;
        }

        h2 {
            text-align: center;
            color: #fff;
            font-size: 24px;
            margin-bottom: 25px;
            letter-spacing: 1px;
        }

        label {
            color: #fff;
            font-size: 14px;
            margin-bottom: 8px;
            display: block;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: none;
            border-radius: 6px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        input[type="submit"], input[type="reset"] {
            width: 48%;
            padding: 12px;
            margin-top: 15px;
            border: none;
            border-radius: 6px;
            background-color: #1cc88a;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover, input[type="reset"]:hover {
            background-color: #17a673;
        }

        .button-container {
            display: flex;
            justify-content: space-between;
        }

        .error-message {
            color: #e74a3b;
            font-size: 30px;
            text-align: center;
            margin-top: 10px;
        }
    </style>
<script>


</script>
</head>
<body>
<h1> COLLEGE LIBRARY MANAGEMENT SYSTEM </h1>

<form method="post">
    <h2>Login Form</h2>
    <label for="username">Username:</label>
    <input type="text" id="username" name="name" maxlength="8" required>

    <label for="password">Password:</label>
    <input type="password" id="password" name="pass" maxlength="3" required>

    <div class="button-container">
        <input type="submit" value="Submit">
        <input type="reset" value="Reset" onclick="window.location.href='Login.jsp'">
    </div>
-->
<%--     <% if (error != null) { %>
        <b><p class="error-message"><%= error %></p></b>
    <% } %>

 --%>
</form>

</body>
</html>
