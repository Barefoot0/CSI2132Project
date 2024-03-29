<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Hotel</title>
    <!-- Add your CSS styles or external CSS links here -->
</head>
<body>
<%
    // Get the hotel ID from the request parameters
    String editHotelId = request.getParameter("hotel_id");

    if (editHotelId != null) {
        // Database connection parameters
        String url = "jdbc:postgresql://localhost:5432/postgres";
        String username = "your_username";
        String password = "your_password";

        // JDBC variables
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.postgresql.Driver");

            // Establish a connection to the database
            conn = DriverManager.getConnection(url, username, password);

            // SQL query to retrieve hotel details based on ID
            String sql = "SELECT * FROM Hotel WHERE Hotel_ID = ?";

            // Create a PreparedStatement object to execute the SQL query
            pstmt = conn.prepareStatement(sql);

            // Set the parameter for the PreparedStatement
            pstmt.setInt(1, Integer.parseInt(editHotelId));

            // Execute the SQL query to retrieve hotel details
            rs = pstmt.executeQuery();

            // Check if a hotel with the given ID exists
            if (rs.next()) {
                // Retrieve hotel details from the ResultSet
                String hotelName = rs.getString("Hotel_Name");
                int rating = rs.getInt("Rating");
                int numberOfRooms = rs.getInt("Number_Of_Rooms");
                String address = rs.getString("Address");
                String contactEmail = rs.getString("Contact_Email");
                String contactPhoneNumber = rs.getString("Contact_Phone_Number");
                String hotelChainName = rs.getString("Hotel_Chain_Name");
%>
<h2>Edit Hotel</h2>
<form action="#" method="post">
    <input type="hidden" name="edit_hotel_id" value="<%= editHotelId %>">

    <label for="edit_hotel_name">Hotel Name:</label>
    <input type="text" id="edit_hotel_name" name="edit_hotel_name" value="<%= hotelName %>" required><br>

    <!-- Add other input fields for editing hotel details here -->

    <input type="submit" value="Save Changes">
</form>
<%
} else {
%>
<h2>Hotel not found</h2>
<%
    }
} catch (SQLException | ClassNotFoundException e) {
    e.printStackTrace();
%>
<h2>Database error occurred. Please try again later.</h2>
<%
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
%>
<h2>No hotel ID provided</h2>
<%
    }
%>
</body>
</html>
