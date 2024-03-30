<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

<%
    // Check if form data is submitted for creating a hotel
    String createHotelName = request.getParameter("create_hotel_name");
    String createHotelRating = request.getParameter("create_hotel_rating");
    String createHotelRooms = request.getParameter("create_hotel_rooms");
    String createHotelAddress = request.getParameter("create_hotel_address");
    String createHotelEmail = request.getParameter("create_hotel_email");
    String createHotelPhoneNumber = request.getParameter("create_hotel_phone_number");
    String createHotelChain = request.getParameter("create_hotel_chain");

    if (createHotelName != null && createHotelRating != null && createHotelRooms != null &&
            createHotelAddress != null && createHotelEmail != null && createHotelPhoneNumber != null &&
            createHotelChain != null) {
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

            // SQL query to insert hotel into the database
            String sql = "INSERT INTO website.Hotel (Hotel_Chain_Name, Rating, Number_Of_Rooms, Address, " +
                    "Contact_Email, Contact_Phone_Number) VALUES (?, ?, ?, ?, ?, ?)";

            // Create a PreparedStatement object to execute the SQL query
            pstmt = conn.prepareStatement(sql);

            // Set the parameters for the PreparedStatement
            pstmt.setString(1, createHotelChain);
            pstmt.setInt(2, Integer.parseInt(createHotelRating));
            pstmt.setInt(3, Integer.parseInt(createHotelRooms));
            pstmt.setString(4, createHotelAddress);
            pstmt.setString(5, createHotelEmail);
            pstmt.setString(6, createHotelPhoneNumber);

            // Execute the SQL query to insert the hotel into the database
            int rowsAffected = pstmt.executeUpdate();

            // Check if the insertion was successful
            if (rowsAffected > 0) {
                response.sendRedirect("manage_database.jsp");
%>
<h2>Hotel Created Successfully</h2>
<%
} else {
%>
<h2>Error creating hotel. Please try again.</h2>
<%
    }
} catch (SQLException | ClassNotFoundException e) {
    e.printStackTrace();
%>
<h2>Database error occurred. Please try again later.</h2>
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
