<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Customer</title>
    <style>
        .container {
            width: 50%;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 50px;
        }
        input[type="text"], input[type="date"] {
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
        .return-button {
            position: fixed; /* Position the button relative to the browser window */
            bottom: 20px; /* Set the distance from the bottom */
            left: 50%; /* Set the button to the center horizontally */
            transform: translateX(-50%); /* Center the button horizontally */
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
<button class="back-button" onclick="window.location.href='manage_database.jsp'">Back</button>
<body>
<%
    // Process form submission
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

            // SQL query to retrieve customer details
            String sql = "SELECT * FROM website.Customer WHERE Customer_ID = ?";

            // Create a PreparedStatement object to execute the SQL query
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(editCustomerId));

            // Execute the SQL query to retrieve customer details
            rs = pstmt.executeQuery();

            // Check if customer record exists
            if (rs.next()) {
                // Retrieve customer details
                int personId = rs.getInt("Person_ID");
                String fullName = rs.getString("Full_Name");
                String address = rs.getString("Address");
                String idType = rs.getString("ID_Type");
                Date registrationDate = rs.getDate("Registration_Date");
%>
<div class="container">
    <h2>Edit Customer Details</h2>
    <form action="#" method="post">
        <input type="hidden" name="edit_customer_id" value="<%=editCustomerId%>">
        <label for="full_name">Full Name:</label>
        <input type="text" id="full_name" name="full_name" value="<%=fullName%>" required><br>

        <label for="address">Address:</label>
        <input type="text" id="address" name="address" value="<%=address%>" required><br>

        <label for="id_type">ID Type:</label>
        <select id="id_type" name="id_type" required>
            <option value="SIN" <%= idType.equals("SIN") ? "selected" : "" %>>SIN</option>
            <option value="SSN" <%= idType.equals("SSN") ? "selected" : "" %>>SSN</option>
            <option value="Driver Licence" <%= idType.equals("Driver Licence") ? "selected" : "" %>>Driver Licence</option>
        </select><br>

        <label for="registration_date">Registration Date:</label>
        <input type="date" id="registration_date" name="registration_date" value="<%=registrationDate.toString()%>" required><br>

        <input type="submit" value="Update Customer">
    </form>
</div>
<%
            } else {
                // Handle case where no customer with given ID is found
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
        // Handle case where customer ID parameter is not provided
    }
%>
<%
    // Process form submission for updating customer details
    String updateCustomerId = request.getParameter("edit_customer_id");
    if (updateCustomerId != null) {
        String fullName = request.getParameter("full_name");
        String address = request.getParameter("address");
        String idType = request.getParameter("id_type");
        String registrationDate = request.getParameter("registration_date");

        // Database connection parameters
        String url = "jdbc:postgresql://localhost:5433/postgres";
        String username = "postgres";
        String password = "password";

        // JDBC variables
        Connection conn = null;
        PreparedStatement pstmt = null;

        if (fullName != null && address != null && idType != null && registrationDate != null) {

            try {
                Class.forName("org.postgresql.Driver");

                // Establish a connection to the database
                conn = DriverManager.getConnection(url, username, password);

                // SQL query to update customer details
                String sql = "UPDATE website.Customer SET Full_Name = ?, Address = ?, ID_Type = ?, Registration_Date = ? WHERE Customer_ID = ?";

                // Create a PreparedStatement object to execute the SQL query
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, fullName);
                pstmt.setString(2, address);
                pstmt.setString(3, idType);
                pstmt.setDate(4, Date.valueOf(registrationDate));
                pstmt.setInt(5, Integer.parseInt(updateCustomerId));

                // Execute the SQL query to update customer details
                int rowsUpdated = pstmt.executeUpdate();

                if (rowsUpdated > 0) {
%>

<h1>Update Successful</h1>
<button class="return-button" onclick="window.location.href='manage_database.jsp'">Return</button>
<%
} else {
%>
<div class="container">
    <h3>Update Failed</h3>
</div>
<%
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                // Handle database connection or query errors
            } finally {
                // Close the PreparedStatement and database connection
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    // Handle closing connection errors
                }
            }
        }
    }
%>
</body>
</html>
