<%@ page import="java.sql.*" %>
<%
int adminId=(Integer)session.getAttribute("admin_id");
int vId=Integer.parseInt(request.getParameter("volunteer_id"));

Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/volunteer_db","root","root");

PreparedStatement ps=con.prepareStatement(
"SELECT * FROM chat_messages WHERE " +
"(sender_role='admin' AND sender_id=? AND receiver_id=?) OR "+
"(sender_role='volunteer' AND sender_id=? AND receiver_id=?) ORDER BY message_time");

ps.setInt(1,adminId); ps.setInt(2,vId);
ps.setInt(3,vId); ps.setInt(4,adminId);

ResultSet rs=ps.executeQuery();
while(rs.next()){
String role=rs.getString("sender_role");
%>
<div class="msg <%=role.equals("admin")?"admin":"vol"%>">
<%= rs.getString("message") %>
<% if(rs.getString("file_path")!=null){ %>
<br><a href="<%=rs.getString("file_path")%>" target="_blank">📎 View file</a>
<% } %>
<div class="time"><%= rs.getTimestamp("message_time") %></div>
</div>
<% } con.close(); %>
