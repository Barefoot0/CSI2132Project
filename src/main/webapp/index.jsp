<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel Booking</title>
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
        input[type="date"], select {
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
<button class="back-button" onclick="window.location.href='home_page.jsp'">Back</button>
<div class="container">
    <h1>Hotel Booking</h1>
    <form action="display_rooms.jsp" method="post">
        <label for="start_date">Start Date (yyyy-mm-dd): </label>
        <input type="date" id="start_date" name="start_date" placeholder="yyyy-mm-dd" pattern="\d{4}-\d{2}-\d{2}" required>

        <br>

        <label for="end_date">End Date (yyyy-mm-dd): </label>
        <input type="date" id="end_date" name="end_date" placeholder="yyyy-mm-dd" pattern="\d{4}-\d{2}-\d{2}" required>

        <br>

        <label for="booking_renting">Booking/Renting:</label>
        <select id="booking_renting" name="booking_renting">
            <option value="booking">Booking</option>
            <option value="renting">Renting</option>
        </select>

        <br>

        <label for="room_capacity">Room Capacity:</label>
        <select id="room_capacity" name="room_capacity">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
        </select>

        <br>

        <label for="hotel_chain">Hotel Chain:</label>
        <select id="hotel_chain" name="hotel_chain">
            <%
                // Dynamically generate options for hotel chains from database
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("org.postgresql.Driver").newInstance();
                    conn = DriverManager.getConnection("jdbc:postgresql://localhost:5433/postgres", "postgres", "password");
                    String query = "SELECT hotel_chain_name FROM website.hotel_chain";
                    pstmt = conn.prepareStatement(query);
                    rs = pstmt.executeQuery();

                    while(rs.next()) {
                        String chainName = rs.getString("hotel_chain_name");
            %>
            <option value="<%=chainName%>"><%=chainName%></option>
            <%
                    }
                } catch(Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </select>

        <br>

        <label for="hotel_rating">Hotel Rating:</label>
        <select id="hotel_rating" name="hotel_rating">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
        </select>

        <br>

        <label for="price">Price:</label>
        <input type="text" id="price" name="price">

        <br>

        <label for="total_rooms">Total Rooms in Hotel:</label>
        <input type="text" id="total_rooms" name="total_rooms">

        <br>

        <label for="view">View:</label>
        <select id="view" name="view">
            <option value=""></option>
            <option value="Sea">Sea</option>
            <option value="Mountain">Mountain</option>
        </select>

        <br>

        <button type="submit">Submit</button>
    </form>
</div>
</body>
</html>