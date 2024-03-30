<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Database</title>
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
        input[type="number"], select {
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
            /* margin: 0 auto; */
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
<div class="container">
<h1>Edit Database</h1>
<button class="back-button" onclick="window.location.href='home_page'">Back</button>
<form action="#" method="post">
    <div class="input-wrapper"?>
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
    </div>
</form>


<%
    String selectedOption = request.getParameter("selectOption");
    String selectedAction = request.getParameter("action");
    if (selectedOption != null && selectedAction != null) {
        if (selectedOption.equals("employee")) {
            if (selectedAction.equals("create")) {
%>
    <div class="container">
        <!-- Form for creating an employee -->
        <h2>Create Employee</h2>
        <form action="create_employee.jsp" method="post">
            <label for="full_name">Full Name:</label>
            <input type="text" id="full_name" name="full_name"><br>

            <label for="address">Address:</label>
            <input type="text" id="address" name="address"><br>

            <label for="hotel_id">Hotel ID:</label>
            <input type="number" id="hotel_id" name="hotel_id"><br>

            <label for="ssn_or_sin">SSN or SIN:</label>
            <input type="text" id="ssn_or_sin" name="ssn_or_sin"><br>

            <input type="submit" value="Create Employee">
        </form>
    </div>
<%
} else if (selectedAction.equals("edit")) {
%>
<div class="container">
    <!-- Form for editing an employee -->
    <h2>Edit Employee</h2>
    <form action="edit_employee.jsp" method="post">
        <label for="edit_employee_id">Employee ID:</label>
        <input type="text" id="edit_employee_id" name="edit_employee_id" required><br>

        <%
            // Check if form data is submitted for editing an employee
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
                        String fullName = rs.getString("Full_Name");
                        String address = rs.getString("Address");
                        int hotelId = rs.getInt("Hotel_ID");
                        String ssnOrSin = rs.getString("SSN_Or_SIN");
        %>
        <label for="edited_full_name">Full Name:</label>
        <input type="text" id="edited_full_name" name="edited_full_name" value="<%=fullName%>" required><br>

        <label for="edited_address">Address:</label>
        <input type="text" id="edited_address" name="edited_address" value="<%=address%>" required><br>

        <label for="edited_hotel_id">Hotel ID:</label>
        <input type="text" id="edited_hotel_id" name="edited_hotel_id" value="<%=hotelId%>" required><br>

        <label for="edited_ssn_or_sin">SSN or SIN:</label>
        <input type="text" id="edited_ssn_or_sin" name="edited_ssn_or_sin" value="<%=ssnOrSin%>" required><br>

        <%
        } else {
        %>
        <p>No employee found with ID <%=editEmployeeId%>.</p>
        <%
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        %>
        <p>Database error occurred. Please try again later.</p>
        <%
                } finally {
                    // Close the ResultSet, PreparedStatement, and database connection
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
        <input type="submit" value="Update Employee">
    </form>
</div>
<%
} else
if (selectedAction.equals("delete")) {
%>
    <div class="container">
        <!-- Form for deleting an employee -->
        <h2>Delete Employee</h2>
        <!-- Add form fields for deleting an employee here -->
        <form action="delete_employee.jsp" method="post">
            <label for="delete_employee_id">Employee ID:</label>
            <input type="text" id="delete_employee_id" name="delete_employee_id" required><br>

            <input type="submit" value="Delete Employee">
        </form>
    </div>
        <%
}

    } else if (selectedOption.equals("customer")) {
                    if (selectedAction.equals("create")) {
%>
    <div class="container">
        <!-- Form for creating a customer -->
        <h2>Create Customer</h2>
        <form action="create_customer.jsp" method="post">
            <label for="full_name_c">Full Name:</label>
            <input type="text" id="full_name_c" name="full_name_c"><br>

            <label for="address_c">Address:</label>
            <input type="text" id="address_c" name="address_c"><br>

            <select name="id_type" id="id_type">
                <option value="SIN">SIN</option>
                <option value="SSN">SSN</option>
                <option value="Driver's License">Driver's License</option>
            </select>

            <label for="date_input">Date:</label>
            <input type="date" id="date_input" name="date_input">

            <input type="submit" value="Create Customer">
        </form>
    </div>
        <%
} else if (selectedAction.equals("edit")) {
%>
<div class="container">
    <!-- Form for editing an employee -->
    <h2>Edit Customer</h2>
    <form action="edit_customer.jsp" method="post">
        <label for="edit_customer_id">Employee ID:</label>
        <input type="text" id="edit_customer_id" name="edit_customer_id" required><br>

        <%
            // Check if form data is submitted for editing an employee
            String editCustomerId = request.getParameter("edit_customer_id");
            if (editCustomerId != null) {
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
                    String sql = "SELECT * FROM website.customer WHERE customer_id = ?";

                    // Create a PreparedStatement object to execute the SQL query
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, Integer.parseInt(editCustomerId));

                    // Execute the SQL query to retrieve employee details
                    rs = pstmt.executeQuery();

                    // Check if employee record exists
                    if (rs.next()) {
                        String fullName = rs.getString("Full_Name");
                        String address = rs.getString("Address");
                        String id_type = rs.getString("id_type");
                        String date = rs.getString("");
        %>
        <label for="edited_full_name">Full Name:</label>
        <input type="text" id="edited_full_name" name="edited_full_name" value="<%=fullName%>" required><br>

        <label for="edited_address">Address:</label>
        <input type="text" id="edited_address" name="edited_address" value="<%=address%>" required><br>

        <label for="edited_hotel_id">Hotel ID:</label>
        <input type="text" id="edited_hotel_id" name="edited_hotel_id" value="<%=id_type%>" required><br>

        <label for="edited_ssn_or_sin">SSN or SIN:</label>
        <input type="text" id="edited_ssn_or_sin" name="edited_ssn_or_sin" value="<%=date%>" required><br>

        <%
        } else {
        %>
        <p>No employee found with ID <%=editCustomerId%>.</p>
        <%
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        %>
        <p>Database error occurred. Please try again later.</p>
        <%
                } finally {
                    // Close the ResultSet, PreparedStatement, and database connection
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
        <input type="submit" value="Update Employee">
    </form>
</div>
<%
} else if (selectedAction.equals("delete")) {
%>
    <div class="container">
        <!-- Form for deleting a customer -->
        <h2>Delete Customer</h2>
        <!-- Add form fields for deleting a customer here -->
        <form action="delete_customer.jsp" method="post">
            <label for="delete_customer_id">Customer ID:</label>
            <input type="text" id="delete_customer_id" name="delete_customer_id" required><br>

            <input type="submit" value="Delete Customer">
        </form>
    </div>
<%
}
        } else if (selectedOption.equals("hotel")) {
if (selectedAction.equals("create")) {
%>
    <div class="container">
        <!-- Form for creating a hotel -->
        <h2>Create Hotel</h2>
        <form action="create_hotel.jsp" method="post">
            <label for="create_hotel_name">Hotel Name:</label>
            <input type="text" id="create_hotel_name" name="create_hotel_name" required><br>

            <label for="create_hotel_rating">Rating:</label>
            <input type="number" id="create_hotel_rating" name="create_hotel_rating" required min="1"><br>

            <label for="create_hotel_rooms">Number of Rooms:</label>
            <input type="number" id="create_hotel_rooms" name="create_hotel_rooms" required min="1"><br>

            <label for="create_hotel_address">Address:</label>
            <input type="text" id="create_hotel_address" name="create_hotel_address" required><br>

            <label for="create_hotel_email">Contact Email:</label>
            <input type="email" id="create_hotel_email" name="create_hotel_email" required><br>

            <label for="create_hotel_phone_number">Contact Phone Number:</label>
            <input type="tel" id="create_hotel_phone_number" name="create_hotel_phone_number" required><br>

            <label for="create_hotel_chain">Hotel Chain Name:</label>
            <input type="text" id="create_hotel_chain" name="create_hotel_chain" required><br>

            <input type="submit" value="Create Hotel">
        </form>
    </div>
        <%
}
    // Process form submission for editing a hotel
                    if (selectedAction.equals("edit")) {
%>
<div class="container">
<form action="edit_hotel.jsp" method="get">
    <label for="hotel_id_h">Hotel ID:</label>
    <input type="text" id="hotel_id_h" name="hotel_id_h" required><br>
    <input type="submit" value="Edit Hotel">
</form>
</div>
<%
                        // Handle hotel editing
                        // Code for editing a hotel goes here
                    }

                    // Process form submission for deleting a hotel
                    if (selectedAction.equals("delete")) {
%>
    <div class="container">
        <!-- Form for deleting a hotel -->
        <h2>Delete Hotel</h2>
        <!-- Add form fields for deleting a hotel here -->
        <form action="delete_hotel.jsp" method="post">
            <label for="delete_hotel_id">Hotel ID:</label>
            <input type="text" id="delete_hotel_id" name="delete_hotel_id" required><br>

            <input type="submit" value="Delete Hotel">
        </form>
    </div>
        <%
}
        } else if (selectedOption.equals("room")) {
    if (selectedAction.equals("create")) {
%>
    <div class="container">
        <!-- Form for creating a room -->
        <h2>Create Room</h2>
        <form action="create_room.jsp" method="post">
            <label for="create_room_hotel_id">Hotel ID:</label>
            <input type="text" id="create_room_hotel_id" name="create_room_hotel_id" required><br>

            <label for="create_room_price">Price:</label>
            <input type="number" id="create_room_price" name="create_room_price" required min="0"><br>

            <label for="create_room_capacity">Capacity:</label>
            <input type="number" id="create_room_capacity" name="create_room_capacity" required min="1"><br>

            <label for="create_room_view">View:</label>
            <select id="create_room_view" name="create_room_view" required>
                <option value=""></option>
                <option value="Sea">Sea</option>
                <option value="Mountain">Mountain</option>
            </select><br>

            <label for="create_room_extendable">Extendable:</label>
            <select id="create_room_extendable" name="create_room_extendable" required>
                <option value="true">Yes</option>
                <option value="false">No</option>
            </select><br>

            <input type="submit" value="Create Room">
        </form>
    </div>
        <%
}
        else if (selectedAction.equals("edit")){
%>
    <div class=container>
        <form action="edit_room.jsp" method="get">
            <label for="edit_room_id">Room ID:</label>
            <input type="text" id="edit_room_id" name="edit_room_id" required><br>
            <input type="submit" value="Retrieve Room Details">
        </form>
    </div>
        <%
        }else if (selectedAction.equals("delete")) {
            %>
    <div class="container">
        <h2>Delete Room</h2>
        <form action="delete_room.jsp" method="post">
            <label for="delete_room_id">Room ID:</label>
            <input type="text" id="delete_room_id" name="delete_room_id" required><br>

            <input type="submit" value="Delete Room">
        </form>
    </div>
        <%
        }
        }
        }
        %>
</body>
</html>