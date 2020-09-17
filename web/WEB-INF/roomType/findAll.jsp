<%--
  Created by IntelliJ IDEA.
  User: Lavinha
  Date: 5/3/2020
  Time: 7:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../css/find.css">
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
    <h1>Room Types</h1>
    <div class="updateRoomType">
        <label for="arrival">Arrival</label>
        <label for="departure">Departure</label>
        <input type="date" id="arrival" name="arrival">
        <input type="date" id="departure" name="departure">
    </div>
    <div class="over">
        <table>
            <thead>
                <tr><th>Name</th><th>Description</th><th>Daily Price</th><th>Available Rooms</th></tr>
            </thead>
            <tbody>
            <c:forEach items="${roomTypeList}" var="roomType">
                <tr onclick="window.location.href='/roomTypes/${roomType.getId()}';"><td>${roomType.getName()}</td><td>${roomType.getDescription()}</td><td>$${roomType.getDailyPrice()}</td><td class="count"> - </td></tr>
            </c:forEach>

            </tbody>
        </table>
    </div>

    </table>
    <div class="submit">
        <button onclick="window.location.href='/roomTypes/new';">New Room Type</button>
    </div>
</div>

</body>
<script>
    document.getElementById("departure").oninput = function () {
        let rts = document.querySelectorAll(".count");
        if(validate()){
            if((document.getElementById("departure").value !== "") && (document.getElementById("arrival").value !== "")){
                let url = "/api/count?arrival="+ document.getElementById("arrival").value + "&departure=" + document.getElementById("departure").value;
                fetch(url, {
                    method: 'GET',
                }).then(resp => resp.json())
                    .then(data => {
                        let i = 0;
                        for(let x of rts){
                            x.innerHTML = data[i].count;
                            i++;
                        }
                    });
            }
        }else{
            for(let x of rts){
                x.innerHTML= '-';
            }
        }
    }

    document.getElementById("arrival").oninput = function () {
        let rts = document.querySelectorAll(".count");
        if(validate()){
            if ((document.getElementById("departure").value !== "") && (document.getElementById("arrival").value !== "")) {
                let url = "/api/count?arrival="+ document.getElementById("arrival").value + "&departure=" + document.getElementById("departure").value;
                fetch(url, {
                    method: 'GET',
                }).then(resp => resp.json())
                    .then(data => {
                        for (let i=0; i<data.length; i++) {
                            for(let x of rts){
                                x.innerHTML = data[i].count;
                            }
                        }
                    });
            }
        }else{
            for(let x of rts){
                x.innerHTML= '-';
            }
        }
    }

    function validate() {
        if(document.getElementById("arrival").value >= document.getElementById("departure").value){
            document.getElementById("arrival").setCustomValidity("Date start is bigger than date end.");
            return false;
        }else{
            document.getElementById("arrival").setCustomValidity("");
            return true;
        }
    }
</script>
</html>