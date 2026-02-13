<%@ page import="java.sql.*" %>
<%
if(session.getAttribute("email")==null){
    response.sendRedirect("loginVolunteer.jsp");
    return;
}

String fullname="", emailV="", mobile="", profession="", skills="", city="";

try{
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/volunteer_db","root","root");

PreparedStatement ps=con.prepareStatement(
"select * from volunteers where email=?");
ps.setString(1, session.getAttribute("email").toString());
ResultSet rs=ps.executeQuery();

if(rs.next()){
fullname=rs.getString("fullname");
emailV=rs.getString("email");
mobile=rs.getString("mobile");
profession=rs.getString("profession");
skills=rs.getString("skills");
city=rs.getString("city");
}
}catch(Exception e){ e.printStackTrace(); }
%>

<!DOCTYPE html>
<html>
<head>
<title>Volunteer Dashboard</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
*{ box-sizing:border-box; }

:root{
    --primary:#f97316;
    --secondary:#111827;
    --bg:#f9fafb;
    --card:#ffffff;
    --text:#1f2937;
    --border:#e5e7eb;
}

/* BODY */
body{
margin:0;
font-family:Segoe UI, Arial;
background:var(--bg);
color:var(--text);
}

/* HEADER */
.header{
height:65px;
background:var(--primary);
color:white;
padding:0 30px;
display:flex;
align-items:center;
position:fixed;
top:0; left:0; right:0;
z-index:1000;
font-size:18px;
}

/* DASHBOARD */
.dashboard{
display:flex;
margin-top:65px;
height:calc(100vh - 65px);
}

/* SIDEBAR */
.sidebar{
width:240px;
background:white;
border-right:1px solid var(--border);
padding-top:20px;
}

.sidebar a{
display:block;
padding:14px 20px;
color:var(--secondary);
text-decoration:none;
font-size:15px;
border-left:4px solid transparent;
transition:.3s;
cursor:pointer;
}

.sidebar a:hover{
background:#fff7ed;
border-left:4px solid var(--primary);
color:var(--primary);
}

.sidebar i{
margin-right:10px;
color:var(--primary);
}

/* MAIN CONTENT */
.main{
flex:1;
padding:30px;
overflow-y:auto;
background:var(--card);
margin:15px;
border-radius:14px;
box-shadow:0 10px 25px rgba(0,0,0,.08);
}

.main h2{
color:var(--secondary);
margin-bottom:20px;
}

/* VIDEO */
.main video{
width:100%;
max-height:420px;
border-radius:14px;
box-shadow:0 10px 25px rgba(0,0,0,.15);
}

/* PROFILE PANEL */
#profileBox{
position:fixed;
top:65px;
right:-340px;
width:330px;
height:calc(100vh - 65px);
background:white;
border-left:1px solid var(--border);
padding:25px;
transition:.3s;
z-index:2000;
box-shadow:-10px 0 25px rgba(0,0,0,.15);
}

#profileBox.active{
right:0;
}

#profileBox h3{
margin-top:0;
color:var(--primary);
}

/* LOGOUT */
.profile-logout{
display:block;
margin-top:25px;
padding:12px;
background:var(--secondary);
color:white;
text-align:center;
border-radius:8px;
text-decoration:none;
font-weight:600;
}

.profile-logout:hover{
background:var(--primary);
}
</style>

</head>

<body>

<!-- HEADER -->
<div class="header">
Welcome, <b>&nbsp;<%= fullname %></b>
</div>

<!-- DASHBOARD -->
<div class="dashboard">

<!-- SIDEBAR -->
<div class="sidebar">

<a onclick="openProfile()">
<i class="fa fa-user"></i> My Profile
</a>

<a onclick="loadPage('volunteer_events.jsp')">
<i class="fa fa-calendar"></i> View Events
</a>

<a onclick="loadPage('eventRegister.jsp')">
<i class="fa fa-clipboard-check"></i> Event Registration
</a>

<a onclick="loadPage('volunteer_status.jsp')">
<i class="fa fa-chart-line"></i> Status
</a>

<a onclick="loadPage('volunteer_tasks.jsp')">
<i class="fa fa-list-check"></i> My Tasks
</a>

<a onclick="loadPage('volunteer_chat.jsp')">
<i class="fa fa-comments"></i> Chatbox
</a>

<a onclick="loadPage('volunteer_feedback.jsp')">
<i class="fa fa-star"></i> Feedback
</a>

</div>

<!-- MAIN CONTENT -->
<div class="main" id="contentArea">
<h2>
Be the reason someone smiles today
<span style="
font-size:20px;
background:linear-gradient(100deg,#f97316 50%,#111827 50%);
-webkit-background-clip:text;
-webkit-text-fill-color:transparent;">
&#10084;
</span>
</h2>

<video autoplay muted loop>
<source src="video/video1.mp4" type="video/mp4">
</video>
</div>

</div>

<!-- PROFILE PANEL -->
<div id="profileBox">
<h3>My Profile</h3>

<p><b>Name:</b> <%= fullname %></p>
<p><b>Email:</b> <%= emailV %></p>
<p><b>Mobile:</b> <%= mobile %></p>
<p><b>Profession:</b> <%= profession %></p>
<p><b>Skills:</b> <%= skills %></p>
<p><b>City:</b> <%= city %></p>

<a href="logoutVolunteer.jsp" class="profile-logout">Logout</a>
</div>

<script>
function openProfile(){
document.getElementById("profileBox").classList.toggle("active");
}

function loadPage(page){
document.getElementById("profileBox").classList.remove("active");
document.getElementById("contentArea").innerHTML="";

fetch(page+"?t="+new Date().getTime())
.then(res=>res.text())
.then(html=>{
document.getElementById("contentArea").innerHTML=html;
});
}
</script>

</body>
</html>
