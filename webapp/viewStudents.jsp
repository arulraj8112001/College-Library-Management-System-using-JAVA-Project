<%@ page import="java.sql.*" %>
<%@ page import="kaniraj.Dbconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> ViewStudents </title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<!--  
    <link rel="stylesheet" type="text/css" href="style.css">
-->
    <style>
        /* General styling for the layout */
        body {
            background-color: RGB(231, 249, 249);
            font-family: Arial, sans-serif;
        }

        .header-section {
            display: flex;
            justify-content: space-between; /* Space between items */
            align-items: center; /* Center vertically */
            margin: 20px 150px; /* Margin for overall spacing */
        }

        .header-section h1 {
            margin-left: 200px ;
            font-size: 36px;
            color: #6a1b9a;
        }

        .header-buttons {
            display: flex;
            gap: 20px; /* Space between buttons */
        }

        .header-buttons button {
            padding: 12px 20px;
            background-color: #ff9800;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
        }

        .header-buttons button:hover {
            background-color: #fb8c00;
        }

        .home-btn i {
            margin-right: 8px;
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
            background-color: #8e24aa;
            color: white;
            font-size: 20px;
        }

        td {
            font-size: 18px;
            background-color: #f3e5f5;
        }

        tr:nth-child(even) td {
            background-color: #e1bee7;
        }

        tr:hover td {
            background-color: #ba68c8;
        }

    </style>

    <script>
        function call(id) {
            alert("Value is " + id);
            if (confirm("Are you sure you want to delete row " + id)) {
                location.assign("studelete.jsp?id=" + id);
            } else {
                alert("Working else block");
            }
        }
    </script>
</head>
<body>

<!-- Header Section with Title and Buttons -->
<div class="header-section">
    <h1>STUDENT LIST</h1>
    <div class="header-buttons">
        <button class="home-btn" onclick="window.location.href='student.jsp';">
        <i class="fas fa-user-graduate"></i>Add Student
        </button>
        <button class="home-btn" onclick="window.location.href='home.jsp'">
            <i class="fas fa-home"></i> Home
        </button>
    </div>
</div>

<%
int id = 0;
try {
    Connection con = Dbconnection.getConnection();
    PreparedStatement pst = con.prepareStatement(" SELECT * FROM student where delete!=1 ORDER BY id ");
    ResultSet rs = pst.executeQuery();
%>
<table border="2">
    <tr><th>Student-id</th><th>Name</th><th>Degreetype</th><th>Department</th><th>Joining-year</th><th>Reg-No</th><th>Phone No</th><th>Address</th><th>Edit</th><th>Edit</th></tr>
    <%
    int j = 1;
    while (rs.next()) {
   int staffId=rs.getInt(1);
   System.out.println("staffid first"+staffId);
    	%>    
    <tr>
        <td><%= rs.getInt(1) %></td>
        <td><%= rs.getString(2) %></td>
        <td><%= rs.getString(3) %></td>
        <td><%= rs.getString(8) %></td>
        <td><%= rs.getInt(4) %></td>
        <td><%= rs.getLong(5) %></td>
        <td><%= rs.getLong(6) %></td>
        <td><%= rs.getString(7) %></td>

        <form action="studelorupdate" method="post">
        <td>
        <input type="hidden" name="staffid" value="<%= staffId %>">
                <button type="submit" name="action"  value="update">Update</button>
  <!--                <button type="submit" name="action" value="delete">Delete</button>-->
        </td>
        </form>
        <form action="studelorupdate" method="post">
        <td>
        
       <input type="hidden" name="staffid" value="<%= staffId %>">  
<!--                 <button type="submit" name="action" value="update">Update</button>  -->
                <button type="submit" name="action" value="delete" >Delete</button>
        </td>
 		</form>

<!--  
        <td><button data-row-id="<%-- j --%>" onclick="call(<%-- j --%>)">Delete</button></td>
        <td><button data-row-id="<%-- j --%>" onclick="call(<%-- j --%>)">Delete</button></td>
-->
    </tr>
    <%
        j++;
    }
} catch (Exception e) {
    e.printStackTrace();
}
%>
</table>

</body>
</html>
