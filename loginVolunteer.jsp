<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String error = "";

if ("POST".equalsIgnoreCase(request.getMethod())) {

    String email = request.getParameter("email");
    String password = request.getParameter("password");

    try {
        Class.forName("com.mysql.jdbc.Driver");

        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/volunteer_db?useSSL=false&serverTimezone=UTC",
            "root",
            "root"
        );

        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM volunteer WHERE email=? AND password=?"
        );

        ps.setString(1, email);
        ps.setString(2, password);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {

            session.setAttribute("volunteer_id", rs.getInt("volunteer_id"));
            session.setAttribute("email", email);
            session.setAttribute("role", "volunteer");

            response.sendRedirect("volunteerDashboard.jsp");
            return;

        } else {
            error = "Invalid email or password";
        }

        con.close();

    } catch (Exception e) {
        e.printStackTrace();
        error = "Server error. Try again.";
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Volunteer Login</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
body{height:100vh;background:#f4f6f8;display:flex;align-items:center;justify-content:center;}
.login-box{width:420px;background:#fff;padding:40px;border-radius:14px;box-shadow:0 12px 35px rgba(0,0,0,.12);text-align:center;}
.login-box h2{color:#1e3a8a;margin-bottom:8px;}
.login-box p{margin-bottom:28px;color:#1f2933;font-size:14px;}
input{width:100%;padding:14px;margin-bottom:16px;border-radius:8px;border:1px solid #d1d5db;}
button{width:100%;padding:14px;border:none;border-radius:30px;background:#1e3a8a;color:#fff;font-size:16px;}
button:hover{background:#3b82f6;}
.error{margin-top:15px;color:red;font-weight:500;}
.register{margin-top:18px;font-size:14px;}
.register a{color:#1e3a8a;font-weight:600;text-decoration:none;}
</style>
</head>

<body>

<div class="login-box">

<h2>Volunteer Login</h2>
<p>Login to continue</p>

<form method="post">

<input type="email" name="email" placeholder="Email Address" required>

<input type="password" name="password" placeholder="Password" required>

<button type="submit">Login</button>

</form>

<div class="register">
New user? <a href="volunteer_register.jsp">Register first</a>
</div>

<% if(!error.equals("")){ %>
<div class="error"><%= error %></div>
<% } %>

</div>

</body>
</html>
