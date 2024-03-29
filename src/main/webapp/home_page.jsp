<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Website Home Pages</title>
    <style>
        body {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 80vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        h1 {
            margin-top: 10vh;
        }

        .form-container {
            text-align: center;
        }

        input[type="submit"] {
            padding: 10px 20px;
            font-size: 18px;
            margin: 5px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #007bff;
        }
    </style>
</head>
<body>
    <h1>Website Home Page</h1>
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
