<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h2>My Registration Status</h2>

<style>
/* ===================== TABLE STYLING ===================== */
table.status-table {
    width: 100%;
    max-width: 900px;
    margin: 20px auto;
    border-collapse: collapse;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 8px 20px rgba(0,0,0,0.1);
    font-family: "Segoe UI", Arial, sans-serif;
}

table.status-table th {
    background: linear-gradient(90deg, #f97316, #111827);
    color: #fff;
    padding: 12px;
    font-weight: 600;
    text-align: center;
}

table.status-table td {
    padding: 12px;
    text-align: center;
    border-bottom: 1px solid #e5e7eb;
}

table.status-table tr:hover td {
    background: #fff1e6;
    transition: 0.3s;
}

/* STATUS COLORS */
.status-approved {
    color: #16a34a; /* green */
    font-weight: 600;
}

.status-pending {
    color: #f59e0b; /* amber/orange */
    font-weight: 600;
}

.status-rejected {
    color: #dc2626; /* red */
    font-weight: 600;
}

/* NO REGISTRATIONS MESSAGE */
p.no-reg {
    text-align: center;
    font-weight: 600;
    color: #dc2626;
    margin-top: 30px;
}
</style>

<%
String email = session.getAttribute("email") != null ? session.getAttribute("email").toString() : "";

if(email.isEmpty()){
%>
<p class="no-reg">Error: Email not found in session. Please login again.</p>
<%
} else {
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/volunteer_db","root","root");

        PreparedStatement ps = con.prepareStatement(
            "SELECT r.registration_id, e.event_name, r.status, r.registration_date " +
            "FROM event_registrations r " +
            "JOIN events e ON r.event_id = e.event_id " +
            "WHERE r.email=? ORDER BY r.registration_date DESC"
        );
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if(!rs.isBeforeFirst()) {
%>
<p class="no-reg">You have no registrations yet.</p>
<%
        } else {
%>

<table class="status-table">
<tr>
    <th>ID</th>
    <th>Event Name</th>
    <th>Status</th>
    <th>Registration Date</th>
</tr>
<%
            while(rs.next()) {
                String status = rs.getString("status");
                String cls = "status-pending";
                if("Approved".equalsIgnoreCase(status)) cls = "status-approved";
                else if("Rejected".equalsIgnoreCase(status)) cls = "status-rejected";
%>
<tr>
    <td><%= rs.getInt("registration_id") %></td>
    <td><%= rs.getString("event_name") %></td>
    <td class="<%= cls %>"><%= status %></td>
    <td><%= rs.getTimestamp("registration_date") %></td>
</tr>
<%
            }
%>
</table>

<%
        }
        rs.close();
        ps.close();
        con.close();
    } catch(Exception e) {
%>
<p class="no-reg">Error: <%= e.getMessage() %></p>
<%
    }
}
%>
