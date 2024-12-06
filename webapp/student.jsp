<%@ page import="java.sql.*" %>
<%@ page import="kaniraj.Dbconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Student Information Form</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">   
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

        /* Form Container Styling */
        .form-container {
            background-color: #ffffff;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0px 12px 24px rgba(0, 0, 0, 0.15); /* Stronger shadow */
            width: 500px;
            border: 3px solid #00796b; /* Teal border */
        }

        h2 {
            color: #009688;
            text-align: center;
            margin-bottom: 40px;
            font-size: 26px;
        }

        label {
            font-weight: bold;
            color: #333;
            display: block;
            margin-top: 10px;
        }

        input[type="text"], input[type="number"], select, textarea {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: 2px solid #80cbc4;
            margin-top: 5px;
            margin-bottom: 10px;
            box-sizing: border-box;
            font-size: 16px;
        }

        /* Button Styling */
        input[type="submit"], input[type="reset"], input[type="button"] {
            background-color: #ff7043;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.2s ease;
        }

        input[type="submit"]:hover, input[type="reset"]:hover, input[type="button"]:hover {
            background-color: #e64a19;
            transform: translateY(-3px);
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
        }

        /* Responsive Design */
        @media screen and (max-width: 600px) {
            .form-container {
                width: 90%;
                padding: 20px;
            }

            h2 {
                font-size: 22px;
            }

            input[type="submit"], input[type="reset"], input[type="button"] {
                font-size: 16px;
                padding: 12px 18px;
            }
        }
    </style>
    <script>
        function validateform() {
            var RegisterNo = document.forms["form1"]["RegisterNo"].value;
            if (RegisterNo == null || RegisterNo == "") {
                alert("Please Enter Registration No.");
                document.form1.RegisterNo.focus();
                return false;
            }

            tosubmitform();
        }

        function call() {
            var phno = document.getElementById('contactno').value;
            var regno = document.getElementById('regno').value;
            if (phno.length != 10 || regno.length != 17) {
                alert("Please enter a valid Contact Number and Registration Number.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="form-container">
        <h2>Student Information Form</h2>

        <form id="studentForm" action="Student" method="post" >
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" onkeyup="isalphanumericonly(this);" required>

            <label for="batch-type">Degree-type:</label>
                <select id="batch-type" name="batch_type" required>
                <option value=""></option>            
<%
Connection con=Dbconnection.getConnection();
PreparedStatement ps=con.prepareStatement("select degreetype from studentdetails where degreetype!='empty'");
ResultSet rs=ps.executeQuery();
while(rs.next())
{
%>
                <option value="<%=  rs.getString("degreetype")%>"><%=  rs.getString("degreetype")%></option>
<%
}
%>
            </select>

            <label for="Department">Department:</label>
                <select id="batch-type" name="dept" required>
                <option value=""></option>            
<%
Connection conn=Dbconnection.getConnection();
PreparedStatement pst=conn.prepareStatement("select department from studentdetails where department!='empty'");
ResultSet rst=pst.executeQuery();
while(rst.next())
{
%>
                <option value="<%=  rst.getString("department")%>"><%=  rst.getString("department")%></option>
<%
}
%>
            </select>


            <label for="startyear">Joining Year:</label>
            <select id="year" name="year" required>
			
            </select>
            <script>
                const select = document.getElementById("year");
                const current = new Date().getFullYear();
                for (var i = current; i >= 2015; i--) {
                    const option = document.createElement('option');
            		if(i==current);
            		{
            			   option.value ="";
                           option.text ="";
                           select.appendChild(option);                       		
            		}
                    option.value = i;
                    option.text = i;
                    select.appendChild(option);
                }
            </script>

            <label for="regno">Registration Number:</label>
            <input type="number" id="regno" name="regno" onkeypress="if(this.value.length == 17) return false;" required>

            <label for="contactno">Contact Number:</label>
            <input type="number" id="contactno" name="contactno" onkeypress="if(this.value.length == 10) return false;" required>

            <label for="address">Address:</label>
            <textarea id="address" name="address" rows="2" required></textarea>

            <div style="display: flex; justify-content: space-between;">
                <input type="submit" value="Submit" onclick="return call();">
                <input type="reset" value="Reset">
                <input type="button" value="ViewStudents" onclick="window.location.href='viewStudents.jsp';">
            </div>
        </form>
    </div>


    <!-- Home button -->
    <div class="fixed-buttons">

        <button class="btn" style="margin-right:980px;" onclick="window.location.href='editstudentpage.jsp'">;
            <i class="fas fa-admin"></i> Admin
        </button>

        <button class="btn" onclick="window.location.href='home.jsp'">
        <i class="fas fa-home"></i> HOME
        </button>
    </div>

</body>
</html>





</body>
</html>