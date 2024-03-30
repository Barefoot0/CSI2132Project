<%@ page import="java.sql.*" %>

<%
    String fullName = request.getParameter("full_name");
    String address = request.getParameter("address");
    String hotelId = request.getParameter("hotel_id");
    String ssnOrSin = request.getParameter("ssn_or_sin");

    if (fullName != null && address != null && hotelId != null && ssnOrSin != null) {
        String url = "jdbc:postgresql://localhost:5433/postgres";
        String username = "postgres";
        String password = "password";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("org.postgresql.Driver");

            conn = DriverManager.getConnection(url, username, password);

            String sql = "INSERT INTO website.Employee (Full_Name, Address, Hotel_ID, SSN_Or_SIN) VALUES (?, ?, ?, ?)";

            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, fullName);
            pstmt.setString(2, address);
            pstmt.setInt(3, Integer.parseInt(hotelId));
            pstmt.setString(4, ssnOrSin);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("manage_database.jsp");
%>
<p>Employee created successfully!</p>
<%
} else {
%>
<p>Error creating employee. Please try again.</p>
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