<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
  String fullName = request.getParameter("full_name_c");
  String address = request.getParameter("address_c");
  String idType = request.getParameter("id_type");
  String date = request.getParameter("date_input");

  SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

  if (fullName != null && address != null && idType != null && date != null) {



    String url = "jdbc:postgresql://localhost:5433/postgres";
    String username = "postgres";
    String password = "password";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {

      Date registrationDate = dateFormat.parse(date);
      Class.forName("org.postgresql.Driver");

      conn = DriverManager.getConnection(url, username, password);

      String sql = "INSERT INTO website.Customer (Full_Name, Address, ID_Type, Registration_Date) VALUES (?, ?, ?, ?)";

      pstmt = conn.prepareStatement(sql);

      pstmt.setString(1, fullName);
      pstmt.setString(2, address);
      pstmt.setString(3, idType);
      pstmt.setDate(4, new java.sql.Date(registrationDate.getTime()));

      int rowsAffected = pstmt.executeUpdate();

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
      try {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }
  }
%>
