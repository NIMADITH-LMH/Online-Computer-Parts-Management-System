<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add User - Online Spare Parts Store</title>
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
        
        .form-container {
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
        
        .form-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            padding: 40px;
        }
        
        .form-title {
            font-size: 22px;
            font-weight: 600;
            color: #2c3e50;
            margin-top: 0;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        
        .form-row {
            display: flex;
            flex-wrap: wrap;
            margin: 0 -15px;
        }
        
        .form-group {
            flex: 0 0 calc(50% - 30px);
            margin: 0 15px 25px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 15px;
            transition: border-color 0.3s;
        }
        
        .form-control:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        
        .gender-options {
            display: flex;
            gap: 20px;
            margin-top: 10px;
        }
        
        .gender-option {
            display: flex;
            align-items: center;
        }
        
        .gender-option input {
            margin-right: 8px;
        }
        
        .submit-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 12px 30px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.3s;
            width: 100%;
        }
        
        .submit-btn:hover {
            background-color: #c0392b;
        }
        
        .error-message {
            color: #e74c3c;
            font-size: 14px;
            margin-top: 5px;
        }
        
        .success-message {
            color: #27ae60;
            background-color: #e8f5e9;
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .form-footer {
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
        
        .btn {
            padding: 8px 20px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            border: none;
            transition: background-color 0.3s;
        }
        
        .btn-secondary {
            background-color: #95a5a6;
            color: white;
        }
        
        .btn-secondary:hover {
            background-color: #7f8c8d;
        }
        
        .btn-primary {
            background-color: #3498db;
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #2980b9;
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
        
        @media (max-width: 768px) {
            .form-group {
                flex: 0 0 calc(100% - 30px);
            }
            
            .form-card {
                padding: 25px;
            }
            
            .page-title {
                font-size: 24px;
            }
            
            .toast-container {
                right: 10px;
                left: 10px;
            }
            
            .toast {
                min-width: unset;
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <h1 class="page-title">Manage Users</h1>
    
    <div class="form-container">
        <div class="tabs">
            <button class="tab active" onclick="openTab(event, 'customer')">Add Customer</button>
            <button class="tab" onclick="openTab(event, 'seller')">Add Seller</button>
        </div>
        
        <% if(request.getAttribute("success") != null) { %>
            <div class="success-message">
                <%= request.getAttribute("success") %>
            </div>
        <% } %>
        
        <div id="customer" class="tab-content active">
            <div class="form-card">
                <h2 class="form-title">Add New Customer</h2>
                
                <form id="customerForm" action="AdminServlet" method="get" onsubmit="return confirmCustomerSubmit(event)">
                    <input type="hidden" name="action" value="addCustomer">
                    <input type="hidden" name="id" value="user">
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="username">Username*</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="name">Full Name*</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="email">Email Address*</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="phone">Phone Number*</label>
                            <input type="text" class="form-control" id="phone" name="phone" required pattern="[0-9]{10}" title="Please enter a 10-digit phone number">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="address">Address*</label>
                            <input type="text" class="form-control" id="address" name="address" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="dob">Date of Birth*</label>
                            <input type="date" class="form-control" id="dob" name="dob" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Gender*</label>
                            <div class="gender-options">
                                <div class="gender-option">
                                    <input type="radio" id="male" name="gender" value="Male" required>
                                    <label for="male">Male</label>
                                </div>
                                <div class="gender-option">
                                    <input type="radio" id="female" name="gender" value="Female">
                                    <label for="female">Female</label>
                                </div>
                                <div class="gender-option">
                                    <input type="radio" id="other" name="gender" value="Other">
                                    <label for="other">Other</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="password">Password*</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="cpassword">Confirm Password*</label>
                            <input type="password" class="form-control" id="cpassword" name="cpassword" required>
                        </div>
                    </div>
                    
                    <button type="submit" class="submit-btn">Add Customer</button>
                    
                    <% if(request.getAttribute("error") != null) { %>
                        <div class="error-message">
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } %>
                </form>
            </div>
        </div>
        
        <div id="seller" class="tab-content">
            <div class="form-card">
                <h2 class="form-title">Add New Seller</h2>
                
                <form id="sellerForm" action="AdminServlet" method="get" onsubmit="return confirmSellerSubmit(event)">
                    <input type="hidden" name="action" value="addSeller">
                    <input type="hidden" name="id" value="seller">
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="seller-username">Username*</label>
                            <input type="text" class="form-control" id="seller-username" name="username" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="seller-name">Full Name*</label>
                            <input type="text" class="form-control" id="seller-name" name="name" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="seller-email">Email Address*</label>
                            <input type="email" class="form-control" id="seller-email" name="email" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="seller-phone">Phone Number*</label>
                            <input type="text" class="form-control" id="seller-phone" name="phone" required pattern="[0-9]{10}" title="Please enter a 10-digit phone number">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="seller-address">Address*</label>
                            <input type="text" class="form-control" id="seller-address" name="address" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="seller-dob">Date of Birth*</label>
                            <input type="date" class="form-control" id="seller-dob" name="dob" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Gender*</label>
                            <div class="gender-options">
                                <div class="gender-option">
                                    <input type="radio" id="seller-male" name="gender" value="Male" required>
                                    <label for="seller-male">Male</label>
                                </div>
                                <div class="gender-option">
                                    <input type="radio" id="seller-female" name="gender" value="Female">
                                    <label for="seller-female">Female</label>
                                </div>
                                <div class="gender-option">
                                    <input type="radio" id="seller-other" name="gender" value="Other">
                                    <label for="seller-other">Other</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="seller-password">Password*</label>
                            <input type="password" class="form-control" id="seller-password" name="password" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="seller-cpassword">Confirm Password*</label>
                            <input type="password" class="form-control" id="seller-cpassword" name="cpassword" required>
                        </div>
                    </div>
                    
                    <button type="submit" class="submit-btn">Add Seller</button>
                </form>
            </div>
        </div>
        
        <div class="form-footer">
            <p>&copy; <%= Calendar.getInstance().get(Calendar.YEAR) %> Online Spare Parts Store. All rights reserved.</p>
        </div>
    </div>
    
    <!-- Confirmation Modal -->
    <div class="modal-overlay" id="confirmationModal">
        <div class="modal">
            <div class="modal-header">
                <h3 class="modal-title">Confirm Submission</h3>
            </div>
            <div class="modal-body" id="modal-message">
                Are you sure you want to add this user?
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                <button class="btn btn-primary" id="confirmBtn">Confirm</button>
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
        
        // Validate password match
        function validatePasswords(passwordId, confirmPasswordId) {
            const password = document.getElementById(passwordId).value;
            const confirmPassword = document.getElementById(confirmPasswordId).value;
            
            if (password !== confirmPassword) {
                showToast("Error", "Passwords do not match!", "error");
                return false;
            }
            return true;
        }
        
        // Customer form submission
        function confirmCustomerSubmit(event) {
            event.preventDefault();
            
            // Validate passwords match
            if (!validatePasswords('password', 'cpassword')) {
                return false;
            }
            
            const username = document.getElementById('username').value;
            const name = document.getElementById('name').value;
            
            // Set modal content
            document.getElementById('modal-message').innerHTML = 
                `Are you sure you want to add <strong>${name}</strong> (${username}) as a customer?`;
            
            // Set confirm action
            document.getElementById('confirmBtn').onclick = function() {
                document.getElementById('customerForm').submit();
                closeModal();
                showToast("Success", "Adding customer... Please wait.", "success");
            };
            
            // Show modal
            document.getElementById('confirmationModal').style.display = "flex";
            return false;
        }
        
        // Seller form submission
        function confirmSellerSubmit(event) {
            event.preventDefault();
            
            // Validate passwords match
            if (!validatePasswords('seller-password', 'seller-cpassword')) {
                return false;
            }
            
            const username = document.getElementById('seller-username').value;
            const name = document.getElementById('seller-name').value;
            
            // Set modal content
            document.getElementById('modal-message').innerHTML = 
                `Are you sure you want to add <strong>${name}</strong> (${username}) as a seller?`;
            
            // Set confirm action
            document.getElementById('confirmBtn').onclick = function() {
                document.getElementById('sellerForm').submit();
                closeModal();
                showToast("Success", "Adding seller... Please wait.", "success");
            };
            
            // Show modal
            document.getElementById('confirmationModal').style.display = "flex";
            return false;
        }
        
        // Close modal
        function closeModal() {
            document.getElementById('confirmationModal').style.display = "none";
        }
        
        // Close modal if clicked outside
        window.onclick = function(event) {
            if (event.target == document.getElementById('confirmationModal')) {
                closeModal();
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