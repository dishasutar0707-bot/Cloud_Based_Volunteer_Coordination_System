<%@ page import="java.sql.*" %>

<%
String email = request.getParameter("email");
String password = request.getParameter("password");

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/volunteer_db","root","root");

PreparedStatement ps = con.prepareStatement(
"SELECT * FROM volunteers WHERE email=? AND password=?");

ps.setString(1,email);
ps.setString(2,password);

ResultSet rs = ps.executeQuery();

if(rs.next()){
    session.setAttribute("email", email);
    session.setAttribute("role", "volunteer");
    response.sendRedirect("volunteerDashboard.jsp");
}else{
    out.println("Invalid login");
}
%>
