<%@ page import="java.sql.*" %>

<%
    String createRoomHotelId = request.getParameter("create_room_hotel_id");
    String createRoomPrice = request.getParameter("create_room_price");
    String createRoomCapacity = request.getParameter("create_room_capacity");
    String createRoomView = request.getParameter("create_room_view");
    String createRoomExtendable = request.getParameter("create_room_extendable");

    if (createRoomHotelId != null && createRoomPrice != null && createRoomCapacity != null &&
            createRoomView != null && createRoomExtendable != null) {
        String url = "jdbc:postgresql://localhost:5433/postgres";
        String username = "postgres";
        String password = "password";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("org.postgresql.Driver");

            conn = DriverManager.getConnection(url, username, password);

            String sql = "INSERT INTO website.Room (Hotel_ID, Price, Capacity, View, Extendable) VALUES (?, ?, ?, ?, ?)";

            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, Integer.parseInt(createRoomHotelId));
            pstmt.setInt(2, Integer.parseInt(createRoomPrice));
            pstmt.setInt(3, Integer.parseInt(createRoomCapacity));
            pstmt.setString(4, createRoomView);
            pstmt.setBoolean(5, Boolean.parseBoolean(createRoomExtendable));

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("manage_database.jsp");
%>
<h2>Room Created Successfully</h2>
<%
} else {
%>
<h2>Error creating room. Please try again.</h2>
<%
    }
} catch (SQLException | ClassNotFoundException e) {
    e.printStackTrace();
%>
<h2>Database error occurred. Please try again later.</h2>
<%
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
