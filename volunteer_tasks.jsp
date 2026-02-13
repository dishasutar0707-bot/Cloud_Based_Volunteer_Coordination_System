<%@ page import="java.sql.*" %>
<%
String email = (String) session.getAttribute("email");
if(email == null){
    out.println("<p style='color:red;text-align:center;'>Session expired. Please login again.</p>");
    return;
}
%>

<style>
table{
    width:90%;
    margin:auto;
    border-collapse:collapse;
    background:#fff;
    border-radius:14px;
    box-shadow:0 12px 30px rgba(0,0,0,.08);
}
th,td{
    padding:14px;
    text-align:center;
}
th{
    background:#f97316;
    color:white;
}
td{
    border-bottom:1px solid #e5e7eb;
}
.status-pending{color:#f59e0b;font-weight:600;}
.status-completed{color:#16a34a;font-weight:600;}
button{
    padding:8px 14px;
    background:#f97316;
    border:none;
    color:white;
    border-radius:8px;
    cursor:pointer;
}
button:hover{background:#111827;}
</style>

<h2 style="text-align:center;">My Tasks</h2>

<%
try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/volunteer_db","root","root");

    PreparedStatement ps = con.prepareStatement(
        "SELECT t.task_name, e.event_name, vt.status, vt.volunteer_task_id " +
        "FROM volunteer_tasks vt " +
        "JOIN event_registrations r ON vt.registration_id=r.registration_id " +
        "JOIN tasks t ON vt.task_id=t.task_id " +
        "JOIN events e ON t.event_id=e.event_id " +
        "WHERE r.email=? AND r.status='Approved'");
    ps.setString(1, email);

    ResultSet rs = ps.executeQuery();

    if(!rs.isBeforeFirst()){
%>
<p style="text-align:center;color:#dc2626;">No tasks assigned yet.</p>
<%
    } else {
%>

<table>
<tr>
    <th>Task</th>
    <th>Event</th>
    <th>Status</th>
    <th>Action</th>
</tr>

<%
while(rs.next()){
    String st = rs.getString("status");
%>
<tr>
    <td><%= rs.getString("task_name") %></td>
    <td><%= rs.getString("event_name") %></td>
    <td class="<%= "Pending".equals(st)?"status-pending":"status-completed" %>">
        <%= st %>
    </td>
    <td>
    <% if("Pending".equals(st)){ %>
        <form method="post" action="mark_task_completed.jsp">
            <input type="hidden" name="volunteer_task_id" value="<%= rs.getInt("volunteer_task_id") %>">
            <button>Mark Completed</button>
        </form>
    <% } else { %>
        Completed
    <% } %>
    </td>
</tr>
<% } %>
</table>

<%
    }
    con.close();
}catch(Exception e){
    out.println("<p style='color:red;text-align:center;'>"+e.getMessage()+"</p>");
}
%>
