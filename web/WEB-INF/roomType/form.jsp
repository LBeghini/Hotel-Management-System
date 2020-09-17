<%--
  Created by IntelliJ IDEA.
  User: Lavinha
  Date: 5/3/2020
  Time: 12:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="/css/form.css">
    <title>Room Types</title>
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
    <form action="/roomTypes" id="form" <c:if test="${roomType == null}">method="POST" </c:if> >
        <h1><c:choose><c:when test="${roomType == null}">New</c:when><c:otherwise>Edit</c:otherwise></c:choose> Room Type</h1>
        <label for="name">Name</label>
        <input type="text" name="name" id="name" autocomplete="off" autofocus="autofocus"
               value="${roomType.getName()}">
        <label for="description">Description</label>
        <textarea name="description" id="description" cols="30" rows="5">${roomType.getDescription()}</textarea>
        <label for="daily_price">Daily Price</label>
        <input type="number" name="daily_price" id="daily_price" min="0.00" max="10000.00" step="0.01"
               value="${roomType.getDailyPrice()}">

        <div class="submit">
            <button onclick="window.history.go(-1);" type="button">Cancel</button>
            <input type="submit" value="Submit" id="button">
        </div>
    </form>
</div>
</body>

<script>
    function send(e){
        e.preventDefault();
        let url = "/roomTypes/${roomType.getId()}";

        fetch(url, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: new URLSearchParams({
                'name': document.getElementById("name").value,
                'description': document.getElementById("description").value,
                'daily_price': document.getElementById("daily_price").value
            }),
        }).then(resp => {   window.location.href = url });
    }

    if(document.getElementById("form").method !== "post"){
        document.getElementById("form").addEventListener("submit", send);
    }

</script>
</html>