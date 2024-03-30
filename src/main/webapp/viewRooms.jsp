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
        table {
            width: 50%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        table th {
            background-color: #f2f2f2;
        }
        .room-container {
            margin-bottom: 30px;
            border: 1px solid #ccc;
            padding: 10px;
            border-radius: 5px;
        }
        .room-info {
            font-size: 18px;
        }
        .room-links {
            margin-top: 10px;
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
    int totalCapacity = 0;
    int numAvailableRooms = 0;
    Connection connection = null;
    PreparedStatement capacityStatement = null;
    ResultSet capacityResultSet = null;
    PreparedStatement availableRoomsStatement = null;
    ResultSet availableRoomsResultSet = null;
    PreparedStatement roomStatement = null;
    ResultSet roomResultSet = null;

    try {
        String url = "jdbc:postgresql://localhost:5432/postgres";
        String username = "martinpatrouchev";
        String password = "1234";
        Class.forName("org.postgresql.Driver");
        connection = DriverManager.getConnection(url, username, password);

        String customerName = request.getParameter("customerName");
        String hotelChainName = request.getParameter("hotelName");
        int employeeId = Integer.parseInt(request.getParameter("employeeId"));

        capacityStatement = connection.prepareStatement("SELECT TotalCapacity FROM capacityOfRooms");
        capacityResultSet = capacityStatement.executeQuery();
        if (capacityResultSet.next()) {
            totalCapacity = capacityResultSet.getInt("TotalCapacity");
        }

        availableRoomsStatement = connection.prepareStatement("SELECT * FROM AvailableRoomsPerArea");
        availableRoomsResultSet = availableRoomsStatement.executeQuery();

        // Display data for sea view in HTML table
        %>
        <table>
            <tr><th>Room Type</th><th>Number of Available Rooms</th></tr>
            <%
            while (availableRoomsResultSet.next()) {
                String roomType = availableRoomsResultSet.getString("view");
                numAvailableRooms = availableRoomsResultSet.getInt("NumAvailableRooms");
                %>
                <tr><td><%= roomType %></td><td><%= numAvailableRooms %></td></tr>
                <%
            }
            %>
        </table>
        <%

        String roomQuery = "SELECT r.Room_ID, r.Price, r.Capacity, h.Address, a.Amenity, r.view " +
                           "FROM Room r " +
                           "JOIN Hotel h ON r.Hotel_ID = h.Hotel_ID " +
                           "LEFT JOIN Amenity a ON r.Room_ID = a.Room_ID AND r.Hotel_ID = a.Hotel_ID " +
                           "WHERE h.hotel_chain_name = ?";
        roomStatement = connection.prepareStatement(roomQuery);
        roomStatement.setString(1, hotelChainName);
        roomResultSet = roomStatement.executeQuery();
        %>
        <div class="view-info">
            <p>Number of Available Rooms: <%= numAvailableRooms %></p>
        </div>
        <%
        while (roomResultSet.next()) {
            int roomID = roomResultSet.getInt("Room_ID");
            int price = roomResultSet.getInt("Price");
            int capacity = roomResultSet.getInt("Capacity");
            String address = roomResultSet.getString("Address");
            String amenity = roomResultSet.getString("amenity");
            String view = roomResultSet.getString("view");
            %>
            <div class="room-container">
                <div class="room-info">
                    <p>Room: <%= roomID %> | Price: $<%= price %> | Capacity: <%= capacity %> | View: <%= view %> | Address: <%= address %></p>
                    <%
                    if (amenity != null) {
                        %>
                        <p>Amenity: <%= amenity %></p>
                        <%
                    }
                    %>
                </div> <!-- Close room-info div -->
                <div class="room-links">
                    <p><a href='book.jsp?roomID=<%= roomID %>&customerName=<%= customerName %>&employeeId=<%= employeeId %>'>Book</a> | <a href='rent.jsp?roomID=<%= roomID %>&customerName=<%= customerName %>&employeeId=<%= employeeId %>'>Rent</a></p>
                </div>
            </div>
            <%
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<div>" + e.getMessage() +  "</div>");
    } finally {
        try {
            if (roomResultSet != null) roomResultSet.close();
            if (roomStatement != null) roomStatement.close();
            if (availableRoomsResultSet != null) availableRoomsResultSet.close();
            if (availableRoomsStatement != null) availableRoomsStatement.close();
            if (capacityResultSet != null) capacityResultSet.close();
            if (capacityStatement != null) capacityStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    %>
</body>
</html>
