<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String messageText = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String feedbackType = request.getParameter("feedback_type");
        String feedbackMessage = request.getParameter("feedback_message");
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String email = request.getParameter("email");
        String volunteerName = firstName + " " + lastName;

        String regIdStr = request.getParameter("registration_id");
        int registrationId = 0;
        try { registrationId = Integer.parseInt(regIdStr); } catch(Exception e){}

        if (!volunteerName.isEmpty() && !email.isEmpty()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/volunteer_db","root","root"
                );

                String sql = "INSERT INTO feedback (registration_id, volunteer_name, message) VALUES (?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, registrationId);
                ps.setString(2, volunteerName);
                ps.setString(3, feedbackType + " - " + feedbackMessage + " (Email: " + email + ")");
                int i = ps.executeUpdate();

                messageText = (i > 0)
                    ? "Thank you! Your feedback has been submitted successfully."
                    : "Failed to submit feedback.";

                ps.close();
                con.close();
            } catch(Exception e){
                messageText = "Error: " + e.getMessage();
            }
        } else {
            messageText = "Please fill all required fields.";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Feedback | Volunteer</title>

<style>
:root{
    --primary:#f97316;
    --secondary:#111827;
    --bg:#f9fafb;
    --card:#ffffff;
    --border:#e5e7eb;
    --text:#1f2937;
}

/* BODY */
body{
    margin:0;
    font-family:Segoe UI, Arial;
    background:var(--bg);
    color:var(--text);
}

/* CONTAINER */
.container{
    width:520px;
    margin:60px auto;
    background:var(--card);
    padding:35px;
    border-radius:16px;
    box-shadow:0 12px 30px rgba(0,0,0,0.08);
    border-top:5px solid var(--primary);
}

/* TITLE */
h2{
    text-align:center;
    color:var(--secondary);
    margin-bottom:10px;
}

.description{
    text-align:center;
    color:#6b7280;
    margin-bottom:25px;
}

/* FORM */
label{
    display:block;
    margin-top:15px;
    font-weight:600;
    color:var(--secondary);
}

input[type=text],
input[type=email],
select,
textarea{
    width:100%;
    padding:12px;
    margin-top:6px;
    border-radius:8px;
    border:1px solid var(--border);
    font-size:14px;
    outline:none;
}

input:focus,
select:focus,
textarea:focus{
    border-color:var(--primary);
}

/* TEXTAREA */
textarea{
    height:120px;
    resize:none;
}

/* BUTTON */
input[type=submit]{
    background:var(--primary);
    color:white;
    border:none;
    padding:14px;
    margin-top:25px;
    border-radius:10px;
    font-size:15px;
    font-weight:600;
    cursor:pointer;
    width:100%;
    transition:0.3s;
}

input[type=submit]:hover{
    background:var(--secondary);
}

/* MESSAGE */
.message{
    text-align:center;
    margin-top:18px;
    font-weight:600;
    color:#16a34a;
}
</style>
</head>

<body>

<div class="container">
    <h2>Feedback Form</h2>
    <p class="description">
        <span style="font-size:20px;">
🤝🙌📝 Every helping hand matters. We value your voice in shaping our future efforts! 🌱🌟
</span>

    </p>

    <form method="post">

        <label>Feedback Type</label>
        <select name="feedback_type" required>
            <option value="">-- Select Type --</option>
            <option value="Suggestion">Suggestion</option>
            <option value="Complaint">Complaint</option>
            <option value="Problem">Problem</option>
            <option value="Other">Other</option>
        </select>

        <label>Describe Your Feedback *</label>
        <textarea name="feedback_message" placeholder="Write your feedback here..." required></textarea>

        <label>First Name *</label>
        <input type="text" name="first_name" required>

        <label>Last Name *</label>
        <input type="text" name="last_name" required>

        <label>E-mail *</label>
        <input type="email" name="email" required>

        <input type="submit" value="Submit Feedback">
    </form>

    <p class="message"><%= messageText %></p>
</div>

</body>
</html>
