<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Customer</title>
    <style>
        .container {
            width: 50%;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 50px;
        }
        input[type="text"], input[type="date"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
        }
        input[type="date"], select {
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
    String editCustomerId = request.getParameter("edit_customer_id");

    if (editCustomerId != null) {
        String url = "jdbc:postgresql://localhost:5433/postgres";
        String username = "postgres";
        String password = "password";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.postgresql.Driver");

            conn = DriverManager.getConnection(url, username, password);

            String sql = "SELECT * FROM website.Customer WHERE Customer_ID = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(editCustomerId));

            rs = pstmt.executeQuery();

            if (rs.next()) {
                String fullName = rs.getString("Full_Name");
                String address = rs.getString("Address");
                String idType = rs.getString("ID_Type");
                Date registrationDate = rs.getDate("Registration_Date");
%>
<div class="container">
    <h2>Edit Customer Details</h2>
    <form action="#" method="post">
        <input type="hidden" name="edit_customer_id" value="<%=editCustomerId%>">
        <label for="full_name">Full Name:</label>
        <input type="text" id="full_name" name="full_name" value="<%=fullName%>" required><br>

        <label for="address">Address:</label>
        <input type="text" id="address" name="address" value="<%=address%>" required><br>

        <label for="id_type">ID Type:</label>
        <select id="id_type" name="id_type" required>
            <option value="SIN" <%= idType.equals("SIN") ? "selected" : "" %>>SIN</option>
            <option value="SSN" <%= idType.equals("SSN") ? "selected" : "" %>>SSN</option>
            <option value="Driver Licence" <%= idType.equals("Driver Licence") ? "selected" : "" %>>Driver Licence</option>
        </select><br>

        <label for="registration_date">Registration Date:</label>
        <input type="date" id="registration_date" name="registration_date" value="<%=registrationDate.toString()%>" required><br>

        <input type="submit" value="Update Customer">
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
    String updateCustomerId = request.getParameter("edit_customer_id");
    if (updateCustomerId != null) {
        String fullName = request.getParameter("full_name");
        String address = request.getParameter("address");
        String idType = request.getParameter("id_type");
        String registrationDate = request.getParameter("registration_date");

        String url = "jdbc:postgresql://localhost:5433/postgres";
        String username = "postgres";
        String password = "password";

        Connection conn = null;
        PreparedStatement pstmt = null;

        if (fullName != null && address != null && idType != null && registrationDate != null) {

            try {
                Class.forName("org.postgresql.Driver");

                conn = DriverManager.getConnection(url, username, password);

                String sql = "UPDATE website.Customer SET Full_Name = ?, Address = ?, ID_Type = ?, Registration_Date = ? WHERE Customer_ID = ?";

                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, fullName);
                pstmt.setString(2, address);
                pstmt.setString(3, idType);
                pstmt.setDate(4, Date.valueOf(registrationDate));
                pstmt.setInt(5, Integer.parseInt(updateCustomerId));

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
