<%@ page import="java.sql.*" %>
<%
int volunteerId = Integer.parseInt(request.getParameter("volunteer_id"));

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/volunteer_db","root","root");

PreparedStatement ps = con.prepareStatement(
"SELECT * FROM chat_messages WHERE " +
"(sender_role='volunteer' AND sender_id=? AND receiver_role='admin') OR " +
"(sender_role='admin' AND receiver_id=? AND receiver_role='volunteer') " +
"ORDER BY sent_at"
);

ps.setInt(1,volunteerId);
ps.setInt(2,volunteerId);

ResultSet rs = ps.executeQuery();
while(rs.next()){
%>
<div class="msg <%=rs.getString("sender_role")%>">
    <%= rs.getString("message") %>
</div>
<%
}
rs.close();
ps.close();
con.close();
%>
