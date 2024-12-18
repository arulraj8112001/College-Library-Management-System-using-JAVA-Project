<%@ include file="Authentication.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="kaniraj.Dbconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, jakarta.servlet.*, jakarta.servlet.http.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management System</title>
    <style type="text/css">
        body {
            background-color: #f5f5f5;
            background-image: linear-gradient(to right, #dce3e6, #f8f9fa);
            font-family: 'Arial', sans-serif;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #ff5722; /* Vibrant orange */
            padding: 20px;
            position: relative;
            z-index: 1000;
        }

        h1 {
            font-size: 28px;
            color: white;
        }

        .logout-button {
            padding: 12px 18px;
            background-color: #ff9800;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .logout-button:hover {
            background-color: #f57c00;
            transform: scale(1.05);
        }

        main {
            display: flex;
            margin-top: 20px;
            padding: 20px;
            flex-grow: 1;
        }

        /* Left-side navigation links */
        nav {
            flex-basis: 220px;
            padding: 20px;
            background-color: #00bcd4;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            font-weight: bold;
            padding: 12px;
            background-color: #00acc1;
            border-radius: 8px;
            text-align: center;
            transition: background-color 0.3s ease;
        	width:150px;
        }

        nav a:hover {
            background-color: #00838f;
        }

        /* Right-side content area with image and sections */
        .right-side {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-left: 20px;
        }

        .image-container {
            margin-bottom: 20px;
            text-align: center;
        }

        .image-container img {
            height: 450px;
            width: auto;
            border-radius: 20px;
            border: 5px solid #3f51b5;
            box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.3);
        }

        /* Slogan section */
        #slogan {
            background-color: #ffffff;
            padding: 30px;
            margin-bottom: 20px;
            width: 100%;
            border-radius: 20px;
            box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.2);
        }

        /* About section */
        #about {
        	margin-top:100px;
            background-color: #eeeeee;
            padding: 30px;
            width: 100%;
            border-radius: 20px;
            box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.15);
            text-align: center;
        }

        footer {
            background-color: #3f51b5;
            color: white;
            text-align: center;
            padding: 20px;
            font-size: 18px;
            letter-spacing: 1px;
            margin-top: auto;
        }
    
    /*  */
     /* Style for the options div */
        #optionsDiv {
            display: none;
            position: absolute;
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            border-radius: 8px;
            width: 180px;
            padding: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            z-index: 1000;
            color: white;
        }

        /* Style for the buttons inside the div */
        #optionsDiv button {
            display: block;
            width: 100%;
            margin: 10px 0;
            padding: 10px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            font-weight: bold;
            transition: background-color 0.3s, transform 0.2s;
        }

        /* Hover effect for buttons */
        #optionsDiv button:hover {
            background-color: rgba(255, 255, 255, 0.4);
            transform: scale(1.05);
        }
    
    
    </style>
</head>
<body>
    <script>
    
    function showOptions(event) {
        const optionsDiv = document.getElementById('optionsDiv');
        const linkText = event.target.textContent;

        // Toggle display if the same link is clicked
        if (optionsDiv.style.display === 'block' && optionsDiv.getAttribute('data-link') === linkText) {
            optionsDiv.style.display = 'none';
            return;
        }

        // Update the content and display of the options div
        optionsDiv.style.display = 'block';
        optionsDiv.setAttribute('data-link', linkText);

        // Position the div near the clicked link
        const rect = event.target.getBoundingClientRect();
        optionsDiv.style.left = `${rect.right + 10}px`;
        optionsDiv.style.top = `${rect.top}px`;

        // Update the content of the options div based on the clicked link
        if (linkText === 'Student') {
            optionsDiv.innerHTML = `
                <button onclick="addStudent()">Add Student</button>
                <button onclick="viewStudents()">View Students</button>
            `;
        } else if (linkText === 'Staff') {
            optionsDiv.innerHTML = `
                <button onclick="addStaff()">Add Staff</button>
                <button onclick="viewStaff()">View Staff</button>
            `;
        } else if (linkText === 'Book Information') {
            optionsDiv.innerHTML = `
                <button onclick="addBook()">Add Book</button>
                <button onclick="viewBooks()">View Books</button>
            `;
        }
    }

    function addStudent() {
  //      alert('Add Student button clicked!');
    window.location.href='student.jsp';
    }

    function viewStudents() {
    //    alert('View Students button clicked!');
    	window.location.href='viewStudents.jsp';
    }

    function addStaff() {
    //    alert('Add Staff button clicked!');
    	window.location.href='staff.jsp';
        }

    function viewStaff() {
//        alert('View Staff button clicked!');
    	window.location.href='allstaff.jsp';        
    }

    function addBook() {
        //alert('Add Book button clicked!');
    	window.location.href='index.html';
        }

    function viewBooks() {
        //alert('View Books button clicked!');
    	window.location.href='viewallbooks.jsp';
        }

    // Hide the div when clicking outside
    document.addEventListener('click', (event) => {
        const optionsDiv = document.getElementById('optionsDiv');
        if (!optionsDiv.contains(event.target) && event.target.tagName !== 'A') {
            optionsDiv.style.display = 'none';
        }
    });
    
    
    function logout()
    {
    	if(confirm("Are you sure want to logout the Library"))
    			window.location.href='Login.jsp';
    	else
    			window.location.href='home.jsp';
    		
    }
    
    </script>

    <header>
        <h1>Library Management</h1>
        <button class="logout-button" onclick="logout()">Logout</button>
    </header>

    <main>
        <!-- Left-side navigation links -->
        <nav>
    <!--         <a href="student.jsp">STUDENT</a>
            <a href="staff.html">STAFF</a>
            <a href="index.html">BOOK INFORMATION</a>
     -->
     
     
          <a href="#" onclick="showOptions(event)" >Student</a>
        <a href="#" onclick="showOptions(event)" >Staff</a>
        <a href="#" onclick="showOptions(event)" >Book Information</a>
             <a href="SearchBook.jsp">SEARCH</a>
			<a href="returnbook.jsp">Return Book</a>
            <a href="buybookdetails.jsp">Booking Details</a>
			<a href="returnbookdetails.jsp">Return Book Details</a>
			<a href="#about">ABOUT</a>
        </nav>
    <div id="optionsDiv">
        <button onclick="addStudent()">Add Student</button>
        <button onclick="viewStudents()">View Students</button>
    </div>


        <!-- Right-side content area -->
        <div class="right-side">
            <!-- Image at the top right -->
            <div class="image-container">
                <img src="libimg2.jpg" alt="Library Image">
            </div>

            <!-- Slogan section -->
            <section id="slogan">
                <h2>SLOGAN</h2>
                <p>* Library is a place for enhancing knowledge.</p>
                <p>* All types of books are available here.</p>
                <p>* Read, Learn, and Grow.</p>
            </section>

            <!-- About section -->
            <section id="about">
                <h2>ABOUT THE LIBRARY</h2>
                <p>
                    Welcome to our Library Management System.<br>
                    This is Kamrarajar Government Arts College Library.<br>
                    Developed by Kaniraj.<br>
                    Kamrarajar Government Arts College,<br>
                    Surandai - 627859.<br>
                    Tenkasi District,<br>
                    Tamil Nadu.
                </p>
            </section>
        </div>
    </main>

    <footer>
        <b>THANK YOU, VISIT AGAIN EVERYDAY!</b>
    </footer>

</body>
</html>


