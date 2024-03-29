<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Employee</title>
    <style>
        .container {
            width: 50%;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 50px;
        }
        input[type="text"], select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
        }
        input[type="date"], select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 3px;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
        }
        .back-button {
            position: fixed; /* Position the button relative to the browser window */
            top: 20px; /* Set the distance from the top */
            left: 20px; /* Set the distance from the left */
            padding: 10px 20px; /* Set padding to make the button clickable */
            background-color: #007bff; /* Set background color */
            color: #fff; /* Set text color */
            border: none; /* Remove border */
            border-radius: 5px; /* Apply rounded corners */
            cursor: pointer; /* Change cursor to pointer on hover */
        }
        h1 {
            text-align: center;
        }

    </style>
</head>
<body>
<%
    // Process form submission
    String editEmployeeId = request.getParameter("edit_employee_id");

    if (editEmployeeId != null) {
        // Database connection parameters
        String url = "jdbc:postgresql://localhost:5433/postgres";
        String username = "postgres";
        String password = "password";

        // JDBC variables
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.postgresql.Driver");

            // Establish a connection to the database
            conn = DriverManager.getConnection(url, username, password);

            // SQL query to retrieve employee details
            String sql = "SELECT * FROM website.Employee WHERE Employee_ID = ?";

            // Create a PreparedStatement object to execute the SQL query
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(editEmployeeId));

            // Execute the SQL query to retrieve employee details
            rs = pstmt.executeQuery();

            // Check if employee record exists
            if (rs.next()) {
                // Retrieve employee details
                String fullName = rs.getString("Full_Name");
                String address = rs.getString("Address");
                int hotelId = rs.getInt("Hotel_ID");
                String ssnOrSin = rs.getString("SSN_Or_SIN");
%>
<h2>Edit Employee Details</h2>
<form action="#" method="post">
    <input type="hidden" name="edit_employee_id" value="<%=editEmployeeId%>">
    <label for="full_name">Full Name:</label>
    <input type="text" id="full_name" name="full_name" value="<%=fullName%>" required><br>

    <label for="address">Address:</label>
    <input type="text" id="address" name="address" value="<%=address%>" required><br>

    <label for="hotel_id">Hotel ID:</label>
    <input type="text" id="hotel_id" name="hotel_id" value="<%=hotelId%>" required><br>

    <label for="ssn_or_sin">SSN or SIN:</label>
    <input type="text" id="ssn_or_sin" name="ssn_or_sin" value="<%=ssnOrSin%>" required><br>

    <input type="submit" value="Update Employee">
</form>
<%
            } else {
                // Handle case where no employee with given ID is found
                // You can display an appropriate message here
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            // Handle database connection or query errors
        } finally {
            // Close the ResultSet, PreparedStatement, and database connection
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle closing connection errors
            }
        }
    } else {
        // Handle case where employee ID parameter is not provided
    }
%>
</body>
</html>
