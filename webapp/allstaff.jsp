


<%@ page import="java.sql.*"  %>
<%@ page import="kaniraj.Dbconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Staff Details</title>
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
        
        
    </script>
</head>
<body>

    <!-- Fixed buttons for Staff and Home with icons -->
    <div class="fixed-buttons">
        <button class="btn" onclick="window.location.href='staff.jsp'">
            <i class="fas fa-user-tie"></i>Add Staff
        </button>
        <button class="btn" onclick="window.location.href='home.jsp'">
            <i class="fas fa-home"></i> Home
        </button>
    </div>

    <center><h1>ALL STAFF DETAILS</h1></center>

    <%
        int id = 0;
        int count = 0;

        try {
            Connection con = Dbconnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM STAFF WHERE delete=0 ORDER BY id");
            ResultSet rs = ps.executeQuery();
    %>

    <!-- Staff Details Table -->
    <table border="2">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Department</th>
<!--              <th>Staff Type</th>   -->
            <th>Shift</th>
            <th>Mobile Number</th>
            <th>Edit</th>
            <th>Delete</th>
        </tr>

        <%
            int i = 1;
            while (rs.next()) {
                int staffId = rs.getInt(1);
        %>

        <tr>
            <td><%= staffId %></td>
            <td><%= rs.getString(2) %></td>
            <td><%= rs.getString(3) %></td>
<%--              <td><%= rs.getString(4) %></td>   --%>
            <td><%= rs.getInt(5) %></td>
            <td><%= rs.getLong(6) %></td>              
        <form action="deleteorupdate" method="post">
        <td>
        <input type="hidden" name="staffid" value="<%= staffId %>">
                <button type="submit" name="action"  value="update">Update</button>
  <!--                <button type="submit" name="action" value="delete">Delete</button>-->
        </td>
        </form>
        <form action="deleteorupdate" method="post">
        <td>
        
       <input type="hidden" name="staffid" value="<%= staffId %>">  
<!--                 <button type="submit" name="action" value="update">Update</button>  -->
                <button type="submit" name="action" value="delete" >Delete</button>
        </td>
        </form>
        
        <!--  
            <td><button class="action-button" >UPDATE</button></td>
            <td><button class="action-button" >DELETE</button></td>
        -->
        
        </tr>

        <%
                i++;
            }
        %>

    </table>

    <%
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    
    <!-- Font Awesome CDN for icons -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
</body>
</html>
