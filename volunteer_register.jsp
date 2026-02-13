<!DOCTYPE html>
<html>
<head>
<title>Volunteer Registration</title>

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

button{
width:100%;
padding:14px;
border:none;
background:#1e3a8a;
color:white;
border-radius:30px;
font-size:16px;
cursor:pointer;
}
</style>
</head>

<body>

<div class="box">
<h2>New Volunteer Registration</h2>

<form action="volunteerRegisterProcess.jsp" method="post">

<input name="fullname" placeholder="Full Name" required>
<input type="email" name="email" placeholder="Email" required>
<input type="password" name="password" placeholder="Password" required>
<input name="mobile" placeholder="Mobile Number" required>
<input type="date" name="dob" required>
<input name="profession" placeholder="Profession">
<input name="skills" placeholder="Skills">
<input name="state" placeholder="State">
<input name="city" placeholder="City">
<input name="pincode" placeholder="Pincode">

<button>Register & Continue</button>
</form>

</div>
</body>
</html>
