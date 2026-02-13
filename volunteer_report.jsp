<%@ page import="java.sql.*" %>
<%
    Object adminId = session.getAttribute("admin_id");
    if(adminId == null){
%>
    <p style="color:red;text-align:center;">
        You must login as admin first! <a href="admin_login.jsp">Login</a>
    </p>
<%
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Volunteer Participation Report | Love Care Share</title>

<style>
:root {
    --primary: #1e3a8a;      /* Deep Blue */
    --secondary: #3b82f6;    /* Sky Blue */
    --bg: #f4f6f8;           /* Light Gray */
    --card: #ffffff;        /* White */
    --text: #1f2933;         /* Dark Gray */
}

body {
    margin: 0;
    font-family: "Segoe UI", Arial, sans-serif;
    background: var(--bg);
    color: var(--text);
}

h2 {
    text-align: center;
    padding: 25px;
    font-size: 30px;
    color: var(--primary);
}

table {
    width: 95%;
    margin: 30px auto;
    border-collapse: collapse;
    background: var(--card);
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 8px 20px rgba(0,0,0,0.08);
}

th, td {
    padding: 14px 12px;
    text-align: center;
    font-size: 15px;
}

th {
    background: var(--primary);
    color: white;
    font-weight: 600;
}

tr:nth-child(even) {
    background: #f9fafb;
}

tr:hover td {
    background: #eef2ff;
    transition: 0.3s;
}

@media(max-width:900px){
    table {
        width: 98%;
        font-size: 14px;
    }
}
</style>

</head>
<body>

<h2>Volunteer Participation Report</h2>

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/volunteer_db","root","root");

    String sql =
        "SELECT v.registration_id, v.full_name, v.email, v.mobile, v.skill, " +
        "e.event_name, COUNT(n.message) AS messages_sent, " +
        "MIN(n.created_at) AS first_message, MAX(n.created_at) AS last_message " +
        "FROM volunteers v " +
        "JOIN event_registrations er ON v.registration_id = er.registration_id " +
        "JOIN events e ON er.event_id = e.event_id " +
        "LEFT JOIN notifications n ON n.registration_id = v.registration_id " +
        "GROUP BY v.registration_id, e.event_id " +
        "ORDER BY e.event_date, v.full_name";

    ps = con.prepareStatement(sql);
    rs = ps.executeQuery();
%>

<table>
<tr>
    <th>Reg ID</th>
    <th>Name</th>
    <th>Email</th>
    <th>Mobile</th>
    <th>Skill</th>
    <th>Event Name</th>
    <th>Messages Sent</th>
    <th>First Message</th>
    <th>Last Message</th>
</tr>

<%
while(rs.next()){
%>
<tr>
    <td><%= rs.getInt("registration_id") %></td>
    <td><%= rs.getString("full_name") %></td>
    <td><%= rs.getString("email") %></td>
    <td><%= rs.getString("mobile") %></td>
    <td><%= rs.getString("skill") %></td>
    <td><%= rs.getString("event_name") %></td>
    <td><%= rs.getInt("messages_sent") %></td>
    <td><%= rs.getString("first_message") != null ? rs.getString("first_message") : "-" %></td>
    <td><%= rs.getString("last_message") != null ? rs.getString("last_message") : "-" %></td>
</tr>
<%
}
%>
</table>

<%
} catch(Exception e){
%>
<p style="color:red;text-align:center;">Error: <%= e.getMessage() %></p>
<%
} finally {
    if(rs!=null) rs.close();
    if(ps!=null) ps.close();
    if(con!=null) con.close();
}
%>

</body>
</html>
