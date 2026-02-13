<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String registrationIdStr = request.getParameter("registration_id");
String status = request.getParameter("status");

if(registrationIdStr != null && status != null) {
    int registrationId = Integer.parseInt(registrationIdStr);

    try {
        // 1️⃣ Connect to database
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/volunteer_db","root","root");

        // 2️⃣ Update status in event_registrations table
        PreparedStatement ps = con.prepareStatement(
            "UPDATE event_registrations SET status=? WHERE registration_id=?"
        );
        ps.setString(1, status);
        ps.setInt(2, registrationId);
        ps.executeUpdate();
        ps.close();

        // 3️⃣ Insert notification
        // Assuming volunteer_id = registration_id for simplicity
        String message = "Your registration request has been " + status.toUpperCase() + ".";
        PreparedStatement notify = con.prepareStatement(
            "INSERT INTO notifications(volunteer_id, message) VALUES (?, ?)"
        );
        notify.setInt(1, registrationId); // Change to actual volunteer_id if different
        notify.setString(2, message);
        notify.executeUpdate();
        notify.close();

        // 4️⃣ Close connection
        con.close();

        // 5️⃣ Redirect back to the main view page
        response.sendRedirect("view_registration.jsp");

    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    }
} else {
    response.sendRedirect("view_registration.jsp"); // If accessed without parameters
}
%>
