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
            position: fixed;
            top: 20px;
            left: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        h1 {
            text-align: center;
        }
    </style>
</head>
<body>
<h1>Search Results</h1>
<button class="back-button" onclick="window.location.href='index.jsp'">Back</button>
<% String startDate = request.getParameter("start_date");
    String endDate = request.getParameter("end_date");
    String roomCapacity = request.getParameter("room_capacity");
    String hotelChain = request.getParameter("hotel_chain");
    String hotelRating = request.getParameter("hotel_rating");
    String price = request.getParameter("price");
    String totalRooms = request.getParameter("total_rooms");
    String view = request.getParameter("view");
%>

<%
    String query = "SELECT * FROM website.Room WHERE 1=1"; // Base query

    if (startDate != null && !startDate.isEmpty()) {
        query += " AND Room_ID NOT IN (SELECT Room_ID FROM website.Booking WHERE CAST(Checkin_Date AS DATE) <= ? AND CAST(Checkout_Date AS DATE) >= ?)";
    }
    if (endDate != null && !endDate.isEmpty()) {
        query += " AND Room_ID NOT IN (SELECT Room_ID FROM website.Booking WHERE CAST(Checkin_Date AS DATE) <= ? AND CAST(Checkout_Date AS DATE) >= ?)";
    }
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

    try {
        Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5433/postgres", "postgres", "password"); /* get database connection */;
        PreparedStatement pstmt = conn.prepareStatement(query);
        int paramIndex = 1;
        if (startDate != null && !startDate.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date parsedStartDate = sdf.parse(startDate);

                java.sql.Date sqlStartDate = new java.sql.Date(parsedStartDate.getTime());

                pstmt.setDate(paramIndex++, sqlStartDate);
                pstmt.setDate(paramIndex++, sqlStartDate);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        if (endDate != null && !endDate.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date parsedEndDate = sdf.parse(endDate);

                java.sql.Date sqlEndDate = new java.sql.Date(parsedEndDate.getTime());

                pstmt.setDate(paramIndex++, sqlEndDate);
                pstmt.setDate(paramIndex++, sqlEndDate);
            } catch (ParseException e) {
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

%>
<style>
    table {
        width: 80%;/
        margin: 0 auto;
        border-collapse: collapse;
    }
    th, td {
        padding: 10px;
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
        <td><a href="book_info.jsp?startDate=<%=startDate%>&endDate=<%=endDate%>&price=<%=price2%>&room_id=<%=roomId%>&hotel_id=<%=hotelId%>">Book</a></td>
    </tr>
    <%
            }
            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
    </tbody>
</table>

</body>
</html>