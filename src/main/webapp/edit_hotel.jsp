<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Hotel</title>
    <style>
        .container {
            width: 50%;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 50px;
        }
        input[type="text"], input[type="number"], input[type="email"], input[type="tel"] {
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
    String editHotelId = request.getParameter("hotel_id_h");

    if (editHotelId != null) {
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

            // SQL query to retrieve hotel details
            String sql = "SELECT * FROM website.Hotel WHERE Hotel_ID = ?";

            // Create a PreparedStatement object to execute the SQL query
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(editHotelId));

            // Execute the SQL query to retrieve hotel details
            rs = pstmt.executeQuery();

            // Check if hotel record exists
            if (rs.next()) {
                // Retrieve hotel details
                int rating = rs.getInt("Rating");
                int numberOfRooms = rs.getInt("Number_Of_Rooms");
                String address = rs.getString("Address");
                String contactEmail = rs.getString("Contact_Email");
                String contactPhoneNumber = rs.getString("Contact_Phone_Number");
                int managerId = rs.getInt("Manager_ID");
                String hotelChainName = rs.getString("Hotel_Chain_Name");
%>
<div class="container">
    <h2>Edit Hotel Details</h2>
    <form action="#" method="post">
        <input type="hidden" name="edit_hotel_id" value="<%=editHotelId%>">
        <label for="rating">Rating:</label>
        <input type="number" id="rating" name="rating" value="<%=rating%>" required min="0"><br>

        <label for="numberOfRooms">Number of Rooms:</label>
        <input type="number" id="numberOfRooms" name="numberOfRooms" value="<%=numberOfRooms%>" required min="1"><br>

        <label for="address">Address:</label>
        <input type="text" id="address" name="address" value="<%=address%>" required><br>

        <label for="contactEmail">Contact Email:</label>
        <input type="email" id="contactEmail" name="contactEmail" value="<%=contactEmail%>" required><br>

        <label for="contactPhoneNumber">Contact Phone Number:</label>
        <input type="tel" id="contactPhoneNumber" name="contactPhoneNumber" value="<%=contactPhoneNumber%>" required><br>

        <label for="managerId">Manager ID:</label>
        <input type="number" id="managerId" name="managerId" value="<%=managerId%>" required min="1"><br>

        <label for="hotelChainName">Hotel Chain Name:</label>
        <input type="text" id="hotelChainName" name="hotelChainName" value="<%=hotelChainName%>" required><br>

        <input type="submit" value="Update Hotel">
    </form>
</div>
<%
            } else {
                // Handle case where no hotel with given ID is found
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
        // Handle case where hotel ID parameter is not provided
    }
%>
<%
    // Process form submission for updating hotel details
    String updateHotelId = request.getParameter("edit_hotel_id");
    if (updateHotelId != null) {
        String rating = request.getParameter("rating");
        String numberOfRooms = request.getParameter("numberOfRooms");
        String address = request.getParameter("address");
        String contactEmail = request.getParameter("contactEmail");
        String contactPhoneNumber = request.getParameter("contactPhoneNumber");
        String managerId = request.getParameter("managerId");
        String hotelChainName = request.getParameter("hotelChainName");

        // Database connection parameters
        String url = "jdbc:postgresql://localhost:5433/postgres";
        String username = "postgres";
        String password = "password";

        // JDBC variables
        Connection conn = null;
        PreparedStatement pstmt = null;

        if (rating != null && numberOfRooms != null && address != null && contactEmail != null && contactPhoneNumber != null && managerId != null && hotelChainName != null){

            try {
                Class.forName("org.postgresql.Driver");

                // Establish a connection to the database
                conn = DriverManager.getConnection(url, username, password);

                // SQL query to update hotel details
                String sql = "UPDATE website.Hotel SET Rating = ?, Number_Of_Rooms = ?, Address = ?, Contact_Email = ?, Contact_Phone_Number = ?, Manager_ID = ?, Hotel_Chain_Name = ? WHERE Hotel_ID = ?";

                // Create a PreparedStatement object to execute the SQL query
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(rating));
                pstmt.setInt(2, Integer.parseInt(numberOfRooms));
                pstmt.setString(3, address);
                pstmt.setString(4, contactEmail);
                pstmt.setString(5, contactPhoneNumber);
                pstmt.setInt(6, Integer.parseInt(managerId));
                pstmt.setString(7, hotelChainName);
                pstmt.setInt(8, Integer.parseInt(updateHotelId));

                // Execute the SQL query to update hotel details
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
