<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>


<!DOCTYPE html>
<html>
<head>
<title>Available Events | Volunteer</title>

<style>
:root{
    --primary:#f97316;      /* Orange */
    --secondary:#111827;    /* Black (accent) */
    --bg:#f9fafb;           /* Light background */
    --card:#ffffff;         /* White cards */
    --text:#1f2937;         /* Dark text */
    --border:#e5e7eb;
}

body{
    margin:0;
    font-family:"Segoe UI", Arial, sans-serif;
    background:var(--bg);
    color:var(--text);
}

h2{
    text-align:center;
    padding:25px;
    font-size:30px;
    color:var(--secondary); /* Black heading */
}

.container{
    display:flex;
    flex-wrap:wrap;
    justify-content:center;
    gap:25px;
    padding:20px 40px;
}

.card{
    width:320px;
    background:var(--card);
    border-radius:14px;
    padding:22px;
    box-shadow:0 8px 20px rgba(0,0,0,0.08);
    transition:transform 0.3s, box-shadow 0.3s;
    border-top:4px solid var(--primary);
}

.card:hover{
    transform:translateY(-6px);
    box-shadow:0 14px 30px rgba(0,0,0,0.12);
}

.card h3{
    margin-top:0;
    color:var(--primary); /* Orange event name */
}

.card p{
    margin:6px 0;
    line-height:1.5;
}

.card b{
    color:var(--secondary); /* Black labels */
}

.btn{
    margin-top:15px;
    width:100%;
    padding:12px;
    border:none;
    background:var(--secondary); /* Black button */
    color:#ffffff;
    border-radius:8px;
    font-size:15px;
    font-weight:600;
    cursor:pointer;
    transition:background 0.3s, transform 0.2s;
}

.btn:hover{
    background:var(--primary); /* Orange on hover */
    transform:translateY(-2px);
}

@media(max-width:900px){
    .container{
        padding:20px;
    }
    .card{
        width:90%;
    }
}
</style>

</head>

<body>

<h2>Available Events</h2>

<div class="container">

<%
try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/volunteer_db",
        "root","root"
    );

    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM events ORDER BY event_date"
    );
    ResultSet rs = ps.executeQuery();

    while(rs.next()){
%>

<div class="card">
    <h3><%= rs.getString("event_name") %></h3>
    <p><%= rs.getString("description") %></p>

    <p><b>Date:</b> <%= rs.getString("event_date") %></p>
    <p><b>Time:</b> <%= rs.getString("event_time") %></p>
    <p><b>Location:</b> <%= rs.getString("location") %></p>

    <form action="eventRegister.jsp" method="get">
        <input type="hidden" name="event_id" value="<%= rs.getInt("event_id") %>">
        <button class="btn">Register</button>
    </form>
</div>

<%
    }
    rs.close();
    ps.close();
    con.close();
}catch(Exception e){
    out.println("<p style='color:red;text-align:center;'>Error loading events: "+e.getMessage()+"</p>");
}
%>

</div>

</body>
</html>
