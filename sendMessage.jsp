<%@ page import="java.sql.*" %>
<%
Integer volunteerId = (Integer) session.getAttribute("volunteer_id");
if(volunteerId == null){
    response.getWriter().print("ERROR: Volunteer not logged in");
    return;
}

String message = request.getParameter("message");
if(message == null || message.trim().isEmpty()) return;

int adminId = 1;

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/volunteer_db","root","root");

PreparedStatement ps = con.prepareStatement(
"INSERT INTO chat_messages(sender_role,sender_id,receiver_role,receiver_id,message) VALUES(?,?,?,?,?)"
);
ps.setString(1,"volunteer");
ps.setInt(2,volunteerId);
ps.setString(3,"admin");
ps.setInt(4,adminId);
ps.setString(5,message);

ps.executeUpdate();

ps.close();
con.close();
%>
