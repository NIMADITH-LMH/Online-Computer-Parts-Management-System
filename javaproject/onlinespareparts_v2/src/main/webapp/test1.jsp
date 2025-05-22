<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home Page</title>
    <link rel="stylesheet" href="home.css">
    <style>
    	/* General styling */
body {
    font-family: Arial, sans-serif;
    padding: 20px;
}

header {
    background-color: #f1f1f1;
    padding: 20px;
    text-align: center;
    border-bottom: 1px solid #ddd;
}

section {
    margin: 50px 0;
    padding: 20px;
    height: 1500px; /* This will create a scrollable page */
}

/* Fixed message icon styling */
.message-icon {
    position: fixed;
    bottom: 20px;
    right: 20px;
    background-color: #2f80ed;
    border-radius: 50%;
    padding: 15px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    z-index: 1000;
    font-size: 24px;
    color: white;
    text-align: center;
    cursor: pointer;
}

.message-icon a {
    color: white;
    text-decoration: none;
}

.message-icon:hover {
    background-color: #1a60d1;
}
    	
    </style>
</head>
<body>
    <header>
        <h1>Welcome to the Home Page</h1>
        <p>This is some content on the home page. Scroll down to see the fixed message icon.</p>
    </header>

    <section>
        <p>More content here...</p>
        <p>More content here...</p>
        <p>More content here...</p>
        <p>More content here...</p>
        <p>More content here...</p>
        <p>More content here...</p>
        <p>More content here...</p>
        <p>More content here...</p>
        <p>More content here...</p>
    </section>

    <!-- Fixed Message Icon -->
    <div class="message-icon">
        <a href="messages.jsp">💬</a>
    </div>
</body>
</html>
