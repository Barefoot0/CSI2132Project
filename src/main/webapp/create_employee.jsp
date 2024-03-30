<%@ page import="java.sql.*" %>

<%
    String fullName = request.getParameter("full_name");
    String address = request.getParameter("address");
    String hotelId = request.getParameter("hotel_id");
    String ssnOrSin = request.getParameter("ssn_or_sin");

    if (fullName != null && address != null && hotelId != null && ssnOrSin != null) {
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

            // SQL query to insert an employee into the database
            String sql = "INSERT INTO website.Employee (Full_Name, Address, Hotel_ID, SSN_Or_SIN) VALUES (?, ?, ?, ?)";

            // Create a PreparedStatement object to execute the SQL query
            pstmt = conn.prepareStatement(sql);

            // Set the parameters for the PreparedStatement
            pstmt.setString(1, fullName);
            pstmt.setString(2, address);
            pstmt.setInt(3, Integer.parseInt(hotelId));
            pstmt.setString(4, ssnOrSin);

            // Execute the SQL query to insert the employee into the database
            int rowsAffected = pstmt.executeUpdate();

            // Check if the insertion was successful
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