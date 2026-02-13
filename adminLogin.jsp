<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String error = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.jdbc.Driver"); // updated driver

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/volunteer_db?useSSL=false&serverTimezone=UTC",
                "root",
                "root"
            );

            // 🔍 Check admin
            PreparedStatement ps = con.prepareStatement(
                "SELECT admin_id, password FROM admin WHERE email=?"
            );
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                if (password.equals(rs.getString("password"))) {

                    // ✅ STORE ID FOR CHAT SYSTEM
                    session.setAttribute("admin_id", rs.getInt("admin_id"));
                    session.setAttribute("email", email);
                    session.setAttribute("role", "admin");

                    response.sendRedirect("adminDashboard.jsp");
                    return;

                } else {
                    error = "Incorrect Password";
                }

            } else {

                // 🆕 Register admin automatically
                PreparedStatement insertPs = con.prepareStatement(
                    "INSERT INTO admin (email, password) VALUES (?, ?)",
                    Statement.RETURN_GENERATED_KEYS
                );

                insertPs.setString(1, email);
                insertPs.setString(2, password);
                insertPs.executeUpdate();

                ResultSet keys = insertPs.getGeneratedKeys();
                keys.next();

                int newAdminId = keys.getInt(1);

                // ✅ STORE NEW ADMIN ID
                session.setAttribute("admin_id", newAdminId);
                session.setAttribute("email", email);
                session.setAttribute("role", "admin");

                response.sendRedirect("adminDashboard.jsp");
                return;
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            error = "Server error. Please try again.";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login | Love Care Share</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
body{
    margin:0;
    height:100vh;
    display:flex;
    font-family:'Poppins',sans-serif;
    background:#f4f6f8;
    color:#1f2933;
}
.left{
    flex:1;
    padding:60px;
    display:flex;
    flex-direction:column;
    justify-content:center;
}
.left h1{font-size:36px;color:#1e3a8a;}
.left p{font-size:18px;color:#3b82f6;margin-top:15px;}

.right{
    flex:1;
    display:flex;
    justify-content:center;
    align-items:center;
}
.box{
    background:#fff;
    width:420px;
    padding:35px;
    border-radius:18px;
    box-shadow:0 15px 40px rgba(0,0,0,0.1);
}
h2{text-align:center;margin-bottom:25px;color:#1e3a8a;}

input,button{
    width:100%;
    padding:13px;
    margin-bottom:14px;
    border-radius:8px;
    font-size:15px;
    border:none;
}
input{
    border:1px solid #e5e7eb;
    background:#f9fafb;
}
button{
    background:#1e3a8a;
    color:#fff;
    font-weight:600;
    cursor:pointer;
}
button:hover{background:#3b82f6;}

.error{
    text-align:center;
    color:#f59e0b;
    font-size:14px;
}
@media(max-width:900px){
    .left{display:none;}
}
</style>
</head>

<body>

<div class="left">
    <h1>Admin Portal</h1>
    <p>Login or auto-register admin dynamically.</p>
</div>

<div class="right">
    <div class="box">
        <h2>Admin Login</h2>

        <form method="post" action="adminLogin.jsp">
            <input type="email" name="email" placeholder="Admin Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button>Login</button>
        </form>

        <% if(!error.equals("")){ %>
            <div class="error"><%= error %></div>
        <% } %>
    </div>
</div>

</body>
</html>
