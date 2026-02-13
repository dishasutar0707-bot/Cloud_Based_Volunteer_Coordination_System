<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Task Status | Admin</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>

/* ===== GLOBAL ===== */
body{
    font-family:'Poppins',sans-serif;
    background:#f9fafb;
    color:#1f2937;
    margin:0;
    padding:0;
}

/* ===== HEADER SECTION ===== */
h2{
    text-align:center;
    margin:40px 0 25px;
    font-size:28px;
    font-weight:600;
    color:#111827;
}

/* ===== TABLE CONTAINER STYLE ===== */
table{
    width:95%;
    margin:0 auto 50px;
    border-collapse:collapse;
    background:#ffffff;
    border-radius:16px;
    overflow:hidden;
    box-shadow:0 12px 30px rgba(0,0,0,0.08);
    border-top:4px solid #f97316; /* orange accent */
}

/* ===== TABLE HEADER ===== */
th,td{
    padding:15px;
    text-align:center;
}

th{
    background:#111827; /* black */
    color:#ffffff;
    font-size:14px;
    letter-spacing:0.5px;
}

/* ===== TABLE BODY ===== */
td{
    font-size:14px;
    border-bottom:1px solid #e5e7eb;
}

/* ===== STATUS STYLING ===== */
.completed{
    background:#dcfce7;
    color:#16a34a;
    padding:6px 12px;
    border-radius:20px;
    font-weight:600;
    display:inline-block;
}

.assigned{
    background:#fff7ed;
    color:#f97316;
    padding:6px 12px;
    border-radius:20px;
    font-weight:600;
    display:inline-block;
}

/* ===== ROW EFFECTS ===== */
tr:nth-child(even){
    background:#f9fafb;
}

tr:hover{
    background:#fff7ed;
    transition:0.3s;
}

/* ===== RESPONSIVE ===== */
@media(max-width:900px){
    table{
        font-size:13px;
    }
    th, td{
        padding:10px;
    }
}

</style>

</head>

<body>

<h2>Volunteer Task Completion Status</h2>

<table>
<tr>
    <th>Event</th>
    <th>Task</th>
    <th>Volunteer</th>
    <th>Status</th>
    <th>Completed At</th>
</tr>

<%
try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/volunteer_db","root","root");

    String sql =
        "SELECT e.event_name, t.task_name, r.full_name, " +
        "vt.status, vt.completed_at " +
        "FROM volunteer_tasks vt " +
        "JOIN tasks t ON vt.task_id = t.task_id " +
        "JOIN event_registrations r ON vt.registration_id = r.registration_id " +
        "JOIN events e ON t.event_id = e.event_id";

    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery(sql);

    while(rs.next()){
%>
<tr>
    <td><%= rs.getString("event_name") %></td>
    <td><%= rs.getString("task_name") %></td>
    <td><%= rs.getString("full_name") %></td>
    <td class="<%= rs.getString("status").equals("Completed") ? "completed" : "assigned" %>">
        <%= rs.getString("status") %>
    </td>
    <td>
        <%= rs.getTimestamp("completed_at") != null ? rs.getTimestamp("completed_at") : "-" %>
    </td>
</tr>
<%
    }
    rs.close();
    st.close();
    con.close();
}catch(Exception e){
    out.println("Error: " + e.getMessage());
}
%>

</table>

</body>
</html>
