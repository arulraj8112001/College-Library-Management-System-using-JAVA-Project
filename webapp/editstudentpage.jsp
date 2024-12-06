<%@ page import="java.sql.*" %>
<%@ page import="kaniraj.Dbconnection" %>
<%@ page import="java.time.Year" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Details Form</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f8ff; /* Light blue background */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        form {
            background-color: #4caf50; /* Green background for the form */
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
            background-color: #ff9800; /* Orange button */
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }

        button:hover {
            background-color: #e68a00; /* Darker orange on hover */
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
        }
    </script>
</head>
<body>
    <form id="abc" action="adddatastudent.jsp" method="post">
        <label for="department">Department:</label>
        <%
        try {
            Connection con = Dbconnection.getConnection();
            String str = "select department from studentdetails where department!='empty'";
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

        <label for="degreetype">Degree Type:</label>
        <%
            Connection con2 = Dbconnection.getConnection();
            String str2 = "select degreetype from studentdetails where degreetype!='empty'";
            PreparedStatement ps2 = con2.prepareStatement(str2);
            ResultSet rs2 = ps2.executeQuery();
        %>
        <select id="degreetype" name="degreetype">
            <option value="">Select Degree Type</option>
            <% while(rs2.next()) { %>
            <option value="<%= rs2.getString("degreetype") %>"><%= rs2.getString("degreetype") %></option>
            <% } %>
        </select>
        <button type="submit" id="added" name="added" onclick="fun('degreetype')" value="degreetype">Add Degree Type</button>

        <br><br>

        <label for="shift">Year:</label>
        <%
            Connection con3 = Dbconnection.getConnection();
            String str3 = "select year from studentdetails where year != 0";
            PreparedStatement ps3 = con3.prepareStatement(str3);
            ResultSet rs3 = ps3.executeQuery();
            rs3.next();
            int start = rs3.getInt(1);
            int year = Year.now().getValue();
        %>
        <select id="shift" name="shift">
            <option value="">Select Starting Year</option>
            <% for(int i = year; i >= start; i--) { %>
            <option value="<%= i %>"><%= i %></option>
            <% } %>
        </select>
        <button type="submit" id="added" name="added" onclick="fun('shift')" value="shift">Add Starting Year</button>
        <%
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </form>
</body>
</html>
