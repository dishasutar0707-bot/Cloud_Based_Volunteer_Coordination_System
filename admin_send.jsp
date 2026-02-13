<%@ page import="java.sql.*" %>
<%
Integer adminId = (Integer) session.getAttribute("admin_id");
if(adminId == null) return;

int volunteerId = Integer.parseInt(request.getParameter("volunteer_id"));
String message = request.getParameter("message");

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/volunteer_db","root","root");

PreparedStatement ps = con.prepareStatement(
"INSERT INTO chat_messages(sender_role,sender_id,receiver_role,receiver_id,message) VALUES('admin',1,'volunteer',?,?)"
);
ps.setInt(1,volunteerId);
ps.setString(2,message);

ps.executeUpdate();
ps.close();
con.close();
%>
