<%@ page import="java.sql.*" %>
<%@ page import="kaniraj.Dbconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Staff Details Form</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f8ff;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        form {
            background-color: #4caf50;
            color: white;
            padding: 40px;
            border-radius: 15px;
            width: 400px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        label {
            font-size: 18px;
            font-weight: bold;
            display: block;
            margin-bottom: 10px;
        }

        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            border: none;
            font-size: 16px;
        }

        button {
            background-color: #ff9800;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }

        button:hover {
            background-color: #e68a00;
        }

        .button-container {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
    </style>

    <script type="text/javascript">
        function fun(str) {
            alert("Function calling: " + str);
/*  

 document.getElementById("added").value = str;
 var element = document.getElementById("added");
 element.name = str;
 window.location.href = "adddata.jsp";
 document.getElementById("abc").submit();

 
 */

        }
    </script>
</head>
<body>
<form id="abc" action="adddata.jsp" method="post">
    <label for="department">Department:</label>
    <%
    try {
        Connection con = Dbconnection.getConnection();
        String str = "select department from staffdetails where department!='empty'";
        PreparedStatement ps = con.prepareStatement(str);
        ResultSet rs = ps.executeQuery();
    %>
    <select id="department" name="department">
        <option value="">Select Department</option>
        <% while(rs.next()) { %>
        <option value="<%= rs.getString("department") %>"><%= rs.getString("department") %></option>
        <% } %>
    </select>
    <button type="submit" id="added" name="added" onclick="fun('department')" value="department">Add Department</button>

    <br><br>

<%--  
    <label for="stafftype">Staff Type:</label>
    <%
        Connection con2 = Dbconnection.getConnection();
        String str2 = "select stafftype from staffdetails where stafftype!='empty'";
        PreparedStatement ps2 = con2.prepareStatement(str2);
        ResultSet rs2 = ps2.executeQuery();
    %>
    
    <select id="stafftype" name="stafftype">
        <option value="">Select Staff Type</option>
        <% while(rs2.next()) { %>
        <option value="<%= rs2.getString("stafftype") %>"><%= rs2.getString("stafftype") %></option>
        <% } %>
    </select>
    <button type="submit" id="added" name="added" onclick="fun('stafftype')" value="stafftype">Add Staff Type</button>

    <br><br>
--%>

    <label for="shift">Shift:</label>
    <%
        Connection con3 = Dbconnection.getConnection();
        String str3 = "select shift from staffdetails where shift != 0";
        PreparedStatement ps3 = con3.prepareStatement(str3);
        ResultSet rs3 = ps3.executeQuery();
    %>
    <select id="shift" name="shift">
        <option value="">Select Shift</option>
        <% while(rs3.next()) { %>
        <option value="<%= rs3.getInt("shift") %>"><%= rs3.getInt("shift") %></option>
        <% } %>
    </select>
    <button type="submit" id="added" name="added" onclick="fun('shift')"  value="shift">Add Shift</button>
    <%
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>
</form>
</body>
</html>
