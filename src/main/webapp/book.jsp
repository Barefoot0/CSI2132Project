<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Book Room</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f2f2f2;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
            font-size: 24px;
            margin-top: 0;
        }
        .message {
            margin-bottom: 20px;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 18px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        .button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Book Room</h2>
        
        <% 
        String customerName = request.getParameter("customerName");
        int roomID = Integer.parseInt(request.getParameter("roomID"));
        
        String url = "jdbc:postgresql://localhost:5433/postgres";
        String username = "postgres";
        String password = "password";
        Connection connection = null;
        PreparedStatement bookStatement = null;
        ResultSet hotelResultSet = null;
        
        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(url, username, password);
            
            String hotelQuery = "SELECT Hotel_ID FROM website.Room WHERE Room_ID = ?";
            PreparedStatement hotelStatement = connection.prepareStatement(hotelQuery);
            hotelStatement.setInt(1, roomID);
            hotelResultSet = hotelStatement.executeQuery();
            
            int hotelID = -1;
            if (hotelResultSet.next()) {
                hotelID = hotelResultSet.getInt("Hotel_ID");
            }
            
            if (hotelID != -1) {
                String bookQuery = "INSERT INTO website.Booking (Customer_ID, Booking_Date, Room_ID, Hotel_ID) VALUES (?, ?, ?, ?)";
                bookStatement = connection.prepareStatement(bookQuery);
                bookStatement.setInt(1, 1);
                bookStatement.setDate(2, new Date(System.currentTimeMillis()));
                bookStatement.setInt(3, roomID);
                bookStatement.setInt(4, hotelID);
                
                int rowsAffected = bookStatement.executeUpdate();
                
                if (rowsAffected > 0) {
                    System.out.println("<div class=\"message\">Room booked successfully!</div>");
                } else {
                    System.out.println("<div class=\"message\">Failed to book room.</div>");
                }
            } else {
                System.out.println("<div class=\"message\">Failed to retrieve hotel information for the booked room.</div>");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("<div class=\"message\">" + e.getMessage() +  "</div>");
        } finally {
            try {
                if (hotelResultSet != null) hotelResultSet.close();
                if (bookStatement != null) bookStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        %>
        
        <a href="home_page.jsp" class="button">Back to Home</a>
    </div>
</body>
</html>
