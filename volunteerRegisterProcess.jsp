<%@ page import="java.sql.*" %>

<%
String fullname=request.getParameter("fullname");
String email=request.getParameter("email");
String password=request.getParameter("password");
String mobile=request.getParameter("mobile");
String dob=request.getParameter("dob");
String profession=request.getParameter("profession");
String skills=request.getParameter("skills");
String state=request.getParameter("state");
String city=request.getParameter("city");
String pincode=request.getParameter("pincode");

try{
Class.forName("com.mysql.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/volunteer_db?useSSL=false",
"root","root");

PreparedStatement ps=con.prepareStatement(
"INSERT INTO volunteers(fullname,email,password,mobile,dob,profession,skills,state,city,pincode) VALUES(?,?,?,?,?,?,?,?,?,?)");

ps.setString(1,fullname);
ps.setString(2,email);
ps.setString(3,password);
ps.setString(4,mobile);
ps.setString(5,dob);
ps.setString(6,profession);
ps.setString(7,skills);
ps.setString(8,state);
ps.setString(9,city);
ps.setString(10,pincode);

ps.executeUpdate();

/* AUTO LOGIN */
session.setAttribute("email",email);
session.setAttribute("role","volunteer");

response.sendRedirect("volunteerDashboard.jsp");

}catch(Exception e){
out.print("Registration error: "+e);
}
%>
