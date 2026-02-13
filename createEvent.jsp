<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String message = "";
    String messageClass = "success";

    if("POST".equalsIgnoreCase(request.getMethod())){
        try{
            String eventName = request.getParameter("event_name");
            String description = request.getParameter("description");
            String eventDate = request.getParameter("event_date");
            String eventTime = request.getParameter("event_time");
            String location = request.getParameter("location");

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/volunteer_db", "root", "root"
            );

            String sql = "INSERT INTO events (event_name, description, event_date, event_time, location, score) VALUES (?, ?, ?, ?, ?, 0)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, eventName);
            ps.setString(2, description);
            ps.setString(3, eventDate);
            ps.setString(4, eventTime);
            ps.setString(5, location);

            int rows = ps.executeUpdate();

            /* 🔔 NOTIFICATION INSERT (ADDED ONLY THIS PART) */
            if(rows > 0){

                String notifySql = "INSERT INTO notifications(message, role) VALUES (?, ?)";
                PreparedStatement notifyPS = con.prepareStatement(notifySql);

                notifyPS.setString(1, "Admin created new event: " + eventName);
                notifyPS.setString(2, "volunteer");

                notifyPS.executeUpdate();
                notifyPS.close();

                message = "Event created successfully!";
                messageClass = "success";

            } else {
                message = "Failed to create event.";
                messageClass = "error";
            }

            ps.close();
            con.close();

        } catch(Exception e){
            message = "Error: " + e.getMessage();
            messageClass = "error";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Create Event | Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
body {
    font-family: 'Poppins', sans-serif;
    background: #f9fafb; /* volunteer background */
    margin: 0;
    padding: 0;
    color: #1f2937;
}

/* ===== HEADER ===== */
.header {
    background: #111827; /* black */
    color: #ffffff;
    text-align: center;
    padding: 50px 20px;
    border-bottom-left-radius: 20px;
    border-bottom-right-radius: 20px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.15);
}

.header h2 {
    font-size: 32px;
    margin-bottom: 10px;
}

.header p {
    font-size: 16px;
    color: #fed7aa; /* light orange */
}

/* ===== CONTAINER ===== */
.container {
    width: 500px;
    max-width: 90%;
    margin: 40px auto;
    background: #ffffff;
    padding: 30px;
    border-radius: 18px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
    color: #1f2937;
    border-top: 4px solid #f97316; /* orange accent */
}

label {
    display: block;
    margin-top: 15px;
    font-weight: 500;
    color: #111827;
}

/* ===== INPUTS ===== */
input[type=text],
input[type=date],
input[type=time],
textarea {
    width: 100%;
    padding: 12px;
    margin-top: 6px;
    border-radius: 8px;
    border: 1px solid #e5e7eb;
    outline: none;
    font-size: 14px;
    background: #ffffff;
    color: #1f2937;
    transition: 0.3s;
}

input:focus,
textarea:focus {
    border-color: #f97316; /* orange focus */
}

textarea {
    resize: vertical;
    height: 100px;
}

input::placeholder,
textarea::placeholder {
    color: #6b7280;
}

/* ===== BUTTON ===== */
button {
    margin-top: 20px;
    width: 100%;
    padding: 12px;
    background: #111827; /* black */
    color: #fff;
    font-size: 16px;
    font-weight: 600;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: 0.3s;
}

button:hover {
    background: #f97316; /* orange */
}

/* ===== MESSAGES ===== */
.success {
    color: #065f46;
    background: #ecfdf5;
    border: 1px solid #a7f3d0;
    padding: 10px;
    border-radius: 6px;
    text-align: center;
    margin-bottom: 15px;
    font-weight: 600;
}

.error {
    color: #7c2d12;
    background: #fff7ed;
    border: 1px solid #fed7aa;
    padding: 10px;
    border-radius: 6px;
    text-align: center;
    margin-bottom: 15px;
    font-weight: 600;
}

/* ===== RESPONSIVE ===== */
@media(max-width: 600px){
    .container {
        width: 90%;
        padding: 20px;
    }
    .header h2 {
        font-size: 28px;
    }
}
</style>

<body>

<div class="header">
    <h2>Create New Event</h2>
    <p>Add a new event and keep volunteers organized with details and schedules.</p>
</div>

<div class="container">
    <% if(!message.isEmpty()){ %>
        <div class="<%= messageClass %>"><%= message %></div>
    <% } %>

    <form method="post" action="">
        <label>Event Name:</label>
        <input type="text" name="event_name" placeholder="Enter event name" required>

        <label>Description:</label>
        <textarea name="description" placeholder="Enter event description" required></textarea>

        <label>Event Date:</label>
        <input type="date" name="event_date" required>

        <label>Event Time:</label>
        <input type="time" name="event_time" required>

        <label>Location:</label>
        <input type="text" name="location" placeholder="Enter event location" required>

        <button type="submit">Create Event</button>
    </form>
</div>

</body>
</html>
