<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Select Hotel</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h2 {
            color: #333;
            font-size: 36px;
        }
        p {
            margin-bottom: 10px;
            font-size: 24px;
        }
        a {
            color: #007bff;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h2>Select a Hotel</h2>
    
    <% 
    String customerName = request.getParameter("customerName");
    String employeeId = request.getParameter("employeeID");
    
        String url = "jdbc:postgresql://localhost:5433/postgres";
        String username = "postgres";
        String password = "password";
    Connection connection = null;
    PreparedStatement hotelStatement = null;
    ResultSet hotelResultSet = null;
    
    try {
        Class.forName("org.postgresql.Driver");
        connection = DriverManager.getConnection(url, username, password);
        
        String hotelQuery = "SELECT DISTINCT hotel_chain_name FROM website.Hotel";
        hotelStatement = connection.prepareStatement(hotelQuery);
        hotelResultSet = hotelStatement.executeQuery();
        
        while (hotelResultSet.next()) {
            String hotelName = hotelResultSet.getString("hotel_chain_name");
            
            System.out.println("<p><a href='viewRooms.jsp?hotelName=" + hotelName + "&customerName=" + customerName + "&employeeId=" + employeeId + "'>" + hotelName + "</a></p>");
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("<div>" + e.getMessage() +  "</div>");
    } finally {
        try {
            if (hotelResultSet != null) hotelResultSet.close();
            if (hotelStatement != null) hotelStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    %>
    
</body>
</html>
