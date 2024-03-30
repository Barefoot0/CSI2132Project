<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

<%
    // Check if form data is submitted for deleting a room
    String deleteRoomId = request.getParameter("delete_room_id");
    if (deleteRoomId != null) {
        // Database connection parameters
        String url = "jdbc:postgresql://localhost:5433/postgres";
        String username = "postgres";
        String password = "password";

        // JDBC variables
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("org.postgresql.Driver");

            // Establish a connection to the database
            conn = DriverManager.getConnection(url, username, password);

            // SQL query to delete room record
            String sql = "DELETE FROM website.Room WHERE Room_ID = ?";

            // Create a PreparedStatement object to execute the SQL query
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(deleteRoomId));

            // Execute the SQL query to delete the room record
            int rowsAffected = pstmt.executeUpdate();

            // Check if deletion was successful
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
