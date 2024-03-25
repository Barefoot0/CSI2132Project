<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="java.text.SimpleDateFormat, java.text.ParseException" %>

<!DOCTYPE html>
<html>
<head>
    <title>Book Room</title>
    <style>
        .container {
            width: 50%;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 50px;
        }
        input[type="text"], select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
        }
        input[type="date"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 3px;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
        }
        .back-button {
            position: fixed; /* Position the button relative to the browser window */
            top: 20px; /* Set the distance from the top */
            left: 20px; /* Set the distance from the left */
            padding: 10px 20px; /* Set padding to make the button clickable */
            background-color: #007bff; /* Set background color */
            color: #fff; /* Set text color */
            border: none; /* Remove border */
            border-radius: 5px; /* Apply rounded corners */
            cursor: pointer; /* Change cursor to pointer on hover */
        }
        h1 {
            text-align: center;
        }
    </style>
</head>
<body>
<h1>Book Room</h1>
<button class="back-button" onclick="window.location.href='display_rooms.jsp'">Back</button>
<div class="container">
    <form method="post" action="#">
        <label for="customer_id">Customer ID:</label>
        <input type="text" id="customer_id" name="customer_id" required><br>

        <label for="booking_date">Booking Date:</label>
        <input type="date" id="booking_date" name="booking_date" value="<%= new java.util.Date().toString() %>" required><br>

        <label for="checkin_date">Checkin Date:</label>
        <input type="date" id="checkin_date" name="checkin_date" value="<%= request.getParameter("startDate") %>" readonly required><br>

        <label for="checkout_date">Checkout Date:</label>
        <input type="date" id="checkout_date" name="checkout_date" value="<%= request.getParameter("endDate") %>" readonly required><br>

        <label for="hotel_id">Hotel ID:</label>
        <input type="number" id="hotel_id" name="hotel_id" value="<%= request.getParameter("hotel_id") %>" readonly required><br>

        <label for="room_id">Room ID:</label>
        <input type="number" id="room_id" name="room_id" value="<%= request.getParameter("room_id") %>" readonly required><br>

        <input type="submit" value="Book">
    </form>

<%
        // Process form submission to create a booking
        if (request.getMethod().equals("POST")) {
            String customerId = request.getParameter("customer_id");
            String bookingDate = request.getParameter("booking_date");
            String checkinDate = request.getParameter("checkin_date");
            String checkoutDate = request.getParameter("checkout_date");
            String hotelId = request.getParameter("hotel_id");
            String roomId = request.getParameter("room_id");

            // Database connection parameters
            String url = "jdbc:postgresql://localhost:5433/postgres";
            String username = "postgres";
            String password = "password";

            // JDBC variables
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                // Load the MySQL JDBC driver
                Class.forName("org.postgresql.Driver");

                // Establish a connection to the database
                conn = DriverManager.getConnection(url, username, password);

                // SQL query to insert a booking into the database
                String sql = "INSERT INTO website.Booking (Customer_ID, Booking_Date, Checkin_Date, Checkout_Date, Hotel_ID, Room_ID) VALUES (?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);

                // Set the parameters for the PreparedStatement
                pstmt.setInt(1, Integer.parseInt(customerId));

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date parsedBookDate = sdf.parse(bookingDate);
                java.sql.Date sqlBookDate = new java.sql.Date(parsedBookDate.getTime());
                SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date parsedStartDate = sdf2.parse(checkinDate);
                java.sql.Date sqlStartDate = new java.sql.Date(parsedStartDate.getTime());
                SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date parsedEndDate = sdf3.parse(checkoutDate);
                java.sql.Date sqlEndDate = new java.sql.Date(parsedEndDate.getTime());

                pstmt.setDate(2, sqlBookDate);
                pstmt.setDate(3, sqlStartDate);
                pstmt.setDate(4, sqlEndDate);
                pstmt.setInt(5, Integer.parseInt(hotelId));
                pstmt.setInt(6, Integer.parseInt(roomId));

                // Execute the SQL query to insert the booking into the database
                int rowsAffected = pstmt.executeUpdate();

                // Check if the insertion was successful
                if (rowsAffected > 0) {
%>
    <p>Booking created successfully!</p>
    <%
    } else {
    %>
    <p>Error creating booking. Please try again.</p>
    <%
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    %>
    <p>Database error occurred. Please try again later.</p>
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
</div>
</body>
</html>
