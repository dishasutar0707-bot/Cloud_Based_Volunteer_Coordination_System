<%@ page import="java.sql.*" %>
<%
if(session.getAttribute("admin_id")==null){
    response.sendRedirect("admin_login.jsp");
    return;
}

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/volunteer_db","root","root");

PreparedStatement ps = con.prepareStatement(
"SELECT volunteer_id, fullname FROM volunteers"
);
ResultSet rs = ps.executeQuery();
%>

<h2>Select Volunteer</h2>

<table border="1" width="60%" align="center">
<tr>
    <th>Name</th>
    <th>Chat</th>
</tr>

<%
while(rs.next()){
int vid = rs.getInt("volunteer_id");
%>
<tr>
    <td><%= rs.getString("fullname") %></td>
    <td>
        <a href="admin_chat.jsp?volunteer_id=<%=vid%>">
            Open Chat
        </a>
    </td>
</tr>
<%
}
%>
</table>

<%
rs.close();
ps.close();
con.close();
%>
