<%@ page import="java.sql.*" %>
<%
    Object adminId = session.getAttribute("admin_id");
    if(adminId == null){
%>
    <p style="color:red;text-align:center;margin-top:50px;">
        You must login as admin first! <a href="admin_login.jsp">Login</a>
    </p>
<%
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Event Performance Report</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: #f4f6f8;
            color: #1f2933;
        }

        /* HEADER */
        .header {
            background: #1e3a8a; /* deep blue */
            color: #fff;
            text-align: center;
            padding: 50px 20px;
            border-bottom-left-radius: 20px;
            border-bottom-right-radius: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.15);
        }

        .header h2 {
            font-size: 32px;
            margin: 0;
        }

        /* TABLE CARD */
        .table-wrapper {
            width: 95%;
            max-width: 1200px;
            margin: 40px auto;
            overflow-x: auto;
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(12px);
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            padding: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 14px 10px;
            text-align: center;
        }

        th {
            background: #1e3a8a; /* deep blue */
            color: #fff;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        td {
            background: rgba(255,255,255,0.1);
            color: #1f2933;
        }

        tr:nth-child(even) td {
            background: rgba(255,255,255,0.05);
        }

        tr:hover td {
            background: rgba(255,255,255,0.2);
            transform: scale(1.01);
            transition: 0.2s;
        }

        /* RESPONSIVE */
        @media(max-width:900px){
            .table-wrapper { width: 95%; padding: 15px; }
            th, td { font-size: 14px; padding: 10px; }
        }

        /* ERROR MESSAGE */
        .error-msg {
            color: #ef4444;
            text-align: center;
            margin-top: 20px;
            font-weight: 600;
        }

    </style>
</head>
<body>

<div class="header">
    <h2>Event Performance Report</h2>
</div>

<div class="table-wrapper">
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try{
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/volunteer_db","root","root");

        String sql = "SELECT e.event_id, e.event_name, e.event_date, e.location, " +
                     "COUNT(DISTINCT er.registration_id) AS total_volunteers, " +
                     "COUNT(n.message) AS total_messages " +
                     "FROM events e " +
                     "LEFT JOIN event_registrations er ON e.event_id = er.event_id " +
                     "LEFT JOIN notifications n ON n.registration_id = er.registration_id " +
                     "GROUP BY e.event_id " +
                     "ORDER BY e.event_date DESC";

        ps = con.prepareStatement(sql);
        rs = ps.executeQuery();
%>
    <table>
        <tr>
            <th>Event ID</th>
            <th>Event Name</th>
            <th>Date</th>
            <th>Location</th>
            <th>Total Volunteers</th>
            <th>Total Messages</th>
        </tr>
<%
        while(rs.next()){
%>
        <tr>
            <td><%= rs.getInt("event_id") %></td>
            <td><%= rs.getString("event_name") %></td>
            <td><%= rs.getDate("event_date") %></td>
            <td><%= rs.getString("location") %></td>
            <td><%= rs.getInt("total_volunteers") %></td>
            <td><%= rs.getInt("total_messages") %></td>
        </tr>
<%
        }
%>
    </table>
<%
    } catch(Exception e){
%>
    <p class="error-msg">Error: <%= e.getMessage() %></p>
<%
    } finally {
        if(rs != null) try{ rs.close(); } catch(Exception e){}
        if(ps != null) try{ ps.close(); } catch(Exception e){}
        if(con != null) try{ con.close(); } catch(Exception e){}
    }
%>
</div>

</body>
</html>
