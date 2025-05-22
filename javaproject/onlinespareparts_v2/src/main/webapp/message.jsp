<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Suggestion</title>
    <style>
    	* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-color: #f1f1f1;
}

.form-container {
    width: 400px;
    background-color: white;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    padding: 20px;
    text-align: center;
}

.form-header h1 {
    font-size: 24px;
    color: #333;
    margin-bottom: 20px;
}

.form-group {
    margin-bottom: 15px;
    text-align: left;
}

.form-group label {
    font-size: 14px;
    color: #333;
    margin-bottom: 5px;
    display: block;
}

.form-group input, .form-group select, .form-group textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    outline: none;
    font-size: 14px;
    margin-bottom: 10px;
}

.form-group input[type="file"] {
    padding: 5px;
}

textarea {
    resize: vertical;
}

small {
    font-size: 12px;
    color: #777;
}

.form-actions {
    margin-top: 20px;
}

.btn {
    width: 100%;
    padding: 12px;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s;
}

.submit-btn {
    background-color: #FF5722;
    color: white;
}

.reset-btn {
    background-color: #757575;
    color: white;
    margin-top: 10px;
}

.submit-btn:hover {
    background-color: #E64A19;
}

.reset-btn:hover {
    background-color: #616161;
}
    	
    </style>
</head>
  
<body>
<% String Username = (String) request.getSession().getAttribute("username");%>
    <div class="form-container">
        <div class="form-header">
            <h1>Add new suggestion</h1>
        </div>

        <form action="submitSuggestion" method="post" enctype="multipart/form-data">
            <!-- Dropdown for selecting what user wants to do -->
            <div class="form-group">
                <label for="suggestionType">Please first let us know what you'd like to do:</label>
                <select id="suggestionType" name="suggestionType" required>
                    <option value="report_bug">Report a bug</option>
                    <option value="feedback">Provide feedback</option>
                    <option value="suggestion">Make a suggestion</option>
                </select>
            </div>

            <!-- Feedback text area -->
            <div class="form-group">
               
                <textarea id="feedback" name="feedback" placeholder="We take your feedback seriously. If you have a suggestion or a problem, please include any relevant details:" rows="5" required></textarea>
            </div>

            <!-- Image upload section -->
            <div class="form-group">
                <label for="screenshot">Upload screenshot:</label>
                <input type="file" id="screenshot" name="image" accept=".jpg, .jpeg, .png" multiple>
               
            </div>

           

            <!-- Email input -->
            <div class="form-group">
                <label for="email">Please fill in your email address:</label>
                <input type="email" id="email" name="email" placeholder="Your email address" required>
            </div>
			<input type="hidden" name="username" value="<%=Username %>">
            <!-- Submit and reset buttons -->
            <div class="form-actions">
                <input type="submit" value="Submit" class="btn submit-btn">
                <input type="reset" value="Reset" class="btn reset-btn"><br><br>
                <a href="suggestionDetails?username=<%=Username %>" class="btn submit-btn"> Show my suggestion</a>
            </div>
        </form>
    </div>
</body>
</html>
