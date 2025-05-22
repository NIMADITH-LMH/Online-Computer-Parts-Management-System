<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
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
        <h1 class="form-header">Update Product</h1>
        <%
        // Retrieve user attributes from the request
      	 int idproduct = (Integer) request.getAttribute("id");
        String pname = (String) request.getAttribute("pname");
        String producttype = (String) request.getAttribute("producttype");
        String price = (String) request.getAttribute("price");
        String quantity = (String) request.getAttribute("quantity");
        String description = (String) request.getAttribute("description");
        String image = (String) request.getAttribute("image");
        %>

        <form action="UpdateProduct" method="post" enctype="multipart/form-data">
            <div class="text-center">
                <img class="product-image" src="${pageContext.request.contextPath}/image/<%= image %>" alt="Product Image">
            </div>

            <div class="form-group">
                <label for="pname">Product Name:</label>
                <input type="text" class="form-control" name="pname" id="pname" required value="<%= pname %>">
            </div>

            <div class="form-group">
                <label for="producttype">Product Type:</label>
                <select class="form-control" name="producttype" id="producttype" required>
                    <option value="<%= producttype %>" selected><%= producttype %></option>
                    <option value="Monitor">Monitor</option>
                    <option value="Server">Server</option>
                    <option value="Processor">Processor</option>
                    <option value="Motherboard">Motherboard</option>
                    <option value="Memory">Memory</option>
                    <option value="Cooler">Cooler</option>
                    <option value="Power Supply">Power Supply</option>
                    <option value="Graphic Card">Graphic Card</option>
                    <option value="Casing">Casing</option>
                    <option value="Scanner">Scanner</option>
                    <option value="Printers">Printers</option>
                    <option value="Mouse">Mouse</option>
                    <option value="Keyboard">Keyboard</option>
                    <option value="Webcam">Webcam</option>
                    <option value="Drawing Pad">Drawing Pad</option>
                    <option value="Projector">Projector</option>
                    <option value="Speaker">Speaker</option>
                </select>
            </div>

            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="price">Price:</label>
                    <input type="text" class="form-control" name="price" id="price" required value="<%= price %>">
                </div>
                <div class="form-group col-md-6">
                    <label for="quantity">Quantity:</label>
                    <input type="number" class="form-control" name="quantity" id="quantity" required value="<%= quantity %>">
                </div>
            </div>

            <div class="form-group">
                <label for="description">Description:</label>
                <textarea class="form-control" name="description" id="description" cols="30" rows="3" required><%= description %></textarea>
            </div>

            <div class="form-group">
                <label for="image">Product Image:</label>
                <input type="file" class="form-control-file custom-file-input" name="image" id="image" value="<%= image %>">
                <small class="form-text text-muted">Choose a new image if you want to update the product image.</small>
            </div>

            <input type="hidden" name="id" value="<%= idproduct%>">

            <div class="form-group text-center">
                <button type="submit" class="btn btn-submit btn-lg">Update Product</button>
                
            </div>
        </form>
    </div>
</div>


</body>
</html>
