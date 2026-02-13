<%@ page import="java.sql.*" %>
<%
Integer volunteerId = (Integer) session.getAttribute("volunteer_id");
if(volunteerId == null) return;

String message = request.getParameter("message");
if(message == null || message.trim().isEmpty()) return;

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/volunteer_db","root","root");

PreparedStatement ps = con.prepareStatement(
"INSERT INTO chat_messages(sender_role,sender_id,receiver_role,receiver_id,message) VALUES('volunteer',?, 'admin',1,?)"
);
ps.setInt(1, volunteerId);
ps.setString(2, message);

ps.executeUpdate();
ps.close();
con.close();
%>
