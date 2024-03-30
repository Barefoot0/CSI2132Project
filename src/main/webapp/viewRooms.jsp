<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>View Rooms</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h2 {
            color: #333;
            font-size: 24px;
        }
        .room-container {
            margin-bottom: 30px; /* Adjust the margin-bottom as needed */
        }
        .room-info {
            font-size: 18px;
        }
        .room-links {
            margin-top: 10px; /* Add margin-top to create space between room info and links */
        }
        a {
            color: #007bff;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h2>Available Rooms</h2>
    
    <% 
    String customerName = request.getParameter("customerName");
    String hotelChainName = request.getParameter("hotelName");
    String employeeId = request.getParameter("employeeId");

    
    // Establish database connection
    String url = "jdbc:postgresql://localhost:5432/postgres";
    String username = "martinpatrouchev";
    String password = "1234";
    Connection connection = null;
    PreparedStatement roomStatement = null;
    ResultSet roomResultSet = null;
    
    try {
        Class.forName("org.postgresql.Driver");
        connection = DriverManager.getConnection(url, username, password);

        
        // Query to retrieve rooms and amenities for the specified hotel chain
        String roomQuery = "SELECT r.Room_ID, r.Price, r.Capacity, h.Address, a.Amenity, r.view " +
                           "FROM Room r " +
                           "JOIN Hotel h ON r.Hotel_ID = h.Hotel_ID " +
                           "LEFT JOIN Amenity a ON r.Room_ID = a.Room_ID AND r.Hotel_ID = a.Hotel_ID " +
                           "WHERE h.hotel_chain_name = ?";
        
        roomStatement = connection.prepareStatement(roomQuery);
        roomStatement.setString(1, hotelChainName);
        roomResultSet = roomStatement.executeQuery();
        
        // Display rooms and amenities
        while (roomResultSet.next()) {
            int roomID = roomResultSet.getInt("Room_ID");
            int price = roomResultSet.getInt("Price");
            int capacity = roomResultSet.getInt("Capacity");
            String address = roomResultSet.getString("Address");
            String amenity = roomResultSet.getString("amenity");
            String view = roomResultSet.getString("view");

            // Output room details, amenities, and address
            out.println("<div class=\"room-container\">");
            out.println("<div class=\"room-info\">");
            out.println("<p>Room: " + roomID + " | Price: $" + price + " | Capacity: " + capacity + " | View: " + view + " | Address: " + address + "</p>");
            if (amenity != null) {
                out.println("<p>Amenity: " + amenity + "</p>");
            }
            out.println("</div>"); // Close room-info div
            out.println("<div class=\"room-links\">");
                out.println("<p><a href='book.jsp?roomID=" + roomID + "&customerName=" + customerName + "&employeeId=" + employeeId + "'>Book</a> | <a href='rent.jsp?roomID=" + roomID + "&customerName=" + customerName + "&employeeId=" + employeeId + "'>Rent</a></p>");
                out.println("</div>"); 
            out.println("</div>"); 
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<div>" + e.getMessage() +  "</div>");
    } finally {
        // Close connections
        try {
            if (roomResultSet != null) roomResultSet.close();
            if (roomStatement != null) roomStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    %>
    
</body>
</html>
