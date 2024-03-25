<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Database</title>
</head>
<body>
<h1>Edit Database</h1>

<form action="#" method="post">
    <label for="selectOption">Select Option:</label>
    <select id="selectOption" name="selectOption">
        <option value="" selected disabled>Select an option</option>
        <option value="employee">Employee</option>
        <option value="customer">Customer</option>
        <option value="hotel">Hotel</option>
        <option value="room">Room</option>
    </select>

    <label for="action">Select Action:</label>
    <select id="action" name="action">
        <option value="" selected disabled>Select an action</option>
        <option value="create">Create</option>
        <option value="edit">Edit</option>
        <option value="delete">Delete</option>
    </select>

    <input type="submit" value="Submit">
</form>

<%
    // Process form submission
    String selectedOption = request.getParameter("selectOption");
    String selectedAction = request.getParameter("action");
    if (selectedOption != null && selectedAction != null) {
        if (selectedOption.equals("employee")) {
            if (selectedAction.equals("create")) {
%>
<div>
    <!-- Form for creating an employee -->
    <h2>Create Employee</h2>
    <form action="#" method="post">
        <label for="full_name">Full Name:</label>
        <input type="text" id="full_name" name="full_name"><br>

        <label for="address">Address:</label>
        <input type="text" id="address" name="address"><br>

        <label for="hotel_id">Hotel ID:</label>
        <input type="text" id="hotel_id" name="hotel_id"><br>

        <label for="ssn_or_sin">SSN or SIN:</label>
        <input type="text" id="ssn_or_sin" name="ssn_or_sin"><br>

        <input type="submit" value="Create Employee">
    </form>

    <%
        // Check if form data is submitted for creating an employee
        String fullName = request.getParameter("full_name");
        String address = request.getParameter("address");
        String hotelId = request.getParameter("hotel_id");
        String ssnOrSin = request.getParameter("ssn_or_sin");

        if (fullName != null && address != null && hotelId != null && ssnOrSin != null) {
            // Database connection parameters
            String url = "jdbc:postgresql://localhost:5433/postgres";
            String username = "postgres";
            String password = "password";

            // JDBC variables
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {

                Class.forName("org.postgresql.Driver");

                // Establish a connection to the database
                conn = DriverManager.getConnection(url, username, password);

                // SQL query to insert an employee into the database
                String sql = "INSERT INTO website.Employee (Full_Name, Address, Hotel_ID, SSN_Or_SIN) VALUES (?, ?, ?, ?)";

                // Create a PreparedStatement object to execute the SQL query
                pstmt = conn.prepareStatement(sql);

                // Set the parameters for the PreparedStatement
                pstmt.setString(1, fullName);
                pstmt.setString(2, address);
                pstmt.setString(3, hotelId);
                pstmt.setString(4, ssnOrSin);

                // Execute the SQL query to insert the employee into the database
                int rowsAffected = pstmt.executeUpdate();

                // Check if the insertion was successful
                if (rowsAffected > 0) {
    %>
    <p>Employee created successfully!</p>
    <%
    } else {
    %>
    <p>Error creating employee. Please try again.</p>
    <%
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    %>
    <p>Database error occurred. Please try again later.</p>
    <%
            } finally {
                // Close the PreparedStatement and database connection
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</div>
<%
} else if (selectedAction.equals("edit")) {
%>
<div>
    <!-- Form for editing an employee -->
    <h2>Edit Employee</h2>
    <!-- Add form fields for editing an employee here -->
</div>
<%
} else if (selectedAction.equals("delete")) {
%>
<div>
    <!-- Form for deleting an employee -->
    <h2>Delete Employee</h2>
    <!-- Add form fields for deleting an employee here -->
</div>
<%
            }
        } else if (selectedOption.equals("customer")) {
            switch (selectedAction) {
                case "create":
                    // create
                    break;
                case "edit":
                    // edit
                    break;
                case "delete":
                    // delete
                    break;


            }
            // Similar logic for customer
        } else if (selectedOption.equals("hotel")) {
            // Similar logic for hotel
        } else if (selectedOption.equals("room")) {
            // Similar logic for room
        }
    }
%>
</body>
</html>
