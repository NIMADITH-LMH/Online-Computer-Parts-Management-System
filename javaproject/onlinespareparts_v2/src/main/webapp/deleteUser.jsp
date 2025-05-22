<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Admin.AdminServlet.User" %>
<%@ page import="Admin.AdminServlet.Seller" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete User - Online Spare Parts Store</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f7f9;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .page-title {
            text-align: center;
            font-size: 28px;
            font-weight: 600;
            color: #2c3e50;
            margin: 30px 0;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto 60px;
            padding: 0 20px;
        }
        
        .tabs {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }
        
        .tab {
            padding: 12px 30px;
            background-color: #e6e6e6;
            border: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            transition: all 0.3s ease;
            color: #555;
        }
        
        .tab:first-child {
            border-top-left-radius: 8px;
            border-bottom-left-radius: 8px;
        }
        
        .tab:last-child {
            border-top-right-radius: 8px;
            border-bottom-right-radius: 8px;
        }
        
        .tab.active {
            background-color: #2c3e50;
            color: white;
        }
        
        .tab-content {
            display: none;
        }
        
        .tab-content.active {
            display: block;
            animation: fadeIn 0.6s;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            padding: 30px;
            margin-bottom: 20px;
        }
        
        .card-title {
            font-size: 22px;
            font-weight: 600;
            color: #2c3e50;
            margin-top: 0;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        
        .search-container {
            display: flex;
            margin-bottom: 30px;
        }
        
        .search-input {
            flex: 1;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 6px 0 0 6px;
            font-size: 15px;
        }
        
        .search-btn {
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 0 6px 6px 0;
            padding: 0 20px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .search-btn:hover {
            background-color: #2980b9;
        }
        
        .table-container {
            overflow-x: auto;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th {
            background-color: #f9f9f9;
            padding: 12px 15px;
            text-align: left;
            font-weight: 600;
            color: #555;
            border-bottom: 2px solid #eee;
        }
        
        td {
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
        }
        
        tr:hover {
            background-color: #f5f5f5;
        }
        
        .btn {
            padding: 8px 15px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            border: none;
            transition: all 0.3s;
        }
        
        .btn-danger {
            background-color: #e74c3c;
            color: white;
        }
        
        .btn-danger:hover {
            background-color: #c0392b;
        }
        
        .no-results {
            text-align: center;
            padding: 30px;
            color: #7f8c8d;
            font-size: 16px;
        }
        
        .footer {
            margin-top: 30px;
            text-align: center;
            color: #7f8c8d;
            font-size: 14px;
        }
        
        /* Modal styles */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        
        .modal {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            width: 400px;
            max-width: 90%;
            animation: modalFadeIn 0.3s;
        }
        
        @keyframes modalFadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .modal-header {
            padding: 20px;
            border-bottom: 1px solid #eee;
        }
        
        .modal-title {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
            color: #2c3e50;
        }
        
        .modal-body {
            padding: 20px;
            font-size: 15px;
            line-height: 1.6;
            color: #555;
        }
        
        .modal-footer {
            padding: 15px 20px;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        
        .btn-secondary {
            background-color: #95a5a6;
            color: white;
        }
        
        .btn-secondary:hover {
            background-color: #7f8c8d;
        }
        
        /* Toast notification */
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1500;
        }
        
        .toast {
            min-width: 250px;
            margin-bottom: 10px;
            background-color: white;
            border-radius: 4px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            overflow: hidden;
            animation: toastFadeIn 0.3s;
            display: flex;
            align-items: center;
        }
        
        @keyframes toastFadeIn {
            from { opacity: 0; transform: translateX(50px); }
            to { opacity: 1; transform: translateX(0); }
        }
        
        .toast.success {
            border-left: 4px solid #2ecc71;
        }
        
        .toast.error {
            border-left: 4px solid #e74c3c;
        }
        
        .toast-icon {
            width: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }
        
        .toast-success-icon {
            color: #2ecc71;
        }
        
        .toast-error-icon {
            color: #e74c3c;
        }
        
        .toast-content {
            padding: 15px 10px;
            flex: 1;
        }
        
        .toast-title {
            font-weight: 600;
            margin-bottom: 5px;
            color: #333;
        }
        
        .toast-message {
            font-size: 14px;
            color: #666;
        }
        
        .toast-close {
            padding: 0 15px;
            font-size: 18px;
            color: #999;
            cursor: pointer;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            gap: 5px;
        }
        
        .page-link {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            color: #3498db;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .page-link:hover {
            background-color: #f5f5f5;
        }
        
        .page-link.active {
            background-color: #3498db;
            color: white;
            border-color: #3498db;
        }
        
        @media (max-width: 768px) {
            .card {
                padding: 20px;
            }
            
            .page-title {
                font-size: 24px;
            }
            
            td, th {
                padding: 10px;
            }
            
            .search-container {
                flex-direction: column;
            }
            
            .search-input {
                border-radius: 6px;
                margin-bottom: 10px;
            }
            
            .search-btn {
                border-radius: 6px;
                width: 100%;
                padding: 12px;
            }
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <h1 class="page-title">Manage Users</h1>
    
    <div class="container">
        <div class="tabs">
            <button class="tab active" onclick="openTab(event, 'customers')">Delete Customer</button>
            <button class="tab" onclick="openTab(event, 'sellers')">Delete Seller</button>
        </div>
        
        <div id="customers" class="tab-content active">
            <div class="card">
                <h2 class="card-title">Delete Customer</h2>
                
                <div class="search-container">
                    <input type="text" id="customerSearch" class="search-input" placeholder="Search by username, name, or email...">
                    <button class="search-btn" onclick="searchCustomers()">Search</button>
                </div>
                
                <div class="table-container">
                    <table id="customerTable">
                        <thead>
                            <tr>
                                <th>Username</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="customerTableBody">
                            <!-- Customer data will be populated here -->
                            <% 
                            List<User> customers = (List<User>) request.getAttribute("customers");
                            if (customers != null && !customers.isEmpty()) {
                                for (User customer : customers) {
                            %>
                                <tr>
                                    <td><%= customer.getUsername() %></td>
                                    <td><%= customer.getName() %></td>
                                    <td><%= customer.getEmail() %></td>
                                    <td><%= customer.getPhone() %></td>
                                    <td>
                                        <button class="btn btn-danger" onclick="confirmDelete('customer', '<%= customer.getUsername() %>', '<%= customer.getName() %>')">Delete</button>
                                    </td>
                                </tr>
                            <% 
                                }
                            } else {
                            %>
                                <tr>
                                    <td colspan="5">
                                        <div class="no-results">No customers found. Use the search bar to find customers.</div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                
                <div class="pagination" id="customerPagination">
                    <!-- Pagination will be added here -->
                </div>
            </div>
        </div>
        
        <div id="sellers" class="tab-content">
            <div class="card">
                <h2 class="card-title">Delete Seller</h2>
                
                <div class="search-container">
                    <input type="text" id="sellerSearch" class="search-input" placeholder="Search by username, name, or email...">
                    <button class="search-btn" onclick="searchSellers()">Search</button>
                </div>
                
                <div class="table-container">
                    <table id="sellerTable">
                        <thead>
                            <tr>
                                <th>Username</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="sellerTableBody">
                            <!-- Seller data will be populated here -->
                            <% 
                            List<Seller> sellers = (List<Seller>) request.getAttribute("sellers");
                            if (sellers != null && !sellers.isEmpty()) {
                                for (Seller seller : sellers) {
                            %>
                                <tr>
                                    <td><%= seller.getUsername() %></td>
                                    <td><%= seller.getName() %></td>
                                    <td><%= seller.getEmail() %></td>
                                    <td><%= seller.getPhone() %></td>
                                    <td>
                                        <button class="btn btn-danger" onclick="confirmDelete('seller', '<%= seller.getUsername() %>', '<%= seller.getName() %>')">Delete</button>
                                    </td>
                                </tr>
                            <% 
                                }
                            } else {
                            %>
                                <tr>
                                    <td colspan="5">
                                        <div class="no-results">No sellers found. Use the search bar to find sellers.</div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                
                <div class="pagination" id="sellerPagination">
                    <!-- Pagination will be added here -->
                </div>
            </div>
        </div>
        
        <div class="footer">
            <p>&copy; <%= Calendar.getInstance().get(Calendar.YEAR) %> Online Spare Parts Store. All rights reserved.</p>
        </div>
    </div>
    
    <!-- Delete Confirmation Modal -->
    <div class="modal-overlay" id="deleteModal">
        <div class="modal">
            <div class="modal-header">
                <h3 class="modal-title">Confirm Deletion</h3>
            </div>
            <div class="modal-body" id="delete-modal-message">
                Are you sure you want to delete this user?
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="closeModal('deleteModal')">Cancel</button>
                <button class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
            </div>
        </div>
    </div>
    
    <!-- Toast notifications container -->
    <div class="toast-container" id="toastContainer"></div>
    
    <script>
        // Tab switching
        function openTab(evt, tabName) {
            // Hide all tab content
            var tabContent = document.getElementsByClassName("tab-content");
            for (var i = 0; i < tabContent.length; i++) {
                tabContent[i].classList.remove("active");
            }
            
            // Remove active class from all tabs
            var tabs = document.getElementsByClassName("tab");
            for (var i = 0; i < tabs.length; i++) {
                tabs[i].classList.remove("active");
            }
            
            // Show the selected tab content and add active class to the selected tab
            document.getElementById(tabName).classList.add("active");
            evt.currentTarget.classList.add("active");
        }
        
        // Filter table based on search input
        function filterTable(inputId, tableId) {
            var input = document.getElementById(inputId);
            var filter = input.value.toUpperCase();
            var table = document.getElementById(tableId);
            var tr = table.getElementsByTagName("tr");
            var noResults = true;
            
            for (var i = 1; i < tr.length; i++) { // Start from 1 to skip header
                var td = tr[i].getElementsByTagName("td");
                var match = false;
                
                for (var j = 0; j < 3; j++) { // Check first 3 columns (username, name, email)
                    if (td[j]) {
                        var txtValue = td[j].textContent || td[j].innerText;
                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                            match = true;
                            break;
                        }
                    }
                }
                
                if (match) {
                    tr[i].style.display = "";
                    noResults = false;
                } else {
                    tr[i].style.display = "none";
                }
            }
            
            // Show no results message if needed
            if (noResults && tr.length > 1) {
                tr[1].style.display = "";
                tr[1].innerHTML = '<td colspan="5"><div class="no-results">No matching users found</div></td>';
            }
        }
        
        // Search functions
        function searchCustomers() {
            filterTable("customerSearch", "customerTable");
        }
        
        function searchSellers() {
            filterTable("sellerSearch", "sellerTable");
        }
        
        // Confirm deletion
        function confirmDelete(userType, username, name) {
            document.getElementById('delete-modal-message').innerHTML = 
                `Are you sure you want to delete <strong>${name}</strong> (${username}) from the system?<br>This action cannot be undone.`;
            
            document.getElementById('confirmDeleteBtn').onclick = function() {
                // Submit deletion request
                window.location.href = `AdminServlet?action=deleteUser&userType=${userType}&username=${username}`;
                
                // Show toast notification
                showToast("Success", "Deleting user... Please wait.", "success");
                
                // Close modal
                closeModal('deleteModal');
            };
            
            // Show modal
            document.getElementById('deleteModal').style.display = "flex";
        }
        
        // Close modal
        function closeModal(modalId) {
            document.getElementById(modalId).style.display = "none";
        }
        
        // Close modal if clicked outside
        window.onclick = function(event) {
            if (event.target.classList.contains('modal-overlay')) {
                event.target.style.display = "none";
            }
        }
        
        // Show toast notification
        function showToast(title, message, type) {
            const toastContainer = document.getElementById('toastContainer');
            
            // Create toast element
            const toast = document.createElement('div');
            toast.className = `toast ${type}`;
            
            // Create toast content
            const icon = type === 'success' ? '✓' : '!';
            const toastHTML = `
                <div class="toast-icon">
                    <span class="toast-${type}-icon">${icon}</span>
                </div>
                <div class="toast-content">
                    <div class="toast-title">${title}</div>
                    <div class="toast-message">${message}</div>
                </div>
                <div class="toast-close" onclick="this.parentElement.remove()">×</div>
            `;
            
            toast.innerHTML = toastHTML;
            toastContainer.appendChild(toast);
            
            // Auto remove after 5 seconds
            setTimeout(() => {
                toast.remove();
            }, 5000);
        }
        
        // Show toast if URL has success parameter
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const success = urlParams.get('success');
            const error = urlParams.get('error');
            
            if (success) {
                showToast("Success", decodeURIComponent(success), "success");
            }
            
            if (error) {
                showToast("Error", decodeURIComponent(error), "error");
            }
        }
    </script>
</body>
</html> 