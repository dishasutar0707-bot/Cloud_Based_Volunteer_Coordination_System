<%@ page import="java.sql.*" %>
<%
HttpSession session1 = request.getSession(false);
Integer vid = (Integer) session1.getAttribute("volunteer_id");

if(vid == null){
    response.sendRedirect("loginVolunteer.jsp");
    return;
}

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/volunteer_db","root","root"
);

PreparedStatement ps = con.prepareStatement(
"SELECT * FROM volunteers WHERE id=?"
);
ps.setInt(1, vid);
ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<title>My Profile</title>

<style>
body{
background:#eef2ff;
display:flex;
justify-content:center;
align-items:center;
height:100vh;
font-family:Segoe UI;
}

.box{
background:white;
width:480px;
padding:35px;
border-radius:18px;
box-shadow:0 12px 28px rgba(0,0,0,.15);
}

h2{
text-align:center;
color:#1e3a8a;
margin-bottom:22px;
}

input{
width:100%;
padding:12px;
margin-bottom:14px;
border-radius:8px;
border:1px solid #ccc;
}
</style>
</head>

<body>

<div class="box">
<h2>My Profile</h2>

<%
if(rs.next()){
%>
<input value="<%=rs.getString("fullname")%>" readonly>
<input value="<%=rs.getString("email")%>" readonly>
<input value="<%=rs.getString("mobile")%>" readonly>
<input value="<%=rs.getString("skills")%>" readonly>
<input value="<%=rs.getString("city")%>" readonly>
<%
}else{
%>
<p>No profile data found.</p>
<%
}
%>

</div>

</body>
</html>

<%
rs.close();
ps.close();
con.close();
%>
