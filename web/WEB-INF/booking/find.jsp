<%--
  Created by IntelliJ IDEA.
  User: Lavinha
  Date: 5/3/2020
  Time: 12:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="../css/one.css">
    <title>Booking</title>
    <meta name="viewport" content="width=device-width, user-scalable=0">
</head>
<body onload="action('${booking.getStatus().toLowerCase()}')">
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
    <div class="model">
        <h1>Booking</h1>
        <h3>${booking.getStatus()}</h3>
    </div>

    <div class="edit">
        <button class="delete" onclick="openModalDelete(${booking.getId()})">Delete</button>
        <button onclick="window.location.href='/bookings/${booking.getId()}/edit';">Edit</button>
    </div>
    <div class="about">
        <h2>About</h2>
        <div class="property">
            <span class="label">ID</span>
            <span class="data">${booking.getId()}</span>
        </div>
        <div class="property">
            <span class="label">Arrival</span>
            <span class="data">${booking.getArrival()}</span>
        </div>
        <div class="property">
            <span class="label">Departure</span>
            <span class="data">${booking.getDeparture()}</span>
        </div>
        <div class="property link" onclick="window.location.href='/guests/${booking.getIdGuest()}';">
            <span class="label">Guest</span>
            <span class="data">${booking.getGuest().getName()}</span>
        </div>
        <div class="property link" onclick="window.location.href='/rooms/${booking.getIdRoom()}';">
            <span class="label">Room Number</span>
            <span class="data">${booking.getRoom().getNumber()}</span>
        </div>
        <div class="property">
            <span class="label">Total</span>
            <span class="data">$${booking.getTotal()}</span>
        </div>
    </div>
    <div class="checkin">
        <div class="checkin-info">
            <h2>Checkin</h2>
            <div class="property">
                <span class="label">Timestamp</span>
                <span class="data">${checkin.getCheck()}</span>
            </div>
        </div>
        <button id="do-checkin" onclick="openModalCheck(true, ${booking.getId()}, ${booking.getRoom().getNumber()})">Checkin</button>
    </div>
    <div class="checkout">
        <div class="checkout-info">
            <h2>Checkout</h2>
            <div class="property">
                <span class="label">Timestamp</span>
                <span class="data">${checkout.getCheck()}</span>
            </div>
        </div>
        <button id="do-checkout" onclick="openModalCheck(false, ${booking.getId()}, ${booking.getRoom().getNumber()})">Checkout</button>
    </div>
</div>
<div class="modal" id="modal-delete">
    <div class="modal-content">
        <div class="modal-header">
            <h1>Delete</h1>
        </div>
        <div class="modal-body" id="sure">
        </div>
        <div class="modal-footer">
            <button onclick="cancel()" type="button">Cancel</button>
            <button onclick="link(${booking.getId()})" class="cancel"> Delete </button>
        </div>
    </div>
</div>

<div class="modal" id="modal-check">
    <div class="modal-content">
        <div class="modal-header">
            <h1 id="title"></h1>
        </div>
        <div class="modal-body">
            <form action="/checks" id="form" method="POST">
                <label for="check">Timestamp</label>
                <input type="datetime-local" name="check" id="check" autocomplete="off" readonly>
                <label for="id_booking">Booking</label>
                <input type="text" name="id_booking" id="id_booking" readonly>
                <label for="room_number">Room</label>
                <input type="text" name="room_number" id="room_number" readonly>
                <input type="number" name="status" id="status" style="display: none">
                <input type="number" style="display: none" name="id_staff" id="id_staff" value="${sessionStaff.getId()}">
                <div class="modal-footer">
                    <button onclick="cancel()" type="button">Cancel</button>
                    <input type="submit" value="Submit" id="button">
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<script>
    let modalDelete = document.getElementById("modal-delete");
    let modalCheck = document.getElementById("modal-check");
    let title = document.getElementById("title");

    function openModalDelete(booking) {
        modalDelete.style.display = "flex";
        document.getElementById("sure").innerHTML = "Delete booking " + booking + "?";
    }

    function cancel(){
        modalDelete.style.display = "none";
        modalCheck.style.display = "none";
    }

    function link(id) {
        let url = "/bookings/"+ id;
        fetch(url, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
        }).then(resp => {   window.location.href = "/bookings" });
    }

    function openModalCheck(test, booking, room) {
        if(test){
            title.innerHTML = "Checkin";
            document.getElementById("status").value = 1;
        }else{
            title.innerHTML = "Checkout";
            document.getElementById("status").value = 0;
        }
        modalCheck.style.display = "flex";
        document.getElementById("id_booking").value = booking;
        document.getElementById("room_number").value = room;
        let now = new Date();
        now.setHours(now.getHours() - 3); //because of the timezone
        document.getElementById("check").value = now.toISOString().substring(0, 16);
    }

    window.onclick = function(event) {
        if (event.target === modalCheck || event.target === modalDelete) {
            modalCheck.style.display = "none";
        }
    };

    function action(operation){
        let checkin_info = document.querySelector(".checkin-info");
        let do_checkin = document.querySelector("#do-checkin");
        let checkout_info = document.querySelector(".checkout-info");
        let do_checkout = document.querySelector("#do-checkout");

        if(operation === "booked"){
            checkin_info.style.display = "none";
            do_checkin.style.display = "block";
            do_checkout.style.display = "none";
            checkout_info.style.display = "none";
        }else if(operation === "arrived"){
            checkin_info.style.display = "grid";
            do_checkin.style.display = "none";
            do_checkout.style.display = "block";
            checkout_info.style.display = "none";
        }else if(operation === "departed"){
            checkin_info.style.display = "grid";
            do_checkin.style.display = "none";
            do_checkout.style.display = "none";
            checkout_info.style.display = "grid";
        }
    }

</script>
</html>