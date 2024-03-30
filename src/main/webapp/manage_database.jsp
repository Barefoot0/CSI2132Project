<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Database</title>
    <style>
        .container {
            width: 50%;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 50px;
        }
        input[type="text"], select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
        }
        input[type="number"], select {
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
        input[type="email"], select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
        }
        input[type="tel"], select {
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
<body>
<div class="container">
<h1>Edit Database</h1>
<button class="back-button" onclick="window.location.href='home_page.jsp'">Back</button>
<form action="#" method="post">
    <div class="input-wrapper">
    <label for="selectOption">Select Option:</label>
    <select id="selectOption" name="selectOption">
        <option value="" selected disabled>Select an option</option>
        <option value="employee">Employee</option>
        <option value="customer">Customer</option>
        <option value="hotel">Hotel</option>
        <option value="room">Room</option>
    </select>

    <label for="action">Select Action:</label>
    <select id="action" name="action">
        <option value="" selected disabled>Select an action</option>
        <option value="create">Create</option>
        <option value="edit">Edit</option>
        <option value="delete">Delete</option>
    </select>

    <input type="submit" value="Submit">
    </div>
</form>


<%
    String selectedOption = request.getParameter("selectOption");
    String selectedAction = request.getParameter("action");
    if (selectedOption != null && selectedAction != null) {
        if (selectedOption.equals("employee")) {
            if (selectedAction.equals("create")) {
%>
    <div class="container">
        <h2>Create Employee</h2>
        <form action="create_employee.jsp" method="post">
            <label for="full_name">Full Name:</label>
            <input type="text" id="full_name" name="full_name"><br>

            <label for="address">Address:</label>
            <input type="text" id="address" name="address"><br>

            <label for="hotel_id">Hotel ID:</label>
            <input type="number" id="hotel_id" name="hotel_id"><br>

            <label for="ssn_or_sin">SSN or SIN:</label>
            <input type="text" id="ssn_or_sin" name="ssn_or_sin"><br>

            <input type="submit" value="Create Employee">
        </form>
    </div>
<%
} else if (selectedAction.equals("edit")) {
%>
<div class="container">
    <h2>Edit Employee</h2>
    <form action="edit_employee.jsp" method="post">
        <label for="edit_employee_id">Employee ID:</label>
        <input type="text" id="edit_employee_id" name="edit_employee_id" required><br>
        <input type="submit" value="Retrieve Employee Details">
    </form>
</div>
<%
} else
if (selectedAction.equals("delete")) {
%>
    <div class="container">
        <h2>Delete Employee</h2>
        <form action="delete_employee.jsp" method="post">
            <label for="delete_employee_id">Employee ID:</label>
            <input type="text" id="delete_employee_id" name="delete_employee_id" required><br>
            <input type="submit" value="Delete Employee">
        </form>
    </div>
        <%
}

    } else if (selectedOption.equals("customer")) {
            if (selectedAction.equals("create")) {
%>
    <div class="container">
        <h2>Create Customer</h2>
        <form action="create_customer.jsp" method="post">
            <label for="full_name_c">Full Name:</label>
            <input type="text" id="full_name_c" name="full_name_c"><br>

            <label for="address_c">Address:</label>
            <input type="text" id="address_c" name="address_c"><br>

            <label for="id_type">ID Type:</label>
            <select name="id_type" id="id_type">
                <option value="SIN">SIN</option>
                <option value="SSN">SSN</option>
                <option value="Driver's License">Driver's License</option>
            </select>

            <label for="date_input">Date:</label>
            <input type="date" id="date_input" name="date_input">

            <input type="submit" value="Create Customer">
        </form>
    </div>
        <%
} else if (selectedAction.equals("edit")) {
%>
<div class="container">
    <h2>Edit Customer</h2>
    <form action="edit_customer.jsp" method="post">
        <label for="edit_customer_id">Customer ID:</label>
        <input type="text" id="edit_customer_id" name="edit_customer_id" required><br>
        <input type="submit" value="Retrieve Customer Details">
    </form>
</div>
<%
} else if (selectedAction.equals("delete")) {
%>
    <div class="container">
        <h2>Delete Customer</h2>
        <form action="delete_customer.jsp" method="post">
            <label for="delete_customer_id">Customer ID:</label>
            <input type="text" id="delete_customer_id" name="delete_customer_id" required><br>
            <input type="submit" value="Delete Customer">
        </form>
    </div>
<%
}
        } else if (selectedOption.equals("hotel")) {
if (selectedAction.equals("create")) {
%>
    <div class="container">
        <h2>Create Hotel</h2>
        <form action="create_hotel.jsp" method="post">
            <label for="create_hotel_name">Hotel Name:</label>
            <input type="text" id="create_hotel_name" name="create_hotel_name" required><br>

            <label for="create_hotel_rating">Rating:</label>
            <input type="number" id="create_hotel_rating" name="create_hotel_rating" required min="1"><br>

            <label for="create_hotel_rooms">Number of Rooms:</label>
            <input type="number" id="create_hotel_rooms" name="create_hotel_rooms" required min="1"><br>

            <label for="create_hotel_address">Address:</label>
            <input type="text" id="create_hotel_address" name="create_hotel_address" required><br>

            <label for="create_hotel_email">Contact Email:</label>
            <input type="email" id="create_hotel_email" name="create_hotel_email" required><br>

            <label for="create_hotel_phone_number">Contact Phone Number:</label>
            <input type="tel" id="create_hotel_phone_number" name="create_hotel_phone_number" required><br>

            <label for="create_hotel_chain">Hotel Chain Name:</label>
            <input type="text" id="create_hotel_chain" name="create_hotel_chain" required><br>

            <input type="submit" value="Create Hotel">
        </form>
    </div>
        <%
}
    if (selectedAction.equals("edit")) {
%>
<div class="container">
<form action="edit_hotel.jsp" method="get">
    <label for="hotel_id_h">Hotel ID:</label>
    <input type="text" id="hotel_id_h" name="hotel_id_h" required><br>
    <input type="submit" value="Retrieve Hotel Details">
</form>
</div>
<%
                    }
    if (selectedAction.equals("delete")) {
%>
    <div class="container">
        <h2>Delete Hotel</h2>
        <form action="delete_hotel.jsp" method="post">
            <label for="delete_hotel_id">Hotel ID:</label>
            <input type="text" id="delete_hotel_id" name="delete_hotel_id" required><br>
            <input type="submit" value="Delete Hotel">
        </form>
    </div>
        <%
    }
        } else if (selectedOption.equals("room")) {
    if (selectedAction.equals("create")) {
%>
    <div class="container">
        <h2>Create Room</h2>
        <form action="create_room.jsp" method="post">
            <label for="create_room_hotel_id">Hotel ID:</label>
            <input type="text" id="create_room_hotel_id" name="create_room_hotel_id" required><br>

            <label for="create_room_price">Price:</label>
            <input type="number" id="create_room_price" name="create_room_price" required min="0"><br>

            <label for="create_room_capacity">Capacity:</label>
            <input type="number" id="create_room_capacity" name="create_room_capacity" required min="1"><br>

            <label for="create_room_view">View:</label>
            <select id="create_room_view" name="create_room_view" required>
                <option value=""></option>
                <option value="Sea">Sea</option>
                <option value="Mountain">Mountain</option>
            </select><br>

            <label for="create_room_extendable">Extendable:</label>
            <select id="create_room_extendable" name="create_room_extendable" required>
                <option value="true">Yes</option>
                <option value="false">No</option>
            </select><br>

            <input type="submit" value="Create Room">
        </form>
    </div>
        <%
}
        else if (selectedAction.equals("edit")){
%>
    <div class=container>
        <form action="edit_room.jsp" method="get">
            <label for="edit_room_id">Room ID:</label>
            <input type="text" id="edit_room_id" name="edit_room_id" required><br>
            <input type="submit" value="Retrieve Room Details">
        </form>
    </div>
        <%
        }else if (selectedAction.equals("delete")) {
            %>
    <div class="container">
        <h2>Delete Room</h2>
        <form action="delete_room.jsp" method="post">
            <label for="delete_room_id">Room ID:</label>
            <input type="text" id="delete_room_id" name="delete_room_id" required><br>
            <input type="submit" value="Delete Room">
        </form>
    </div>
        <%
        }
        }
        }
        %>
</body>
</html>