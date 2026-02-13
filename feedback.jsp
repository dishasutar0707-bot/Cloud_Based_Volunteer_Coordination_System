<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>All Volunteer Feedback | Admin</title>
    <style>

/* ===== GLOBAL ===== */
body {
    font-family: 'Poppins', sans-serif;
    background: #f9fafb;
    margin: 0;
    padding: 40px 0;
    color: #1f2937;
}

/* ===== PAGE TITLE ===== */
h2 {
    text-align: center;
    color: #111827; /* black */
    margin-bottom: 35px;
    font-size: 28px;
    font-weight: 600;
}

/* ===== TABLE CONTAINER ===== */
table {
    width: 95%;
    margin: auto;
    border-collapse: collapse;
    background: #ffffff;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 12px 30px rgba(0,0,0,0.08);
    border-top: 4px solid #f97316; /* orange accent */
}

/* ===== TABLE HEADER ===== */
th, td {
    padding: 15px;
    text-align: center;
}

th {
    background: #111827; /* black */
    color: #ffffff;
    font-size: 14px;
    letter-spacing: 0.5px;
}

/* ===== TABLE BODY ===== */
td {
    font-size: 14px;
    border-bottom: 1px solid #e5e7eb;
}

/* Alternate Row Color */
tr:nth-child(even) {
    background: #f9fafb;
}

/* Hover Effect */
tr:hover {
    background: #fff7ed; /* soft orange */
    transition: 0.3s;
}

/* Error Row Styling */
td[colspan] {
    color: #dc2626;
    font-weight: 600;
}

/* ===== RESPONSIVE ===== */
@media(max-width:900px){
    table {
        font-size: 13px;
    }
    th, td {
        padding: 10px;
    }
}

</style>

</head>
<body>
    <h2>All Volunteer Feedback</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Volunteer Name</th>
            <th>Feedback Type</th>
            <th>Message</th>
            <th>Email</th>
            <th>Submitted At</th>
        </tr>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/volunteer_db","root","root"
        );

        String sql = "SELECT * FROM feedback ORDER BY created_at DESC";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while(rs.next()){
%>
        <tr>
            <td><%= rs.getInt("feedback_id") %></td>
            <td><%= rs.getString("volunteer_name") %></td>
            <td><%= rs.getString("feedback_type") %></td>
            <td><%= rs.getString("message") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getTimestamp("created_at") %></td>
        </tr>
<%
        }
        rs.close();
        ps.close();
        con.close();
    } catch(Exception e){
%>
        <tr>
            <td colspan="6" style="color:red;text-align:center;">Error: <%= e.getMessage() %></td>
        </tr>
<%
    }
%>
    </table>
</body>
</html>
