<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Suggestion</title>
    <!-- Bootstrap CSS for styling -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .form-container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #f8f9fa;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .product-image {
            width: 100%;
            height: auto;
            max-width: 200px;
            margin-bottom: 15px;
        }
        .custom-file-input {
            cursor: pointer;
        }
        .btn-submit {
            background-color: #007bff;
            color: white;
        }
        .btn-reset {
            background-color: #dc3545;
            color: white;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
    <div class="form-container">
        <h1 class="form-header">Update Suggestion</h1>
        <%
        // Retrieve user attributes from the request
      	 int idproduct = (Integer) request.getAttribute("suggestionid");
        String suggestiontype = (String) request.getAttribute("suggestiontype");
        String feedback = (String) request.getAttribute("feedback");
        String image = (String) request.getAttribute("image");
        String email = (String) request.getAttribute("email");
        String username = (String) request.getAttribute("username");
        
        %>

        <form action="UpdateSuggestion" method="post" >
            <div class="text-center">
                <img class="product-image" src="${pageContext.request.contextPath}/feedback/<%= image %>" alt="Product Image">
            </div>

            <div class="form-group">
                <label for="pname">Suggestion Type </label>
                 <select id="suggestionType" name="suggestionType" required >
                    <option value="report_bug">Report a bug</option>
                    <option value="feedback">Provide feedback</option>
                    <option value="suggestion">Make a suggestion</option>
                </select>
            </div>

            <div class="form-group">
                <label for="producttype">Feedback</label>
               <textarea id="feedback" name="feedback" rows="5" cols="20" required><%= feedback %></textarea>
            </div>

            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="price">Email:</label>
                    <input type="text" class="form-control" name="price" id="price"  value="<%= email %>" disabled>
                </div>
                <div class="form-group col-md-6">
                    <label for="quantity">Username:</label>
                    <input type="text" class="form-control" name="username" id="quantity"  value="<%= Username %>" disabled>
                </div>
            </div>

            

           

            <input type="hidden" name="id" value="<%= idproduct%>">

            <div class="form-group text-center">
                <button type="submit" class="btn btn-submit btn-lg">Update Suggestion</button>
                
            </div>
        </form>
    </div>
</div>


</body>
</html>
