<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Volunteer Registrations</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
   <style>

/* ===== GLOBAL ===== */
body {
    margin: 0;
    font-family: 'Poppins', 'Segoe UI', sans-serif;
    background: #f9fafb;
    color: #1f2937;
}

/* ===== HEADER BAR ===== */
.navbar {
    padding: 20px 40px;
    background: #111827;   /* black */
    color: #ffffff;
    font-size: 22px;
    font-weight: 600;
}

/* ===== PAGE TITLE ===== */
h2 {
    text-align: center;
    margin: 30px 0 20px;
    color: #111827;
    font-weight: 600;
}

/* ===== TABLE CARD ===== */
.table-card {
    width: 95%;
    margin: 20px auto 40px;
    background: #ffffff;
    border-radius: 16px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.08);
    padding: 20px;
    overflow-x: auto;
    border-top: 4px solid #f97316; /* orange accent */
}

/* ===== TABLE ===== */
table {
    width: 100%;
    border-collapse: collapse;
    min-width: 1100px;
}

/* Table Header */
th {
    background: #111827;  /* black */
    color: #ffffff;
    padding: 14px;
    font-size: 14px;
    font-weight: 600;
}

/* Table Data */
td {
    padding: 12px 14px;
    text-align: center;
    border-bottom: 1px solid #e5e7eb;
    font-size: 14px;
}

/* Hover Effect */
tr:hover {
    background-color: #fff7ed; /* light orange */
    transition: 0.3s;
}

/* ===== STATUS BADGES ===== */
.status {
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
    color: white;
    display: inline-block;
}

.pending {
    background-color: #f59e0b;  /* amber */
}

.approved {
    background-color: #16a34a;  /* green */
}

.rejected {
    background-color: #dc2626;  /* red */
}

/* ===== BUTTONS ===== */
.btn {
    padding: 7px 14px;
    border: none;
    border-radius: 12px;
    cursor: pointer;
    font-size: 13px;
    font-weight: 600;
    transition: 0.3s;
}

/* Approve */
.approve {
    background-color: #111827;   /* black */
    color: white;
    margin-right: 6px;
}

.approve:hover {
    background-color: #16a34a;
    transform: scale(1.05);
}

/* Reject */
.reject {
    background-color: #f97316;  /* orange */
    color: white;
}

.reject:hover {
    background-color: #dc2626;
    transform: scale(1.05);
}

form {
    display: inline;
}

</style>

</head>
<body>

<div class="navbar">
    Cloud-Based Volunteer Coordination System — Admin Dashboard
</div>

<h2>Volunteer Registrations</h2>

<div class="table-card">
<table>
    <tr>
        <th>ID</th>
        <th>Full Name</th>
        <th>Email</th>
        <th>Mobile</th>
        <th>Event</th>
        <th>Skill</th>
        <th>Availability</th>
        <th>Status</th>
        <th>Actions</th>
    </tr>

<%
try {
    Class.forName("com.mysql.jdbc.Driver"); 
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/volunteer_db","root","root");

    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery(
        "SELECT r.registration_id, r.full_name, r.email, r.mobile, r.skill, r.availability, r.status, e.event_name " +
        "FROM event_registrations r " +
        "JOIN events e ON r.event_id = e.event_id " +
        "ORDER BY r.registration_date DESC"
    );

    while(rs.next()) {
        String status = rs.getString("status");
%>
<tr>
    <td><%= rs.getInt("registration_id") %></td>
    <td><%= rs.getString("full_name") %></td>
    <td><%= rs.getString("email") %></td>
    <td><%= rs.getString("mobile") %></td>
    <td><%= rs.getString("event_name") %></td>
    <td><%= rs.getString("skill") %></td>
    <td><%= rs.getString("availability") %></td>
    <td>
        <span class="status <%= "Pending".equals(status) ? "pending" : 
            "Approved".equals(status) ? "approved" : "rejected" %>">
            <%= status %>
        </span>
    </td>
    <td>
        <% if("Pending".equals(status)) { %>
            <form method="post" action="update_registration_status.jsp">
                <input type="hidden" name="registration_id" value="<%= rs.getInt("registration_id") %>">
                <input type="hidden" name="status" value="Approved">
                <button class="btn approve"><i class="fa fa-check"></i> Approve</button>
            </form>

            <form method="post" action="update_registration_status.jsp">
                <input type="hidden" name="registration_id" value="<%= rs.getInt("registration_id") %>">
                <input type="hidden" name="status" value="Rejected">
                <button class="btn reject"><i class="fa fa-times"></i> Reject</button>
            </form>
        <% } else { %>
            —
        <% } %>
    </td>
</tr>
<%
    }
    rs.close();
    stmt.close();
    con.close();
} catch(Exception e) {
%>
<tr>
    <td colspan="9">Error: <%= e.getMessage() %></td>
</tr>
<%
}
%>
</table>
</div>

</body>
</html>
