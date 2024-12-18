<%@ page import="java.sql.*" %>
<%@ page import="kaniraj.Dbconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, jakarta.servlet.*, jakarta.servlet.http.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Form</title>
    <!-- Font Awesome for the Home Icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<!--  
      <link rel="stylesheet" type="text/css" href="style.css">  
-->
    <style>
       /* General Styling */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #e0f7fa; /* Light teal background */
            color: #333;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            position: relative;
        }

        /* Home and Staff Buttons Container Styling */
        .fixed-buttons {
            position: absolute;
            top: 20px;
            right: 20px;
            display: flex;
            flex-direction: row; /* Align buttons in a row */
            gap: 20px; /* Space between the buttons */
        }

        /* Common button styling for home and staff */
        .btn {
            background-color: #ff7043;
            color: #ffffff;
            padding: 12px 20px;
            font-size: 16px;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            display: flex;
            align-items: center;
        }

        .btn:hover {
            background-color: #e64a19;
            transform: translateY(-3px);
        }

        .btn i {
            margin-right: 8px; /* Space between icon and text */
        }

        /* Form Container Styling */
        .form-container {
            background-color: #ffffff;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0px 12px 24px rgba(0, 0, 0, 0.15); /* Stronger shadow */
            width: 450px;
            border: 3px solid #00796b; /* Teal border */
        }

        h1 {
            color: #009688;
            text-align: center;
            margin-bottom: 40px;
            font-size: 26px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            font-weight: bold;
            color: #333;
        }

        input, select {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: 2px solid #80cbc4;
            margin-top: 8px;
            box-sizing: border-box;
            font-size: 16px;
        }

        /* Button Styling */
        button {
            background-color: #ff7043;
            color: #ffffff;
            border: none;
            padding: 15px 25px;
            font-size: 18px;
            border-radius: 12px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.2s ease;
        }

        button:hover {
            background-color: #e64a19;
            transform: translateY(-3px);
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2); /* Extra shadow on hover */
        }

        button:focus {
            outline: none;
        }

        /* View All Staff Button */
        button:last-child {
            background-color: #66bb6a;
            margin-left: 20px;
        }

        button:last-child:hover {
            background-color: #43a047;
        }

        /* Responsive Design */
        @media screen and (max-width: 600px) {
            .form-container {
                width: 90%;
                padding: 20px;
            }

            h1 {
                font-size: 22px;
            }

            button {
                font-size: 16px;
                padding: 12px 18px;
            }
        }
        
    </style>

    <script>
    function check() {
        var name = document.getElementById("name").value;
        var courseType = document.getElementById("courseType").value;
        var staffType = document.getElementById("staffType").value;
        var shift = document.getElementById("shift").value;
        var contactNo = document.getElementById("contactNo").value;

        if (name == "" || courseType == "" || staffType == "" || shift == "" || contactNo == "") {
            alert("Please fill out all fields and then click on Submit");
        }
    }
    </script>
</head>
<body>

    <div class="form-container">
        <h1>Staff Information Form</h1>
        <form action="Staff" method="post">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
          <%
          Connection con=Dbconnection.getConnection();
          String str="select department from staffdetails where department!='empty'";
          PreparedStatement ps=con.prepareStatement(str);
          ResultSet rs=ps.executeQuery();
          
          %>
            <div class="form-group">
                <label for="Department">Department :</label>
                <select id="courseType" name="courseType" required>
				<option value=""></option>	
          		<% while(rs.next())
          			{%>
          			<option value="<%= rs.getString("department") %>"><%= rs.getString("department") %></option>
          		<% } %>
                </select>
            </div>
          
          
          <!--  
            <div class="form-group">
                <label for="courseType">Course Type:</label>
                <select id="courseType" name="courseType" required>
                    <option></option>
                    <option value="ComputerScience">Computer Science</option>
                    <option value="Tamil">Tamil</option>
                    <option value="English">English</option>
                    <option value="Maths">Maths</option>
                    <option value="BBA">BBA</option>
                    <option value="Bcom">Bcom</option>
                    <option value="Physics">Physics</option>
                    <option value="Chemistry">Chemistry</option>
                    <option value="MicroBiology">MicroBiology</option>
                    <option value="Economics">Economics</option>
                    <option value="Electronics">Electronics</option>
                </select>
            </div>
          -->
           <!--  
            <div class="form-group">
                <label for="staffType">Staff Type:</label>
                <select id="staffType" name="staffType" required>
                    <option></option>
                    <option value="government_staff">Government Staff</option>
                    <option value="guest_lecturer">Guest Lecturer</option>
                    <option value="pta_staff">PTA Staff</option>
                </select>
            </div>
            -->
                <% 
                ps=con.prepareStatement("select shift from staffdetails where shift!=0");
                rs=ps.executeQuery();
                %>    

            <div class="form-group">
                <label for="shift">Shift:</label>
                <select id="shift" name="shift" required>
                    <option></option>
                <%
                while(rs.next())
                {
                %>
          			<option value="<%= rs.getInt("shift") %>"><%= rs.getString("shift") %></option>
                <%}%>
                </select>
            </div>
            <div class="form-group">
                <label for="contactNo">Contact No.:</label>
                <input type="number" id="contactNo" name="contactNo" onKeyPress="if(this.value.length>9 && this.value.length<11) return false;" required>
            </div>
            <div style="display: flex; justify-content: space-between;">
                <button type="submit" onclick="check()">Submit</button>
                <button type="reset">Reset</button>
                <button type="button" onclick="window.location.href='allstaff.jsp'">VIEW ALL STAFF</button>
            </div>
        </form>
    </div>
    <!-- Fixed buttons for Staff and Home in a row -->
    <div class="fixed-buttons">
<!--
        <button class="btn" onclick="window.location.href='staff.jsp'">
            <i class="fas fa-user-tie"></i> Staff
        </button>
-->
        <button class="btn" style="margin-right:980px;" onclick="window.location.href='editstaffpage.jsp'">;
            <i class="fas fa-admin"></i> Admin
        </button>
        <button class="btn" onclick="window.location.href='home.jsp'">
            <i class="fas fa-home"></i> Home
        </button>
        
        
        
    </div>

</body>
</html>
