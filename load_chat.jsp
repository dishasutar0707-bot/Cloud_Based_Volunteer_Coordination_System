<%@ page import="java.sql.*" %>
<%
String role=request.getParameter("role");
String email = role.equals("ADMIN") ?
request.getParameter("volunteer") :
(String)session.getAttribute("email");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/volunteer_db","root","root");

PreparedStatement ps=con.prepareStatement(
"SELECT * FROM chat_messages WHERE sender_email=? OR receiver_email=? ORDER BY sent_at");
ps.setString(1,email);
ps.setString(2,email);

ResultSet rs=ps.executeQuery();
while(rs.next()){
boolean sent = rs.getString("sender_role").equals(role);
%>
<div class="msg <%= sent?"sent":"received" %>">
<%= rs.getString("message") %>
</div>
<% } %>
