<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("email") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
/* ===== GLOBAL ===== */
body {
    margin: 0;
    font-family: 'Poppins', 'Segoe UI', sans-serif;
    background: #f9fafb; /* same as volunteer */
    color: #1f2937;
}

/* ===== HEADER ===== */
.header {
    padding: 20px 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #111827; /* black */
    color: #ffffff;
}

/* Title */
.header-title {
    font-size: 24px;
    font-weight: 600;
}

/* Header Actions */
.header-actions {
    display: flex;
    align-items: center;
    gap: 15px;
}

/* Add Admin Button */
.add-admin-card {
    background: #f97316; /* orange */
    border-radius: 25px;
    padding: 8px 16px;
    transition: 0.3s;
}

.add-admin-card:hover {
    background: #ea580c;
}

.add-admin-card a {
    color: #ffffff;
    text-decoration: none;
    font-size: 14px;
    display: flex;
    align-items: center;
    gap: 8px;
}

/* Logout Button */
.logout {
    background: #111827; /* black */
    padding: 10px 18px;
    border-radius: 25px;
    text-decoration: none;
    color: #ffffff;
    font-size: 14px;
    transition: 0.3s;
    border: 1px solid #f97316;
}

.logout:hover {
    background: #f97316;
}

/* ===== DASHBOARD GRID ===== */
.dashboard {
    padding: 35px;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
    gap: 25px;
}

/* ===== CARDS ===== */
.card {
    background: #ffffff;
    border-radius: 16px;
    padding: 28px;
    text-align: center;
    box-shadow: 0 10px 25px rgba(0,0,0,0.08);
    transition: 0.3s;
    border-top: 4px solid #f97316; /* orange accent */
}

.card:hover {
    transform: translateY(-6px);
    box-shadow: 0 14px 30px rgba(0,0,0,0.12);
}

/* Icons */
.card i {
    font-size: 42px;
    margin-bottom: 15px;
    color: #f97316; /* orange icons */
}

/* Card Text */
.card h3 {
    margin: 10px 0;
    font-size: 20px;
    color: #111827; /* black */
}

.card p {
    font-size: 14px;
    color: #4b5563;
}

/* Links */
.card a {
    text-decoration: none;
    color: inherit;
}

/* ===== CARD BUTTON ===== */
.card-btn {
    margin-top: 15px;
    padding: 10px 22px;
    border: none;
    background: #111827; /* black */
    color: white;
    border-radius: 12px;
    font-size: 14px;
    cursor: pointer;
    transition: 0.3s;
}

.card-btn:hover {
    background: #f97316; /* orange */
    transform: scale(1.05);
}
</style>
</head>

<body>

<!-- HEADER -->
<div class="header">
    <div class="header-title">Admin Dashboard</div>

    <div class="header-actions">
        <div class="add-admin-card">
            <a href="addAdmin.jsp">
                <i class="fa fa-user-plus"></i> Add Admin
            </a>
        </div>

        <a href="adminLogout.jsp" class="logout">
            <i class="fa fa-sign-out-alt"></i> Logout
        </a>
    </div>
</div>

<!-- DASHBOARD -->
<div class="dashboard">

    <div class="card">
        <a href="createEvent.jsp">
            <i class="fa fa-calendar-plus"></i>
            <h3>Create Event</h3>
            <p>Add new volunteering events</p>
            <button class="card-btn">Open</button>
        </a>
    </div>

    <div class="card">
        <a href="view_registrations.jsp">
            <i class="fa fa-eye"></i>
            <h3>View Events</h3>
            <p>See event registrations</p>
            <button class="card-btn">Open</button>
            
        </a>
    </div>

    <div class="card">
        <a href="create_task.jsp">
            <i class="fa fa-tasks"></i>
            <h3>Create Task</h3>
            <p>Create volunteer tasks</p>
            <button class="card-btn">Open</button>
            
        </a>
    </div>

    <div class="card">
        <a href="assign_task.jsp">
            <i class="fa fa-user-check"></i>
            <h3>Assign Task</h3>
            <p>Assign tasks to volunteers</p>
            <button class="card-btn">Open</button>
            
        </a>
    </div>

    <div class="card">
        <a href="admin_task_status.jsp">
            <i class="fa fa-check-circle"></i>
            <h3>Task Completion</h3>
            <p>Monitor task status</p>
            <button class="card-btn">Open</button>
            
        </a>
    </div>

    <div class="card">
        <a href="admin_chat.jsp">
            <i class="fa fa-comments"></i>
            <h3>Chatbox</h3>
            <p>Chat with volunteers</p>
            <button class="card-btn">Open</button>
            
        </a>
    </div>

    <div class="card">
        <a href="adminViewFeedback.jsp">
            <i class="fa fa-star"></i>
            <h3>Admin Feedback</h3>
            <p>View volunteer feedback</p>
            <button class="card-btn">Open</button>
            
        </a>
    </div>

    

    

</div>

</body>
</html>
