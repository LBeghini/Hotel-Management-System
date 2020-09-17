<%--
  Created by IntelliJ IDEA.
  User: Lavinha
  Date: 5/3/2020
  Time: 12:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../css/find.css">
    <title>Staff</title>
    <meta name="viewport" content="width=device-width, user-scalable=0">
</head>
<body>
<header>
    <div class="logo" onclick="window.location.href='/dashboard';">
        <h1>HMS</h1>
    </div>
    <nav>
        <a href="/bookings/">Bookings</a><a href="/guests/">Guests</a></a><a href="/rooms/">Rooms</a><a href="/roomTypes/">Room Types</a>
    </nav>
    <div class="user">
        <h2>${sessionStaff.getName()}</h2>
        <a href="/auth/logout">Logout</a>
    </div>
</header>
<div class="content">
    <h1>Staff</h1>
    <div class="over">
        <table>
            <thead>
                <tr><th>Name</th><th>Access Level</th><th>Login</th><th colspan="2">Action</th></tr>
            </thead>
            <tbody>
            <c:forEach items="${staffList}" var="staff">
                <tr onclick="window.location.href='/staff/${staff.getId()}';"><td>${staff.getName()}</td><td>${staff.getAccessLevel()}</td><td>${staff.getLogin()}</td></tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    </table>
    <div class="submit">
        <button onclick="window.location.href='/staff/new';">New Staff</button>
    </div>
</div>


<script>
    function link(id) {
        console.log(id);
        let url = "/staff/"+ id;

        fetch(url, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
        }).then(resp => {   window.location.href = "/staff" });
    }
</script>
</html>
