<%@ page import="java.sql.*" %>
<%@ page import="kaniraj.Dbconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Data</title>
    <style type="text/css">
        /* General Body Styling */
        body {
            background: linear-gradient(to right, #ff9a9e, #fad0c4); /* Gradient pink background */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        /* Container Styling */
        .container {
            background-color: #ffffff; /* White background for form */
            border-radius: 15px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); /* Shadow for depth */
            padding: 30px;
            max-width: 600px;
            width: 100%;
            text-align: center;
        }

        h1 {
            color: #4a148c; /* Deep purple for heading */
            font-size: 28px;
            margin-bottom: 20px;
        }

        input[type="text"], input[type="number"] {
            width: 80%;
            padding: 12px;
            margin: 15px 0;
            border: 2px solid #64b5f6; /* Light blue border */
            border-radius: 10px;
            font-size: 16px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #42a5f5; /* Bright blue button */
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #1e88e5; /* Darker blue on hover */
        }

        /* Responsive Design */
        @media (max-width: 600px) {
            .container {
                padding: 20px;
            }

            h1 {
                font-size: 24px;
            }

            input[type="text"], input[type="number"] {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <form action="adddataservlet" method="post">
            <h1>Enter your new <%= request.getParameter("added") %></h1>
            <%
                String s = request.getParameter("added"); 
                System.out.println("added " + s);
                ServletContext context = getServletContext();
                context.setAttribute("added", s);

                try {
                    if (s != null) {
                        if (s.equals("department")) {
            %>
                            <input type="text" name="dept" placeholder="Enter Department Name">
            <%
                        } else if (s.equals("stafftype")) {
            %>
                            <input type="text" name="staff" placeholder="Enter Staff Type">
            <%
                        } else {
            %>
                            <input type="number" name="shift" placeholder="Enter Shift Number">
            <% 
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();    
                }
            %>
            <input type="submit" value="Add">
        </form>
    </div>
</body>
</html>
