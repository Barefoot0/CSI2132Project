<%@ page import="java.sql.*" %>

<%
    // Check if form data is submitted for creating a room
    String createRoomHotelId = request.getParameter("create_room_hotel_id");
    String createRoomPrice = request.getParameter("create_room_price");
    String createRoomCapacity = request.getParameter("create_room_capacity");
    String createRoomView = request.getParameter("create_room_view");
    String createRoomExtendable = request.getParameter("create_room_extendable");

    if (createRoomHotelId != null && createRoomPrice != null && createRoomCapacity != null &&
            createRoomView != null && createRoomExtendable != null) {
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

            // SQL query to insert room into the database
            String sql = "INSERT INTO website.Room (Hotel_ID, Price, Capacity, View, Extendable) VALUES (?, ?, ?, ?, ?)";

            // Create a PreparedStatement object to execute the SQL query
            pstmt = conn.prepareStatement(sql);

            // Set the parameters for the PreparedStatement
            pstmt.setInt(1, Integer.parseInt(createRoomHotelId));
            pstmt.setInt(2, Integer.parseInt(createRoomPrice));
            pstmt.setInt(3, Integer.parseInt(createRoomCapacity));
            pstmt.setString(4, createRoomView);
            pstmt.setBoolean(5, Boolean.parseBoolean(createRoomExtendable));

            // Execute the SQL query to insert the room into the database
            int rowsAffected = pstmt.executeUpdate();

            // Check if the insertion was successful
            if (rowsAffected > 0) {
                response.sendRedirect("manage_database.jsp");
%>
<h2>Room Created Successfully</h2>
<%
} else {
%>
<h2>Error creating room. Please try again.</h2>
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
