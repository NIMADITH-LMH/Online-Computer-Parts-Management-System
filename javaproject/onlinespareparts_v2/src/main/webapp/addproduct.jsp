<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
   <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding:0px;
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        .container {
            max-width: 600px;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #28a745; /* Green color for header */
            color: white;
            font-weight: bold;
        }
        td {
            background-color: #f9f9f9; /* Light background for table cells */
        }
        tr:hover td {
            background-color: #e9f5e9; /* Highlight row on hover */
        }
        input[type="text"], input[type="number"], textarea, select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"], input[type="reset"] {
            background-color: #28a745; /* Green color for submit button */
            color: white;
            padding: 12px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.3s;
        }
        input[type="reset"] {
            background-color: #dc3545; /* Red color for reset */
        }
        input[type="submit"]:hover {
            background-color: #218838; /* Darker green on hover */
        }
        input[type="reset"]:hover {
            background-color: #c82333; /* Darker red on hover */
        }
        textarea {
            resize: vertical; /* Allow vertical resizing only */
        }
        @media (max-width: 600px) {
            .container {
                padding: 15px;
            }
        }
    </style>


</head>
<%@ include file="header.jsp" %>

<body>    <div class="container">
        <h1 style="text-align: center;">Add Product</h1>
        <form action="addproduct" method="post" enctype="multipart/form-data">
            <table>
                <tr>
                    <th>Product Name:</th>
                    <td><input type="text" name="pname" required></td>
                </tr>
                <tr>
                    <th>Product Type:</th>
                    <td>
                        <select name="producttype" required>
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
                    </td>
                </tr>
                <tr>
                    <th>Price:</th>
                    <td><input type="text" name="price" required></td>
                </tr>
                <tr>
                    <th>Quantity:</th>
                    <td><input type="number" name="quantity" required></td>
                </tr>
                <tr>
                    <th>Description:</th>
                    <td><textarea name="description" cols="20" rows="3" required></textarea></td>
                </tr>
                <tr>
                    <th>Image:</th>
                    <td><input type="file" name="image" id="image" required></td>

                </tr>
                <tr>
                	<td><input type="text" name="id" value="<%= Username %>" hidden="hidden"></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="Add">
                        <input type="reset" value="Delete">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
















