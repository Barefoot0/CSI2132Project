<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Website Home Page</title>
    <style>
        body {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 80vh;
            margin: 0;
        }

        h1 {
            margin-top: 10vh; /* Adjust this value as needed */
        }

        .form-container {
            text-align: center;
        }

        input[type="submit"] {
            padding: 10px 20px;
            font-size: 18px;
        }
    </style>
</head>
<h1>Website Home Page</h1>
<body>
<div class="form-container">
    <form action="#" method="get">
        <input type="submit" name="manage_database" value="Manage Database">
        <input type="submit" name="use_customer" value="Use as Customer">
        <input type="submit" name="use_employee" value="Use as Employee">
    </form>

    <%-- Redirect based on button clicked --%>
    <%
        String manageDatabase = request.getParameter("manage_database");
        String useCustomer = request.getParameter("use_customer");
        String useEmployee = request.getParameter("use_employee");

        if (manageDatabase != null) {
            response.sendRedirect("manage_database.jsp");
        } else if (useCustomer != null) {
            response.sendRedirect("index.jsp");
        } else if (useEmployee != null) {
            response.sendRedirect("employee_nav.jsp");
        }
    %>
</div>
</body>
</html>
