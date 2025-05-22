<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.ArrayList" %>
<%@ page import="suggestion.suggestionDetails" %>
<%@ page import="suggestion.suggestionDetails.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Suggestions - Online Computer Parts Store</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            margin-bottom: 20px;
        }
        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
        }
        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 15px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .back-link:hover {
            background-color: #2980b9;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        table th {
            background-color: #f8f9fa;
            color: #2c3e50;
        }
        img {
            max-width: 150px;
            border-radius: 8px;
            display: block;
            margin-bottom: 10px;
        }
        .actions a {
            display: inline-block;
            padding: 8px 12px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-right: 5px;
        }
        .actions a.delete {
            background-color: #e74c3c;
        }
        .actions a:hover {
            opacity: 0.8;
        }
        .no-suggestions {
            text-align: center;
            color: #888;
            font-style: italic;
            padding: 30px 0;
        }
        .admin-reply {
            background-color: #e8f4fc;
            padding: 10px;
            border-radius: 5px;
            margin-top: 10px;
        }    </style>
</head>
<body>
 <%@ include file="header.jsp" %>    <div class="container">
        <a href="suggestion.jsp" class="back-link">← Back to Submit Suggestions</a>

        <h1>Suggestion Details</h1>
        
        <% 
        // Display success message if it exists
        String message = (String) request.getAttribute("message");
        if (message != null && !message.isEmpty()) {
        %>
        <div style="background-color: #d4edda; color: #155724; padding: 15px; margin-bottom: 20px; border-radius: 5px; text-align: center;">
            <strong>Success!</strong> <%= message %>
        </div>
        <% } %>        <%
        ArrayList<suggestion> suggest = (ArrayList<suggestion>) request.getAttribute("suggestions");
        if (suggest != null && !suggest.isEmpty()) {
        %>
        <table>
            <tr>
                <th>Type</th>
                <th>Feedback</th>
                <th>Image</th>
                <th>Contact</th>
                <th>Actions</th>
            </tr>            <%
                for (suggestion sug : suggest) {
            %>
            <tr>
                <td><strong><%= sug.getSuggestiontype() %></strong></td>
                <td>
                    <%= sug.getFeedback() %>
                    <% if(sug.getReply() != null && !sug.getReply().isEmpty()) { %>
                    <div class="admin-reply">
                        <strong>Admin Reply:</strong> <%= sug.getReply() %>
                    </div>
                    <% } %>
                </td>
                <td>
                    <% if(sug.getImage() != null && !sug.getImage().isEmpty()) { %>
                    <img src="${pageContext.request.contextPath}/feedback/<%= sug.getImage() %>" 
                         alt="Suggestion Image">
                    <% } else { %>
                    <em>No image</em>
                    <% } %>
                </td>
                <td>
                    <strong>Username:</strong> <%= sug.getUsername() %><br>
                    <strong>Email:</strong> <%= sug.getEmail() %>
                </td>
                <td class="actions">
                    <% 
                    // Only show these options to admin or the user who submitted the suggestion
                    String currentUserType = (String)session.getAttribute("type");
                    String currentUsername = (String)session.getAttribute("username");
                    if("admin".equals(currentUserType) || (currentUsername != null && currentUsername.equals(sug.getUsername()))) { 
                    %>
                    <a href="BeforeUpdateSuggestion?id=<%= sug.getSuggestid() %>">Update</a>
                    <a href="DeleteSuggestion?id=<%= sug.getSuggestid() %>" class="delete" 
                       onclick="return confirm('Are you sure you want to delete this suggestion?')">Delete</a>
                    <% } %>
                </td>
            </tr>
            <%
                }
            %>
        </table>        <% } else { %>
        <div class="no-suggestions">
            <p>No suggestions found.</p>
        </div>
        <% } %>
    </div>
    
    <footer style="text-align: center; padding: 20px; margin-top: 40px; background-color: #2c3e50; color: white;">
        <p>&copy; <%= java.util.Calendar.getInstance().get(java.util.Calendar.YEAR) %> Online Computer Parts Store. All rights reserved.</p>
    </footer>
</body>
</html>
