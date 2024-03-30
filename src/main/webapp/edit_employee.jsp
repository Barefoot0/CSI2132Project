<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Employee</title>
    <style>
        .container {
            width: 50%;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 50px;
        }
        input[type="text"] {
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
    String editEmployeeId = request.getParameter("edit_employee_id");

    if (editEmployeeId != null) {
        String url = "jdbc:postgresql://localhost:5433/postgres";
        String username = "postgres";
        String password = "password";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.postgresql.Driver");

            conn = DriverManager.getConnection(url, username, password);

            String sql = "SELECT * FROM website.Employee WHERE Employee_ID = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(editEmployeeId));

            rs = pstmt.executeQuery();

            if (rs.next()) {
                String fullName = rs.getString("Full_Name");
                String address = rs.getString("Address");
                int hotelId = rs.getInt("Hotel_ID");
                String ssnOrSin = rs.getString("SSN_Or_SIN");
%>
<div class="container">
    <h2>Edit Employee Details</h2>
    <form action="#" method="post">
        <input type="hidden" name="edit_employee_id" value="<%=editEmployeeId%>">
        <label for="full_name">Full Name:</label>
        <input type="text" id="full_name" name="full_name" value="<%=fullName%>" required><br>

        <label for="address">Address:</label>
        <input type="text" id="address" name="address" value="<%=address%>" required><br>

        <label for="hotel_id">Hotel ID:</label>
        <input type="text" id="hotel_id" name="hotel_id" value="<%=hotelId%>" required><br>

        <label for="ssn_or_sin">SSN or SIN:</label>
        <input type="text" id="ssn_or_sin" name="ssn_or_sin" value="<%=ssnOrSin%>" required><br>

        <input type="submit" value="Update Employee">
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
    String updateEmployeeId = request.getParameter("edit_employee_id");
    if (updateEmployeeId != null) {
        String fullName = request.getParameter("full_name");
        String address = request.getParameter("address");
        String hotelId = request.getParameter("hotel_id");
        String ssnOrSin = request.getParameter("ssn_or_sin");

        String url = "jdbc:postgresql://localhost:5433/postgres";
        String username = "postgres";
        String password = "password";

        Connection conn = null;
        PreparedStatement pstmt = null;

        if (fullName != null && address != null && hotelId != null && ssnOrSin != null){

            try {
                Class.forName("org.postgresql.Driver");

                conn = DriverManager.getConnection(url, username, password);

                String sql = "UPDATE website.Employee SET Full_Name = ?, Address = ?, Hotel_ID = ?, SSN_Or_SIN = ? WHERE Employee_ID = ?";

                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, fullName);
                pstmt.setString(2, address);
                pstmt.setInt(3, Integer.parseInt(hotelId));
                pstmt.setString(4, ssnOrSin);
                pstmt.setInt(5, Integer.parseInt(updateEmployeeId));

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
