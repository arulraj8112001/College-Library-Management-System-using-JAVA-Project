<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="kaniraj.Dbconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Library Return Book Details</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .form-container {
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.2);
            padding: 30px;
            width: 450px;
        }
        h2 {
            text-align: center;
            color: #2575fc;
            font-size: 24px;
            margin-bottom: 25px;
        }
        label {
            font-weight: bold;
            color: #333;
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="date"],
        input[type="number"],
        select {
            width: 100%;
            padding: 10px;
            margin: 10px 0 20px 0;
            border: 1px solid #bbb;
            border-radius: 8px;
            box-sizing: border-box;
            background-color: #f9f9f9;
            transition: border-color 0.3s;
        }
        input[type="text"]:focus,
        input[type="date"]:focus,
        input[type="number"]:focus,
        select:focus {
            border-color: #6a11cb;
            outline: none;
        }
        input[type="submit"] {
            width: 100%;
            background-color: #2575fc;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #6a11cb;
        }
    </style>
</head>
<body>
<%                  String bname = "";
        		int no=0;
        		%>

<script>
let no;
let name;
function setaccess(no)
{
	localStorage.setItem("ano",no);
}
function setbname(name)
{
	localStorage.setItem("bname",name);
}
function getaccess()
{
	return localStorage.getItem("ano");
}
function getbname()
{
	return localStorage.getItem("bname");
}


</script>

    <div class="form-container">
        <h2>Library Return Book Details</h2>
        <%
        try {
%>
        <form action="" method="post">
            <label for="booktaker">Book Taker:</label>
            <select name="type" id="sval"  onchange=" this.form.submit();">
                <option value="">Select </option>
                <option value="Staff"  id="Staff" onclick="callvalue(this.value)">Staff</option>
                <option value="Student" id="Student" onclick="callvalue(this.value)">Student</option>
            </select>
        </form>
        
        <script>
        	function callvalue(ssval)
        	{
        		
        		const element=document.getElementById('sval');
				const sval=document.getElementById(ssval);	
        		const val=element.value;
        	if(val)
        		{
        		document.getElementById('val').textContent=sval;
        		}
        	else
        		{
        		document.getElementById('val').textContent="";
        		}
        	
        		
        	}
        </script>
<!-- 

ALTER TABLE s3 ADD COLUMN buybookno INTEGER[];
UPDATE s3 SET buybookno = '{101, 102, 103}' WHERE name = 'raj' AND age = 1;
UPDATE s3 SET buybookno = array_append(buybookno, 104) WHERE name = 'raj' AND age = 1;
UPDATE s3 SET buybookno = array_remove(buybookno, 102) WHERE name = 'raj' AND age = 1;

 -->
 <!--  
         <script>
 
    // Get today's date in the format YYYY-MM-DD
    const today = new Date().toISOString().split('T')[0];

    // Set the max attribute to today's date
    const dateInput = document.getElementById('dateInput');
    dateInput.setAttribute('max', today);

    // Function to check if a date is a weekend (Saturday or Sunday)
    function isWeekend(date) {
        const day = date.getDay();
        return day === 6 || day === 0; // 6 = Saturday, 0 = Sunday
    }

    // Event listener for when the user changes the date
    dateInput.addEventListener('change', function() {
        const selectedDate = new Date(this.value);

        if (isWeekend(selectedDate)) {
            // Display an error message and clear the input value
            document.getElementById('error').style.display = 'inline';
            this.value = ''; // Clear the input if a weekend is selected
        } else {
            // Hide the error message if a valid date is selected
            document.getElementById('error').style.display = 'none';
        }
    });
</script>
 
-->


        <form action="returnbookadd" method="post">
            
            
            <label for="accessno">Access No:</label>
            <input type="number" id="accessno" name="accessno" min="100" max="10000" required>

            <!-- <label for="bookname">Book Name:</label>
            <input type="text" id="bookname" name="bookname" required>
             -->
            <% 
        	String sort=request.getParameter("type");
            System.out.println(" sort value "+sort);

            if (sort != null && !sort.isEmpty())
        	{
        	
        	HttpSession hs=request.getSession();
        			hs.setAttribute("sort",sort);
        	}	

            
            
            /*
            if (sort != null && !sort.isEmpty()) {
                HttpSession hs = request.getSession();
                hs.setAttribute("sort", sort);
            } else {
                // Get the previously stored value from the session if 'sort' is null or empty
                HttpSession hs = request.getSession(false);
                if (hs != null) {
                    sort = (String) hs.getAttribute("sort");
                }

                // If 'sort' is still null, set it to an empty string
                if (sort == null) {
                    sort = "";
                }
            }
            */
            
            
            /* if (sort != null && !sort.isEmpty())
            	{
            	
            	HttpSession hs=request.getSession();
            			hs.setAttribute("sort",sort);
            	}	
            System.out.println(" sort boolean "+sort.equals("Student"));
             */
            
            if (sort != null && !sort.isEmpty())
         	{
/*             	HttpSession hs=request.getSession();
    			hs.setAttribute("sort",sort);
         	}
 */
            %>
            
            
            <label for="sname"><%= sort %> Name:</label>
            <input type="text" id="sname" name="sname" required>



            <% if (sort.equals("Student")) { %>
                <label for="sregno">Student Reg No:</label>
                <input type="number" id="sregno" name="sregno" onkeypress="if(this.value.length == 17) return false;" required>
            <% } %>

            <label for="phoneno"><%= sort %> Phone No:</label>
            <input type="number" id="phoneno" name="phoneno" onkeypress="if(this.value.length == 10) return false;" required>

<%--
	LocalDate date=LocalDate.now();
--%>

<!--             <label for="ReturnDate">BookReturn Date:</label>
            <input type="date" id="ReturnDate" name="ReturnDate" required>
 -->
 <!--        
 <label for="ReturnDate">BookReturn Date:</label>          
 <input type="date" id="dateInput" min="2023-01-01" max="">
<span id="error" style="color:red; display:none;">Weekends are not allowed. Please select a weekday.</span>
 -->
 

		    <input type="submit" value="Submit">
        
		<% } %>


        </form>

            <%
         	
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>

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
<%
try
{
       			HttpSession aa2=request.getSession(false);
				Integer i=(Integer)aa2.getAttribute("ssid");
				String ide=i+"";
	out.println("buybookcol "+ide);
	 

 int id=0;
	
if(ide!=null && !ide.isEmpty())
{
	id=Integer.parseInt(ide);

	

String str="SELECT * FROM bookinformation where accessno=?";
Connection con=Dbconnection.getConnection();
PreparedStatement ps=con.prepareStatement(str);
ps.setInt(1,id);
ResultSet rs=ps.executeQuery();
String bname="";
%>

<table border="2">
<tr><th>Accessno</th><th>Book-Name</th><th>Author-name</th><th>Edition</th><th>Publisher</th></tr>
<% 
while(rs.next())
{
	bname=rs.getString("bookname");
%>
<tr><td><%= rs.getInt("accessno") %></td><td><%= rs.getString("bookname") %></td><td><%= rs.getString("authorname") %></td><td><%= rs.getString("Edition") %></td><td><%= rs.getString("publisher") %></td></tr>
<% } %> 
</table>

accessno : <input type="text" value="<%= id %>" disabled><br><br>

Book-name : <input type="text" value="<%= bname %> " disabled>

<form action="" method="post"> 
booktaker :<select name="sort" onchange="this.form.submit()">
<option value=""></option>
<option value="Staff">Staff</option>
<option value="Student">Student</option>
</select>
</form>

<form action="" method="post">
<% 
String sort=request.getParameter("sort");
if(sort!=null && !sort.isEmpty())
{
	%>
 <%= sort %>  Name :<input type="text" name="sname">
 if(sort.equals("Student"))
 	<%= sort %>  regno :<input type="number" name="sregno" onkeypress="if(this.value.length == 17) return false;">
 <%= sort %>  phoneno :<input type="number" name="sregno" onkeypress="if(this.value.length == 10) return false;">

<label for="borrowDate">Borrow Date:</label>
            <input type="date" id="borrowDate" name="borrowDate" required>


<% 	
	
	
}
else
	System.out.println(" invalid value ");
%>


    <input type="submit" value="Submit">
</form>
<%
}
else
	System.out.println(" inValid id ");
	
}
catch(Exception e)
{
	e.printStackTrace();
}
%>

</body>
</html>
--%>