<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Turn Booking to Rental</title>
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
        <h2>Turn Booking to Rental</h2>
        <% 
            String url = "jdbc:postgresql://localhost:5432/postgres";
            String username = "martinpatrouchev";
            String password = "1234";
            
            Connection connection = null;
            PreparedStatement statement = null;
            
            try {
                Class.forName("org.postgresql.Driver");
                connection = DriverManager.getConnection(url, username, password);
                
                int bookingID = Integer.parseInt(request.getParameter("bookingID"));
                int employeeId = Integer.parseInt(request.getParameter("employeeID"));
                String customerName = request.getParameter("customerName");

                String sql = "SELECT * FROM Booking WHERE Booking_ID = ?";
                
                statement = connection.prepareStatement(sql);
                statement.setInt(1, bookingID);
                ResultSet resultSet1 = statement.executeQuery();
                
                if (resultSet1.next()) {
                    int hotelId = resultSet1.getInt("Hotel_ID");
                    int roomID = resultSet1.getInt("room_id");

                    // Delete referencing entries from Renting table
                    String deleteRentingQuery = "DELETE FROM Renting WHERE Booking_ID = ?";
                    statement = connection.prepareStatement(deleteRentingQuery);
                    statement.setInt(1, bookingID);
                    statement.executeUpdate();
                    
                    // Delete booking entry from Booking table
                    String deleteBookingQuery = "DELETE FROM Booking WHERE Booking_ID = ?";
                    statement = connection.prepareStatement(deleteBookingQuery);
                    statement.setInt(1, bookingID);
                    statement.executeUpdate();

                    sql = "SELECT Customer_ID FROM Customer WHERE Full_Name = ?";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, customerName);
                    ResultSet resultSet2 = statement.executeQuery();
                    
                    // Move the cursor to the first row
                    if (resultSet2.next()) {
                        int customerId = resultSet2.getInt("Customer_ID");


                        String rentQuery = "INSERT INTO Renting (Employee_ID, Customer_ID, Renting_Date, Checkin_Date, Checkout_Date, Hotel_ID, Room_ID) VALUES (?, ?, ?, ?, ?, ?, ?)";
                        PreparedStatement rentStatement = connection.prepareStatement(rentQuery);
                        rentStatement.setInt(1, employeeId);
                        rentStatement.setInt(2, customerId); 
                        rentStatement.setDate(3, new Date(System.currentTimeMillis())); // Renting date
                        rentStatement.setDate(4, null); 
                        rentStatement.setDate(5, null); 
                        rentStatement.setInt(6, hotelId); 
                        rentStatement.setInt(7, roomID);
                        
                        int rowsAffected = rentStatement.executeUpdate();
                        
                        out.println("<div class=\"message\">Booking successfully turned into a rental.</div>");
                    } else {
                        throw new SQLException("Customer not found.");
                    }
                } else {
                    throw new SQLException("Booking not found.");
                }
                
            } catch (Exception e) {
                System.out.println("Error occurred: " + e.getMessage());
                out.println("<div class=\"message\">" + e.getMessage() +  "</div>");
            } finally {
                // Close connections
                try {
                    if (statement != null) statement.close();
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
