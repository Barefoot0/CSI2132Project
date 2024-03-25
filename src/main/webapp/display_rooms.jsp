<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat, java.text.ParseException" %>

<!DOCTYPE html>
<html>
<head>
    <title>Search Results</title>
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
<h1>Search Results</h1>
<button class="back-button" onclick="window.location.href='index.jsp'">Back</button>
<%-- Retrieve criteria entered by the user --%>
<% String startDate = request.getParameter("start_date");
    String endDate = request.getParameter("end_date");
//    String bookingRenting = request.getParameter("booking_renting");
    String roomCapacity = request.getParameter("room_capacity");
    String hotelChain = request.getParameter("hotel_chain");
    String hotelRating = request.getParameter("hotel_rating");
    String price = request.getParameter("price");
    String totalRooms = request.getParameter("total_rooms");
    String view = request.getParameter("view");
%>

<%-- Query the database for rooms that satisfy the criteria --%>
<%
    String query = "SELECT * FROM website.Room WHERE 1=1"; // Base query

    // Add conditions based on user input
    if (startDate != null && !startDate.isEmpty()) {
        query += " AND Room_ID NOT IN (SELECT Room_ID FROM website.Booking WHERE CAST(Checkin_Date AS DATE) <= ? AND CAST(Checkout_Date AS DATE) >= ?)";
    }
    if (endDate != null && !endDate.isEmpty()) {
        query += " AND Room_ID NOT IN (SELECT Room_ID FROM website.Booking WHERE CAST(Checkin_Date AS DATE) <= ? AND CAST(Checkout_Date AS DATE) >= ?)";
    }
//    if (bookingRenting != null && !bookingRenting.isEmpty()) {
//        // Add condition based on booking/renting option
//        if (bookingRenting.equals("booking")) {
//            query += " AND Room_ID NOT IN (SELECT Room_ID FROM Booking)";
//        } else if (bookingRenting.equals("renting")) {
//            query += " AND Room_ID NOT IN (SELECT Room_ID FROM Renting)";
//        }
//    }
    if (roomCapacity != null && !roomCapacity.isEmpty()) {
        query += " AND Capacity >= ?";
    }
    if (price != null && !price.isEmpty()) {
        query += " AND Price <= ?";
    }
    if (hotelChain != null && !hotelChain.isEmpty()) {
        query += " AND Hotel_ID IN (SELECT Hotel_ID FROM website.Hotel WHERE Hotel_Chain_Name = ?)";
    }
    if (hotelRating != null && !hotelRating.isEmpty()) {
        query += " AND Hotel_ID IN (SELECT Hotel_ID FROM website.Hotel WHERE Rating >= ?)";
    }
    if (totalRooms != null && !totalRooms.isEmpty()) {
        query += " AND Hotel_ID IN (SELECT Hotel_ID FROM website.Hotel WHERE Number_Of_Rooms >= ?)";
    }
    if (view != null && !view.isEmpty()) {
        query += " AND View = ?";
    }

    // Prepare and execute the query
    try {
        Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5433/postgres", "postgres", "password"); /* get database connection */;
        PreparedStatement pstmt = conn.prepareStatement(query);
        int paramIndex = 1;
        if (startDate != null && !startDate.isEmpty()) {
            try {
                // Parse startDate string into java.util.Date object
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date parsedStartDate = sdf.parse(startDate);

                // Convert java.util.Date to java.sql.Date
                java.sql.Date sqlStartDate = new java.sql.Date(parsedStartDate.getTime());

                // Set sqlStartDate as parameter
                pstmt.setDate(paramIndex++, sqlStartDate);
                pstmt.setDate(paramIndex++, sqlStartDate);
            } catch (ParseException e) {
                // Handle parse exception
                e.printStackTrace();
            }
        }

        if (endDate != null && !endDate.isEmpty()) {
            try {
                // Parse endDate string into java.util.Date object
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date parsedEndDate = sdf.parse(endDate);

                // Convert java.util.Date to java.sql.Date
                java.sql.Date sqlEndDate = new java.sql.Date(parsedEndDate.getTime());

                // Set sqlEndDate as parameter
                pstmt.setDate(paramIndex++, sqlEndDate);
                pstmt.setDate(paramIndex++, sqlEndDate);
            } catch (ParseException e) {
                // Handle parse exception
                e.printStackTrace();
            }
        }
        if (roomCapacity != null && !roomCapacity.isEmpty()) {
            pstmt.setInt(paramIndex++, Integer.parseInt(roomCapacity));
        }
        if (price != null && !price.isEmpty()) {
            pstmt.setInt(paramIndex++, Integer.parseInt(price));
        }
        if (hotelChain != null && !hotelChain.isEmpty()) {
            pstmt.setString(paramIndex++, hotelChain);
        }
        if (hotelRating != null && !hotelRating.isEmpty()) {
            pstmt.setInt(paramIndex++, Integer.parseInt(hotelRating));
        }
        if (totalRooms != null && !totalRooms.isEmpty()) {
            pstmt.setInt(paramIndex++, Integer.parseInt(totalRooms));
        }
        if (view != null && !view.isEmpty()) {
            pstmt.setString(paramIndex++, view);
        }

        ResultSet rs = pstmt.executeQuery();

        // Process the results
%>
<style>
    table {
        width: 80%; /* Set the width of the table */
        margin: 0 auto; /* Center the table horizontally */
        border-collapse: collapse;
    }
    th, td {
        padding: 10px; /* Increase padding for better spacing */
        text-align: left;
        border-bottom: 1px solid #ddd;
    }
    th {
        background-color: #f2f2f2;
    }
</style>
<table>
    <thead>
    <tr>
        <th>Room ID</th>
        <th>Hotel ID</th>
        <th>Price</th>
        <th>Rating</th>
        <th>Capacity</th>
        <th>View</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <%
        while (rs.next()) {
            // Retrieve room information from the result set
            int roomId = rs.getInt("Room_ID");
            int hotelId = rs.getInt("Hotel_ID");
            int price2 = rs.getInt("Price");
            int capacity = rs.getInt("Capacity");

            int rating = 0;
            try {
                PreparedStatement pstmnt2 = conn.prepareStatement("SELECT Rating FROM website.Hotel WHERE Hotel_ID = ?");
                pstmnt2.setInt(1, rs.getInt("Hotel_ID"));
                ResultSet rs2 = pstmnt2.executeQuery();
                if (rs2.next()) {
                    rating = rs2.getInt("Rating");
                }
                rs2.close();
                pstmnt2.close();
            } catch(SQLException e){
                e.printStackTrace();
            }
            String view2 = rs.getString("View");
    %>
    <tr>
        <td><%= roomId %></td>
        <td><%= hotelId %></td>
        <td><%= price2 %></td>
        <td><%= rating %></td>
        <td><%= capacity %></td>
        <td><%= view2 %></td>
        <td><a href="book_info.jsp?price=<%=price2%>&room_id=<%=roomId%>&hotel_id=<%=hotelId%>">Book</a></td>
    </tr>
    <%
            }
            // Close resources
            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQLException
        }
    %>
    </tbody>
</table>

</body>
</html>