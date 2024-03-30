<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
  // Check if form data is submitted for creating a customer
  String fullName = request.getParameter("full_name_c");
  String address = request.getParameter("address_c");
  String idType = request.getParameter("id_type");
  String date = request.getParameter("date_input");

  SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

  if (fullName != null && address != null && idType != null && date != null) {



    // Database connection parameters
    String url = "jdbc:postgresql://localhost:5433/postgres";
    String username = "postgres";
    String password = "password";

    // JDBC variables
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {

      Date registrationDate = dateFormat.parse(date);
      Class.forName("org.postgresql.Driver");

      // Establish a connection to the database
      conn = DriverManager.getConnection(url, username, password);

      // SQL query to insert a customer into the database
      String sql = "INSERT INTO website.Customer (Full_Name, Address, ID_Type, Registration_Date) VALUES (?, ?, ?, ?)";

      // Create a PreparedStatement object to execute the SQL query
      pstmt = conn.prepareStatement(sql);

      // Set the parameters for the PreparedStatement
      pstmt.setString(1, fullName);
      pstmt.setString(2, address);
      pstmt.setString(3, idType);
      pstmt.setDate(4, new java.sql.Date(registrationDate.getTime()));

      // Execute the SQL query to insert the customer into the database
      int rowsAffected = pstmt.executeUpdate();

      // Check if the insertion was successful
      if (rowsAffected > 0) {
        response.sendRedirect("manage_database.jsp");
%>
<p>Customer created successfully!</p>
<%
} else {
%>
<p>Error creating customer. Please try again.</p>
<%
  }
} catch (SQLException | ClassNotFoundException e) {
  e.printStackTrace();
%>
<p>Database error occurred. Please try again later.</p>
<%
    } catch (java.text.ParseException e){
      e.printStackTrace();
    }finally {
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
