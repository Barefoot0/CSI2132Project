<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Manage Bookings and Rentals</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h2 {
            color: #333;
        }
        h3 {
            color: #555;
        }
        form {
            display: inline-block;
            margin-bottom: 20px;
        }
        ul {
            list-style-type: none;
            padding-left: 0;
        }
        li {
            margin-bottom: 20px;
            border: 1px solid #ccc;
            padding: 10px;
        }
        li:hover {
            background-color: #f9f9f9;
        }
        form input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 16px;
            cursor: pointer;
            border-radius: 4px;
        }
        form input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h2>Manage Bookings and Rentals</h2>
    <form action="selectHotel.jsp" method="get">
        <input type="hidden" name="customerName" value="<%= request.getParameter("customerName") %>">
        <input type="hidden" name="employeeID" value="<%= request.getParameter("employeeId") %>">
        <input type="submit" value="Create New Renting">
    </form>    
    <%
    String url = "jdbc:postgresql://localhost:5432/postgres";
    String username = "martinpatrouchev";
    String password = "1234";
    
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    
    try {
        Class.forName("org.postgresql.Driver");
        connection = DriverManager.getConnection(url, username, password);
        
        String customerName = request.getParameter("customerName");
        String employeeID = request.getParameter("employeeId");

        // Query to get customer's bookings with hotel chain name and address
        String query = "SELECT b.Booking_ID, b.Booking_Date, b.Checkin_Date, b.Checkout_Date, h.hotel_chain_name, h.Address, b.Room_ID " +
                       "FROM Booking b " +
                       "JOIN Customer c ON b.Customer_ID = c.Customer_ID " +
                       "JOIN Person p ON c.Person_ID = p.Person_ID " +
                       "JOIN Hotel h ON b.Hotel_ID = h.Hotel_ID " +
                       "WHERE p.Full_Name LIKE ?";
        
        statement = connection.prepareStatement(query);
        statement.setString(1, "%" + customerName + "%");
        resultSet = statement.executeQuery();
        
        // Display customer's bookings
        out.println("<h3>Customer's Bookings:</h3>");
            
            while (resultSet.next()) {
                int bookingID = resultSet.getInt("Booking_ID");
                Date bookingDate = resultSet.getDate("Booking_Date");
                Date checkinDate = resultSet.getDate("Checkin_Date");
                Date checkoutDate = resultSet.getDate("Checkout_Date");
                String hotelChainName = resultSet.getString("hotel_chain_name");
                String address = resultSet.getString("Address");
                int roomID = resultSet.getInt("Room_ID");
                
                out.println("<li>");
                out.println("Booking ID: " + bookingID + "<br>");
                out.println("Booking Date: " + bookingDate + "<br>");
                out.println("Hotel: " + hotelChainName + " - "+ address + "<br>");
                out.println("Room: " + roomID + "<br>");
                out.println("<form action='turnToRental.jsp' method='post'>");
                out.println("<input type='hidden' name='bookingID' value='" + bookingID + "'>");
                out.println("<input type='hidden' name='roomID' value='" + roomID + "'>");
                out.println("<input type='hidden' name='employeeID' value='" + employeeID + "'>");
                out.println("<input type='hidden' name='customerName' value='" + customerName + "'>");
                out.println("<input type='submit' value='Turn to Rental'>");
                out.println("</form>");
                out.println("</li>");
            }            
        out.println("</ul>");
        
    } catch (Exception e) {
        System.out.println("Error occurred: " + e.getMessage());
        out.println("<div>" + e.getMessage() +  "</div>");
    } finally {
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
