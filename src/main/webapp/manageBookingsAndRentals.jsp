<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Manage Bookings and Rentals</title>
</head>
<body>
    <%
    String url = "jdbc:postgresql://localhost:5433/postgres";
    String username = "postgres";
    String password = "password";
    
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    
    try {
        Class.forName("org.postgresql.Driver");
        connection = DriverManager.getConnection(url, username, password);
        
        String customerName = request.getParameter("customerName");
        
        // Query to get customer's bookings
        String query = "SELECT Booking_ID, Booking_Date, Checkin_Date, Checkout_Date, Hotel_ID, Room_ID " +
                       "FROM Booking b JOIN Customer c ON b.Customer_ID = c.Customer_ID " +
                       "JOIN Person p ON c.Person_ID = p.Person_ID " +
                       "WHERE p.Full_Name LIKE ?";
        
        statement = connection.prepareStatement(query);
        statement.setString(1, "%" + customerName + "%");
        resultSet = statement.executeQuery();
        
        // Display customer's bookings
        out.println("<h3>Customer's Bookings:</h3>");
        out.println("<ul>");
        while (resultSet.next()) {
            int bookingID = resultSet.getInt("Booking_ID");
            Date bookingDate = resultSet.getDate("Booking_Date");
            Date checkinDate = resultSet.getDate("Checkin_Date");
            Date checkoutDate = resultSet.getDate("Checkout_Date");
            int hotelID = resultSet.getInt("Hotel_ID");
            int roomID = resultSet.getInt("Room_ID");
            
            out.println("<li>");
            out.println("Booking ID: " + bookingID + "<br>");
            out.println("Booking Date: " + bookingDate + "<br>");
            out.println("Checkin Date: " + checkinDate + "<br>");
            out.println("Checkout Date: " + checkoutDate + "<br>");
            out.println("Hotel ID: " + hotelID + "<br>");
            out.println("Room ID: " + roomID + "<br>");
            out.println("<form action='turnToRental.jsp' method='post'>");
            out.println("<input type='hidden' name='bookingID' value='" + bookingID + "'>");
            out.println("<input type='hidden' name='hotelID' value='" + hotelID + "'>");
            out.println("<input type='hidden' name='roomID' value='" + roomID + "'>");
            out.println("<input type='submit' value='Turn to Rental'>");
            out.println("</form>");
            out.println("</li>");
        }
        
    } catch (Exception e) {
        System.out.println("Error occurred: " + e.getMessage());
        out.println("<div>" + e.getMessage() +  "</div>");
    } finally {
        out.println("<div>" + "sad connect" + "</div>");
        // Close connections
        if (resultSet != null) {
            resultSet.close();
        }
        if (statement != null) {
            statement.close();
        }
        if (connection != null) {
            connection.close();
        }
    }
    %>
</body>
</html>
