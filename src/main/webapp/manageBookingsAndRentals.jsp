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
        
        String query = "SELECT Booking_ID, Booking_Date, Checkin_Date, Checkout_Date, Hotel_ID, Room_ID " +
                       "FROM website.Booking b JOIN website.Customer c ON b.Customer_ID = c.Customer_ID " +
                       "JOIN website.Person p ON c.Person_ID = p.Person_ID " +
                       "WHERE p.Full_Name LIKE ?";
        
        statement = connection.prepareStatement(query);
        statement.setString(1, "%" + customerName + "%");
        resultSet = statement.executeQuery();
        
        // Display customer's bookings
        System.out.println("<h3>Customer's Bookings:</h3>");
        System.out.println("<ul>");
        while (resultSet.next()) {
            int bookingID = resultSet.getInt("Booking_ID");
            Date bookingDate = resultSet.getDate("Booking_Date");
            Date checkinDate = resultSet.getDate("Checkin_Date");
            Date checkoutDate = resultSet.getDate("Checkout_Date");
            int hotelID = resultSet.getInt("Hotel_ID");
            int roomID = resultSet.getInt("Room_ID");

            System.out.println("<li>");
            System.out.println("Booking ID: " + bookingID + "<br>");
            System.out.println("Booking Date: " + bookingDate + "<br>");
            System.out.println("Checkin Date: " + checkinDate + "<br>");
            System.out.println("Checkout Date: " + checkoutDate + "<br>");
            System.out.println("Hotel ID: " + hotelID + "<br>");
            System.out.println("Room ID: " + roomID + "<br>");
            System.out.println("<form action='turnToRental.jsp' method='post'>");
            System.out.println("<input type='hidden' name='bookingID' value='" + bookingID + "'>");
            System.out.println("<input type='hidden' name='hotelID' value='" + hotelID + "'>");
            System.out.println("<input type='hidden' name='roomID' value='" + roomID + "'>");
            System.out.println("<input type='submit' value='Turn to Rental'>");
            System.out.println("</form>");
            System.out.println("</li>");
        }
        
    } catch (Exception e) {
        System.out.println("Error occurred: " + e.getMessage());
        System.out.println("<div>" + e.getMessage() +  "</div>");
    } finally {
        System.out.println("<div>" + "sad connect" + "</div>");
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
