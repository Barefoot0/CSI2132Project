<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
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
<div class="container">
    <form method="post" action="create_booking.jsp">
        <label for="full_name">Full Name:</label>
        <input type="text" id="full_name" name="full_name" required><br>

        <label for="address">Address:</label>
        <input type="text" id="address" name="address" required><br>

        <label for="id_type">ID Type:</label>
        <select id="id_type" name="id_type">
            <option value="SIN">SIN</option>
            <option value="SSN">SSN</option>
            <option value="Driver Licence">Driver Licence</option>
        </select><br>

        <label for="booking_date">Booking Date:</label>
        <input type="date" id="booking_date" name="booking_date" value="<%= new java.util.Date().toString() %>" required><br>

        <label for="checkin_date">Checkin Date:</label>
        <input type="date" id="checkin_date" name="checkin_date" value="<%= request.getParameter("checkin_date") %>" required><br>

        <label for="checkout_date">Checkout Date:</label>
        <input type="date" id="checkout_date" name="checkout_date" value="<%= request.getParameter("checkout_date") %>" required><br>

        <label for="hotel_id">Hotel ID:</label>
        <input type="number" id="hotel_id" name="hotel_id" value="<%= request.getParameter("hotel_id") %>" required><br>

        <label for="room_id">Room ID:</label>
        <input type="number" id="room_id" name="room_id" value="<%= request.getParameter("room_id") %>" required><br>

        <input type="submit" value="Book">
    </form>
</div>
</body>
</html>
