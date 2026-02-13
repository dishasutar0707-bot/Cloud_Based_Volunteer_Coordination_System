<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<title>Create Task | Love Care Share</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>

/* ===== GLOBAL ===== */
* {
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
    margin: 0;
    padding: 0;
}

body {
    background: #f9fafb;
    color: #1f2937;
}

/* ===== HEADER ===== */
.header {
    background: #111827; /* black */
    color: #ffffff;
    text-align: center;
    padding: 60px 30px;
    border-bottom-left-radius: 20px;
    border-bottom-right-radius: 20px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
}

.header h1 {
    font-size: 34px;
    margin-bottom: 10px;
    font-weight: 600;
}

.header p {
    font-size: 15px;
    max-width: 600px;
    margin: auto;
    color: #d1d5db;
}

/* ===== FORM WRAPPER ===== */
.form-wrapper {
    display: flex;
    justify-content: center;
    margin: 50px 0 70px 0;
}

/* ===== CARD ===== */
.card {
    width: 460px;
    background: #ffffff;
    padding: 35px;
    border-radius: 18px;
    box-shadow: 0 12px 30px rgba(0,0,0,0.08);
    border-top: 4px solid #f97316; /* orange accent */
    transition: 0.3s;
}

.card:hover {
    transform: translateY(-5px);
    box-shadow: 0 15px 35px rgba(0,0,0,0.12);
}

/* ===== LABELS ===== */
label {
    font-size: 14px;
    font-weight: 600;
    margin-top: 14px;
    display: block;
    color: #111827;
}

/* ===== INPUTS ===== */
input, select, textarea {
    width: 100%;
    padding: 12px;
    margin-top: 6px;
    border-radius: 10px;
    font-size: 14px;
    border: 1px solid #e5e7eb;
    background: #f9fafb;
    color: #1f2937;
    outline: none;
    transition: 0.3s;
}

input:focus, select:focus, textarea:focus {
    border-color: #f97316;
    box-shadow: 0 0 0 2px rgba(249,115,22,0.2);
}

textarea {
    resize: none;
    height: 90px;
}

/* ===== SUBMIT BUTTON ===== */
.btn {
    margin-top: 22px;
    width: 100%;
    padding: 12px;
    border: none;
    border-radius: 12px;
    background: #111827; /* black */
    color: white;
    font-size: 15px;
    font-weight: 600;
    cursor: pointer;
    transition: 0.3s;
}

.btn:hover {
    background: #f97316; /* orange */
    transform: scale(1.03);
}

/* ===== MESSAGES ===== */
.success {
    text-align: center;
    background: #dcfce7;
    color: #16a34a;
    padding: 10px;
    border-radius: 8px;
    margin-bottom: 15px;
    font-weight: 600;
}

.error {
    text-align: center;
    background: #fee2e2;
    color: #dc2626;
    padding: 10px;
    border-radius: 8px;
    margin-bottom: 15px;
    font-weight: 600;
}

/* ===== RESPONSIVE ===== */
@media(max-width:900px){
    .header { padding:40px 20px; }
    .card { width: 90%; }
}

</style>

</head>

<body>

<!-- HEADER -->
<div class="header">
    <h1>Create New Task</h1>
    <p>
        Add tasks for your events and assign them to approved volunteers. Specify task details and deadlines to keep volunteers organized.
    </p>
</div>

<!-- FORM -->
<div class="form-wrapper">
    <div class="card">

<%
String message = "";

if("POST".equalsIgnoreCase(request.getMethod())) {
    String eventId = request.getParameter("event_id");
    String taskName = request.getParameter("task_name");
    String taskDesc = request.getParameter("task_description");
    String dueDate = request.getParameter("due_date");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/volunteer_db","root","root");

        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO tasks (event_id, task_name, task_description, due_date) VALUES (?,?,?,?)"
        );
        ps.setInt(1, Integer.parseInt(eventId));
        ps.setString(2, taskName);
        ps.setString(3, taskDesc);
        ps.setDate(4, java.sql.Date.valueOf(dueDate));

        int rows = ps.executeUpdate();
        message = rows>0?"Task created successfully!":"Failed to create task.";

        ps.close();
        con.close();
    } catch(Exception e) {
        message = "Error: "+e.getMessage();
    }
}

if(!message.isEmpty()){
    if(message.contains("Error") || message.contains("Failed")){
%>
        <div class="error"><%= message %></div>
<%
    } else {
%>
        <div class="success"><%= message %></div>
<%
    }
}
%>

<form method="post" action="">
    <label>Select Event:</label>
    <select name="event_id" required>
        <option value="">--Select Event--</option>
<%
try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/volunteer_db","root","root");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM events");
    while(rs.next()){
%>
        <option value="<%= rs.getInt("event_id") %>"><%= rs.getString("event_name") %></option>
<%
    }
    rs.close(); stmt.close(); con.close();
} catch(Exception e){ out.println("<option>Error loading events</option>"); }
%>
    </select>

    <label>Task Name:</label>
    <input type="text" name="task_name" placeholder="Enter task name" required>

    <label>Task Description:</label>
    <textarea name="task_description" placeholder="Enter task details" required></textarea>

    <label>Due Date:</label>
    <input type="date" name="due_date" required>

    <input type="submit" class="btn" value="Create Task">
</form>

    </div>
</div>

</body>
</html>
