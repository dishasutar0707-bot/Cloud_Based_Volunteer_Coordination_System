<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String messageText = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String feedbackType = request.getParameter("feedback_type");
        String feedbackMessage = request.getParameter("feedback_message");
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String email = request.getParameter("email");
        String volunteerName = firstName + " " + lastName;

        Object regIdObj = session.getAttribute("registration_id");
        int registrationId = regIdObj != null ? Integer.parseInt(regIdObj.toString()) : 0;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/volunteer_db", "root", "root"
            );

            String sql = "INSERT INTO feedback (registration_id, volunteer_name, message) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, registrationId);
            ps.setString(2, volunteerName);
            ps.setString(3, feedbackType + " - " + feedbackMessage + " (Email: " + email + ")");
            int i = ps.executeUpdate();
            if (i > 0) messageText = "Thank you! Your feedback has been submitted successfully.";
            else messageText = "Failed to submit feedback.";

            con.close();
        } catch (Exception e) {
            messageText = "Error: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Feedback Form</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f7f7f7; margin: 0; padding: 0; }
        .container { width: 500px; background: #fff; padding: 30px; margin: 50px auto; box-shadow: 0 0 10px rgba(0,0,0,0.1); border-radius: 8px; }
        h2 { text-align: center; color: #333; }
        label { display: block; margin-top: 15px; font-weight: bold; }
        input[type=text], input[type=email], select, textarea { width: 100%; padding: 10px; margin-top: 5px; border: 1px solid #ccc; border-radius: 4px; }
        textarea { height: 120px; }
        input[type=submit] { background: #28a745; color: #fff; border: none; padding: 10px 20px; margin-top: 20px; cursor: pointer; border-radius: 4px; font-size: 16px; }
        input[type=submit]:hover { background: #218838; }
        .message { text-align: center; margin-top: 15px; color: green; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Feedback Form</h2>
        <p>We would love to hear your thoughts, suggestions, concerns or problems with anything so we can improve!</p>
        <form method="post">
            <label for="feedback_type">Feedback Type</label>
            <select name="feedback_type" id="feedback_type" required>
                <option value="">-- Select Type --</option>
                <option value="Suggestion">Suggestion</option>
                <option value="Complaint">Complaint</option>
                <option value="Problem">Problem</option>
                <option value="Other">Other</option>
            </select>

            <label for="feedback_message">Describe Your Feedback*</label>
            <textarea name="feedback_message" id="feedback_message" placeholder="Write your feedback here..." required></textarea>

            <label for="first_name">First Name*</label>
            <input type="text" name="first_name" id="first_name" placeholder="First Name" required>

            <label for="last_name">Last Name*</label>
            <input type="text" name="last_name" id="last_name" placeholder="Last Name" required>

            <label for="email">E-mail*</label>
            <input type="email" name="email" id="email" placeholder="example@example.com" required>

            <input type="submit" value="Submit">
        </form>
        <p class="message"><%= messageText %></p>
    </div>
</body>
</html>
