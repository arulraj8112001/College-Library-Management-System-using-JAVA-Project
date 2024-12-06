<%@ page import="java.sql.*" %>
<%@ page import="kaniraj.Dbconnection" %>
<%@ page import="java.time.Year" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Staff Details</title>
    <style>
        body {
            background-color: #e3f2fd; /* Light blue background */
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
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

        
        
        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            position: relative;
        }
        .header {
            background-color: #42a5f5;
            padding: 10px 0;
            color: white;
            text-align: center;
            border-radius: 10px 10px 0 0;
        }
        h1 {
            color: #fff;
            margin: 0;
        }
        /* Fixed buttons for Home and Staff */
        .buttons {
            position: fixed;
            top: 20px;
            right: 20px;
        }
        .buttons a {
            text-decoration: none;
            background-color: #fff;
            padding: 8px 12px;
            border-radius: 5px;
            color: #333;
            border: 2px solid #42a5f5;
            font-weight: bold;
            display: inline-flex;
            align-items: center;
            margin-left: 10px;
            margin-bottom: 10px;
        }
        .buttons a:hover {
            background-color: #42a5f5;
            color: white;
        }
        .buttons img {
            width: 16px;
            margin-right: 8px;
        }
        label {
            display: block;
            margin-bottom: 10px;
            font-size: 1.2em;
            color: #333;
        }
        input[type="text"],
        input[type="number"],
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
        }
        input[type="submit"] {
            background-color: #42a5f5;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1em;
        }
        input[type="submit"]:hover {
            background-color: #1e88e5;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">   
</head>
<body>

    <!-- Fixed buttons for Staff and Home with icons -->
    <div class="fixed-buttons">
        <button class="btn" onclick="window.location.href='viewStudents.jsp'">
            <i class="fas fa-user-tie"></i> Student
        </button>
        <button class="btn" onclick="window.location.href='home.jsp'">
            <i class="fas fa-home"></i> Home
        </button>
    </div>

    <!-- Fixed buttons for Home and Staff -->
 <!-- 
     <div class="buttons">
        <a href="home.jsp">
            <img src="home_icon.png" alt="Home"> Home
        </a>
        <a href="staff.jsp">
            <img src="staff_icon.png" alt="Staff"> Staff
        </a>
    </div>
-->

    <div class="container">
        <div class="header">
            <h1>Update Student Details</h1>
        </div>

        <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                HttpSession hs = request.getSession(false);
                String sid = (String) hs.getAttribute("sid");
        %>
        <div class="form-group">
            <label for="sid">Update ID:</label>
            <input type="text" id="sid" value="<%= sid %>" disabled>
        </div>
        <%
            System.out.println("update sid " + sid);

            con = Dbconnection.getConnection();
            ps = con.prepareStatement("SELECT COLUMNS FROM STUDENTDETAILS WHERE COLUMNS != 'empty'");
            rs = ps.executeQuery();
        %>
        <form action="" method="post">
            <div class="form-group">
                <label for="ab">Select Column:</label>
                <select name="ab" id="ab" onchange="this.form.submit()">
                    <option value="">--Select Column--</option>
                    <%
                        while (rs.next()) {
                    %>
                    <option value="<%= rs.getString("columns") %>"><%= rs.getString("columns") %></option>
                    <%
                        }
                    %>
                </select>
            </div>
        </form>

        <form action="updatestudent" method="post">
        <%
            String check = request.getParameter("ab");
            System.out.println(" parse " + check);
            if (check != null) {
                String col = request.getParameter("ab");

                HttpSession ss = request.getSession();
                ss.setAttribute("col", col);
        %>
            <input type="hidden" name="nid" value="<%= sid %>">
            <div class="form-group">
                <label for="col">NEW UPDATE <%= col %>:</label>
                <%
                    if (col.equals("name") || col.equals("address")) {
                %>
                <input type="text" name="val">
                <%
                    } else if (col.equals("department") || col.equals("degreetype") || col.equals("joiningyear")) {
                        //String st = (col.equals("shift")) ? "SELECT DISTINCT shift FROM staffdetails WHERE shift != " + 0 : "SELECT DISTINCT " + col + " FROM staffdetails WHERE " + col + " != '0'";
                        if(col.equals("joiningyear"))
                        {
                        int cyear=Year.now().getValue();
						PreparedStatement ps2=con.prepareStatement("select year from studentdetails where year!=0");
                        ResultSet rs2=ps2.executeQuery();
                        rs2.next();
                        int start=rs2.getInt(1);
                        %>
                      <select>
<%	for(int i=cyear;i>=start;i--){	 %>
                      <option value="<%= i %>"><%= i %></option>
<% } %>
                      </select>
                      <%   
                    }else
                    {
                    String st="SELECT DISTINCT " + col + " FROM studentdetails WHERE " + col + " != 'empty'";
                        ps = con.prepareStatement(st);
                        rs = ps.executeQuery();
                %>
                <select name="val">
                    <option value="">--Select <%= col %>--</option>
                    <%
                        while (rs.next()) {
                    %>
                    <option value="<%= rs.getString(col) %>"><%= rs.getString(col) %></option>
                    <%
                        }
                    %>
                </select>
                <%
                    }
                        
                    } else if(col.equals("phno")){
                %>
                <input type="number" name="val" onKeyPress="if(this.value.length==10) return false;" required>
                <%
                    }
                    else{
                %>
                <input type="number" name="val" onKeyPress="if(this.value.length==17) return false;" required>
                
                <% } %>
            </div>
            <input type="submit" value="Submit">
        </form>
        <% } %>

        <%
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>
</body>
</html>





















<%-- 


<%@ page import="java.sql.*" %>
<%@ page import="kaniraj.Dbconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Staff Details</title>
</head>
<body>
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
    	HttpSession hs=request.getSession(false);
        String sid = (String) hs.getAttribute("sid");
        %>
       Update Id : <input type="text" value="<%= sid %>" disabled>
  <% 
  
        System.out.println("update sid "+sid);
        /*
request.setAttribute("sid", id);
RequestDispatcher rd=request.getRequestDispatcher("updatestaff");
rd.forward(request, response);
*/

	con = Dbconnection.getConnection();
        
        // Step 1: Display dropdown for selecting columns (name, department, etc.)
        ps = con.prepareStatement("SELECT UCOLUMNS FROM STAFFDETAILS WHERE UCOLUMNS != 'empty'");
        rs = ps.executeQuery();
%>
		<form action="" method="post">
        Select Column: 
        <select name="ab"  onchange="this.form.submit()">
				<option value="">--select col---</option>	
<%
        while (rs.next()) {
%>
            <option value="<%= rs.getString("ucolumns") %>"><%= rs.getString("ucolumns") %></option>
<%
        }
%>
        </select>
        </form>
<form action="updatestaff" method="post">
<%
		String check=request.getParameter("ab");
        System.out.println(" parse "+check);
		if (check != null) {
            String col = request.getParameter("ab");
		
         HttpSession ss=request.getSession();
         ss.setAttribute("col", col);
            
%>
	<input type="hidden" name="nid" value="<%= sid %>">
		ID      : <%= (String)request.getAttribute("sid") %>
        NEW UPDATE <%= col %>:
<%
            if (col.equals("name")) {
%>
                <input type="text" name="val">
<%
            } else if (col.equals("department") || col.equals("stafftype") || col.equals("shift")) {
                // Query based on column
                String st = (col.equals("shift")) ? "SELECT DISTINCT shift FROM staffdetails WHERE shift != "+0 : "SELECT DISTINCT " + col + " FROM staffdetails WHERE " + col + " != '0'";
                ps = con.prepareStatement(st);
                rs = ps.executeQuery();
%>
                <select name="val">
				<option value="">--select <%= col %>---</option>	
<%
                while (rs.next()) {
%>
                    <option value="<%= rs.getString(col) %>"><%= rs.getString(col) %></option>
<%
                }
%>
                </select>
<%
            } else {
%>
                <input type="number" name="val" onKeyPress="if(this.value.length>9 && this.value.length<11) return false;" required>
<%
            }
%>
        <input type="submit" value="submit">
</form>

 <% 
        /*
            // Step 2: Update the staff details based on the selected column and input
            String updateQuery;
            if (col.equals("shift") || col.equals("phoneno")) {
                updateQuery = "UPDATE staffdetails SET " + col + " = ? WHERE id = ?";
            } else {
                updateQuery = "UPDATE staffdetails SET " + col + " = ? WHERE id = ?";
            }

            ps = con.prepareStatement(updateQuery);

            if (col.equals("shift")) {
                ps.setInt(1, Integer.parseInt(request.getParameter("val")));
            } else if (col.equals("phoneno")) {
                ps.setLong(1, Long.parseLong(request.getParameter("val")));
            } else {
                ps.setString(1, request.getParameter("val"));
            }
            ps.setInt(2, Integer.parseInt(sid));

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                out.println("Data updated successfully.");
            } else {
                out.println("Failed to update data.");
            }
            
        */    
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Step 3: Close the ResultSet and PreparedStatement
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
</body>
</html>


--%>



