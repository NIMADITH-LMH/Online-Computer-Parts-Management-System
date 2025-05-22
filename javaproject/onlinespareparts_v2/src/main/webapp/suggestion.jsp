<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Suggestions - Online Computer Parts Store</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            color: #333;
        }
        
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        
        h1 {
            color: #2c3e50;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .suggestion-form {
            margin-bottom: 30px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        input[type="text"],
        input[type="email"],
        select,
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        
        textarea {
            height: 150px;
            resize: vertical;
        }
        
        button {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            transition: background-color 0.3s;
        }
        
        button:hover {
            background-color: #2980b9;
        }
        
        .nav-links {
            margin-top: 20px;
            text-align: center;
        }
        
        .nav-links a {
            color: #3498db;
            margin: 0 10px;
            text-decoration: none;
        }
        
        .nav-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
      <div class="container">
        <% 
        // Get the user type from session (avoid using variable name 'type' as it's already in header.jsp)
        String userType = (String)session.getAttribute("type");
        
        // Only show the suggestion form for non-admin users (customers or sellers)
        if (!"admin".equals(userType)) { 
        %>
        <h1>Submit Your Suggestion</h1>
        
        <div class="suggestion-form">
            <form action="submitSuggestion" method="post" enctype="multipart/form-data">
                <input type="hidden" name="username" value="<%= session.getAttribute("username") %>">
                
                <div class="form-group">
                    <label for="suggestionType">Suggestion Type</label>
                    <select id="suggestionType" name="suggestionType" required>
                        <option value="">-- Select a type --</option>
                        <option value="product">Product Suggestion</option>
                        <option value="feature">Feature Suggestion</option>
                        <option value="feedback">General Feedback</option>
                        <option value="complaint">Complaint</option>
                        <option value="suggestion">Other Suggestion</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="feedback">Your Suggestion/Feedback</label>
                    <textarea id="feedback" name="feedback" required placeholder="Please provide details of your suggestion or feedback"></textarea>
                </div>
                
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" required placeholder="We'll contact you at this email">
                </div>
                
                <div class="form-group">
                    <label for="imageUpload">Upload Screenshot/Image (Optional)</label>
                    <input type="file" id="imageUpload" name="image" accept="image/*">
                </div>
                
                <button type="submit">Submit Suggestion</button>
            </form>
        </div>
        <% } %>
          <%-- Navigation links for viewing suggestions --%>
        <div class="nav-links" style="text-align: center; margin: 30px 0;">
        <% 
        // Admin sees only the "View All Suggestions" link, not the form
        if ("admin".equals(userType)) { 
        %>
            <h1>Suggestion Management</h1>
            <p>As an administrator, you can manage all customer suggestions below.</p>
            <a href="suggestionDetails?action=listAll" class="btn" style="display: inline-block; padding: 12px 24px; background-color: #3498db; color: white; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px;">View All Suggestions</a>
        <% } else if (session.getAttribute("username") != null) { %>
            <a href="suggestionDetails" class="btn" style="display: inline-block; padding: 12px 24px; background-color: #3498db; color: white; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 15px;">View My Suggestions</a>
        <% } %>
    </div>
    
    <footer style="text-align: center; padding: 20px; margin-top: 40px; background-color: #2c3e50; color: white;">
        <p>&copy; <%= java.util.Calendar.getInstance().get(java.util.Calendar.YEAR) %> Online Computer Parts Store. All rights reserved.</p>
    </footer>
</body>
</html>