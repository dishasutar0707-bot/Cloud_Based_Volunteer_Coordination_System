<%@ page import="java.sql.*" %>
<%
    String msg = "";

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
                "INSERT INTO admin (email, password) VALUES (?, ?)"
            );

            ps.setString(1, email);
            ps.setString(2, password);
            ps.executeUpdate();
            msg = "Admin added successfully";
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            msg = "Email already exists or error occurred";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Admin</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>

/* ===== GLOBAL ===== */
body {
    margin: 0;
    height: 100vh;
    font-family: 'Poppins', sans-serif;
    background: #f9fafb;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #1f2937;
}

/* ===== CARD ===== */
.card {
    background: #ffffff;
    border-radius: 20px;
    padding: 40px 35px;
    width: 400px;
    box-shadow: 0 15px 40px rgba(0,0,0,0.08);
    text-align: center;
    border-top: 4px solid #f97316; /* orange accent */
    transition: 0.3s;
}

.card:hover {
    transform: translateY(-6px);
    box-shadow: 0 20px 45px rgba(0,0,0,0.12);
}

/* ===== TITLE ===== */
.card h2 {
    margin-bottom: 25px;
    color: #111827; /* black */
    font-weight: 600;
}

.card h2 i {
    color: #f97316; /* orange icon */
    margin-right: 8px;
}

/* ===== INPUTS ===== */
input {
    width: 100%;
    padding: 12px 14px;
    border-radius: 12px;
    border: 1px solid #e5e7eb;
    outline: none;
    margin-bottom: 16px;
    font-size: 14px;
    background: #f9fafb;
    transition: 0.3s;
}

input:focus {
    border-color: #f97316;
    box-shadow: 0 0 0 2px rgba(249,115,22,0.2);
}

/* ===== BUTTON ===== */
button {
    width: 100%;
    padding: 12px;
    border-radius: 30px;
    border: none;
    background: #111827; /* black */
    color: #ffffff;
    font-size: 15px;
    cursor: pointer;
    font-weight: 600;
    transition: 0.3s;
}

button:hover {
    background: #f97316; /* orange */
    transform: scale(1.05);
}

/* ===== MESSAGE ===== */
.msg {
    margin-top: 15px;
    font-size: 14px;
    padding: 8px;
    border-radius: 8px;
    font-weight: 600;
}

.msg:empty {
    display: none;
}

/* Success message style */
.msg {
    background: #dcfce7;
    color: #16a34a;
}

/* ===== BACK LINK ===== */
.back {
    margin-top: 20px;
}

.back a {
    color: #111827;
    text-decoration: none;
    font-size: 14px;
    font-weight: 500;
    transition: 0.3s;
}

.back a:hover {
    color: #f97316;
}

.back i {
    margin-right: 5px;
}

</style>

</head>

<body>

<div class="card">
    <h2><i class="fa fa-user-plus"></i> Add New Admin</h2>

    <form method="post">
        <input type="email" name="email" placeholder="Admin Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Add Admin</button>
    </form>

    <% if (!msg.equals("")) { %>
        <div class="msg"><%= msg %></div>
    <% } %>

    <div class="back">
        <a href="adminDashboard.jsp">
            <i class="fa fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>
</div>

</body>
</html>
