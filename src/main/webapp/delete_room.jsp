<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

<%
    String deleteRoomId = request.getParameter("delete_room_id");
    if (deleteRoomId != null) {
        String url = "jdbc:postgresql://localhost:5433/postgres";
        String username = "postgres";
        String password = "password";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("org.postgresql.Driver");

            conn = DriverManager.getConnection(url, username, password);

            String sql = "DELETE FROM website.Room WHERE Room_ID = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(deleteRoomId));

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("manage_database.jsp");
%>
<h2>Room Deleted Successfully</h2>
<%
} else {
%>
<p>No room found with ID <%=deleteRoomId%>.</p>
<%
    }
} catch (SQLException | ClassNotFoundException e) {
    e.printStackTrace();
%>
<p>Database error occurred. Please try again later.</p>
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
