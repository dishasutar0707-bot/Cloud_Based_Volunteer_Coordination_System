<%@ page import="java.sql.*" %>
<%
String taskIdStr = request.getParameter("volunteer_task_id");
String email = request.getParameter("email");

if(taskIdStr != null && email != null) {
    int taskId = Integer.parseInt(taskIdStr);

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/volunteer_db","root","root");

        PreparedStatement ps = con.prepareStatement(
            "UPDATE volunteer_tasks SET status='Completed' WHERE volunteer_task_id=?"
        );
        ps.setInt(1, taskId);
        ps.executeUpdate();
        ps.close();
        con.close();

        // Redirect back to volunteer tasks page with email
        response.sendRedirect("volunteer_tasks.jsp?email=" + email);

    } catch(Exception e){
        out.println("<p style='text-align:center;color:red;'>Error: "+e.getMessage()+"</p>");
    }
} else {
    out.println("<p style='text-align:center;color:red;'>Invalid request.</p>");
}
%>
