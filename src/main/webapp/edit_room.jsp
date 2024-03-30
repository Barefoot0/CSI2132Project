<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Room</title>
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
        input[type="number"] {
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
<button class="back-button" onclick="window.location.href='manage_database.jsp'">Back</button>
<body>
<%
    String editRoomId = request.getParameter("edit_room_id");

    if (editRoomId != null) {
        String url = "jdbc:postgresql://localhost:5433/postgres";
        String username = "postgres";
        String password = "password";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.postgresql.Driver");

            conn = DriverManager.getConnection(url, username, password);

            String sql = "SELECT * FROM website.Room WHERE Room_ID = ? FOR UPDATE";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(editRoomId));

            rs = pstmt.executeQuery();

            if (rs.next()) {
                int hotelId = rs.getInt("Hotel_ID");
                int price = rs.getInt("Price");
                int capacity = rs.getInt("Capacity");
                String view = rs.getString("View");
                boolean extendable = rs.getBoolean("Extendable");
%>
<div class="container">
<h2>Edit Room Details</h2>
<form action="#" method="post">
    <input type="hidden" name="edit_room_id" value="<%=editRoomId%>">
    <label for="hotel_id">Hotel ID:</label>
    <input type="text" id="hotel_id" name="hotel_id" value="<%=hotelId%>" required><br>

    <label for="price">Price:</label>
    <input type="number" id="price" name="price" value="<%=price%>" required min="0"><br>

    <label for="capacity">Capacity:</label>
    <input type="number" id="capacity" name="capacity" value="<%=capacity%>" required min="1"><br>

    <label for="view">View:</label>
    <select id="view" name="view" required>
        <option value="Sea" <%= view.equals("Sea") ? "selected" : "" %>>Sea</option>
        <option value="Mountain" <%= view.equals("Mountain") ? "selected" : "" %>>Mountain</option>
    </select><br>

    <label for="extendable">Extendable:</label>
    <input type="checkbox" id="extendable" name="extendable" <%= extendable ? "checked" : "" %>><br>

    <input type="submit" value="Update Room">
</form>
</div>
<%
            }
        } catch (SQLException | ClassNotFoundException e) {
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
    }
%>
<%
    String updateRoomId = request.getParameter("edit_room_id");
    if (updateRoomId != null) {
        String hotelId = request.getParameter("hotel_id");
        String price = request.getParameter("price");
        String capacity = request.getParameter("capacity");
        String view = request.getParameter("view");
        String extendable = request.getParameter("extendable") != null ? "true" : "false";

        String url = "jdbc:postgresql://localhost:5433/postgres";
        String username = "postgres";
        String password = "password";

        Connection conn = null;
        PreparedStatement pstmt = null;

        if (hotelId != null && price != null && capacity != null && view != null && extendable != null){

        try {
            Class.forName("org.postgresql.Driver");

            conn = DriverManager.getConnection(url, username, password);

            String sql = "UPDATE website.room SET Hotel_ID = ?, Price = ?, Capacity = ?, View = ?, Extendable = ? WHERE Room_ID = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(hotelId));
            pstmt.setInt(2, Integer.parseInt(price));
            pstmt.setInt(3, Integer.parseInt(capacity));
            pstmt.setString(4, view);
            pstmt.setBoolean(5, Boolean.parseBoolean(extendable));
            pstmt.setInt(6, Integer.parseInt(updateRoomId));

            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
                response.sendRedirect("manage_database.jsp");
%>

<h1>Update Successful</h1>
<%
} else {
%>
<div class="container">
<h3>Update Failed</h3>
</div>
<%
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        }
    }
%>
</body>
</html>
