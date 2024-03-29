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
        .return-button {
            position: fixed; /* Position the button relative to the browser window */
            bottom: 20px; /* Set the distance from the bottom */
            left: 50%; /* Set the button to the center horizontally */
            transform: translateX(-50%); /* Center the button horizontally */
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
<button class="back-button" onclick="window.location.href='manage_database.jsp'">Back</button>
<body>
<%
    // Process form submission
    String editRoomId = request.getParameter("edit_room_id");

    if (editRoomId != null) {
        // Database connection parameters
        String url = "jdbc:postgresql://localhost:5433/postgres";
        String username = "postgres";
        String password = "password";

        // JDBC variables
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.postgresql.Driver");

            // Establish a connection to the database
            conn = DriverManager.getConnection(url, username, password);

            // SQL query to retrieve room details
            String sql = "SELECT * FROM website.Room WHERE Room_ID = ? FOR UPDATE";

            // Create a PreparedStatement object to execute the SQL query
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(editRoomId));

            // Execute the SQL query to retrieve room details
            rs = pstmt.executeQuery();

            // Check if room record exists
            if (rs.next()) {
                // Retrieve room details
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
            } else {
                // Handle case where no room with given ID is found
                // You can display an appropriate message here
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            // Handle database connection or query errors
        } finally {
            // Close the ResultSet, PreparedStatement, and database connection
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle closing connection errors
            }
        }
    } else {
        // Handle case where room ID parameter is not provided
    }
%>
<%
    // Process form submission for updating room details
    String updateRoomId = request.getParameter("edit_room_id");
    if (updateRoomId != null) {
        String hotelId = request.getParameter("hotel_id");
        String price = request.getParameter("price");
        String capacity = request.getParameter("capacity");
        String view = request.getParameter("view");
        String extendable = request.getParameter("extendable") != null ? "true" : "false";

        // Database connection parameters
        String url = "jdbc:postgresql://localhost:5433/postgres";
        String username = "postgres";
        String password = "password";

        // JDBC variables
        Connection conn = null;
        PreparedStatement pstmt = null;

        if (hotelId != null && price != null && capacity != null && view != null && extendable != null){

        try {
            Class.forName("org.postgresql.Driver");

            // Establish a connection to the database
            conn = DriverManager.getConnection(url, username, password);

            // SQL query to update room details
            String sql = "UPDATE website.room SET Hotel_ID = ?, Price = ?, Capacity = ?, View = ?, Extendable = ? WHERE Room_ID = ?";

            // Create a PreparedStatement object to execute the SQL query
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(hotelId));
            pstmt.setInt(2, Integer.parseInt(price));
            pstmt.setInt(3, Integer.parseInt(capacity));
            pstmt.setString(4, view);
            pstmt.setBoolean(5, Boolean.parseBoolean(extendable));
            pstmt.setInt(6, Integer.parseInt(updateRoomId));

            // Execute the SQL query to update room details
            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
%>

<h1>Update Successful</h1>
<button class="return-button" onclick="window.location.href='manage_database.jsp'">Return</button>
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
            // Handle database connection or query errors
        } finally {
            // Close the PreparedStatement and database connection
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle closing connection errors
            }
        }
        }
    }
%>
</body>
</html>
