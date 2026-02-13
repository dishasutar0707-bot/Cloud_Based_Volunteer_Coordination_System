<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Volunteer Registration | Love Care Share</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
<style>
    /* ===== Reset & Base ===== */
    * { 
        margin: 0; 
        padding: 0; 
        box-sizing: border-box; 
        font-family: 'Poppins', sans-serif; 
    }

    body { 
        background-color: #f9fafb; 
        display: flex; 
        justify-content: center; 
        align-items: center; 
        min-height: 100vh; 
        color: #1f2937;
    }

    h2 { 
        text-align: center; 
        margin-bottom: 20px; 
        color: #111827; /* black heading */
    }

    /* ===== Container & Card ===== */
    .container { 
        width: 100%; 
        max-width: 500px; 
        padding: 20px; 
    }

    .card { 
        background: #ffffff; 
        border-radius: 12px; 
        padding: 30px; 
        box-shadow: 0 10px 25px rgba(0,0,0,0.08);
        border-top: 4px solid #f97316; /* orange accent */
    }

    /* ===== Form Styles ===== */
    form h3 { 
        text-align: center; 
        margin-bottom: 20px; 
        color: #f97316; /* orange title */
    }

    label { 
        display: block; 
        margin-bottom: 5px; 
        font-weight: 500; 
        color: #111827; /* black labels */
    }

    input[type="text"],
    input[type="email"],
    select { 
        width: 100%; 
        padding: 10px 15px; 
        margin-bottom: 15px; 
        border: 1px solid #e5e7eb; 
        border-radius: 6px; 
        outline: none; 
        transition: 0.3s; 
        background: #ffffff;
        color: #1f2937;
    }

    input[type="text"]:focus,
    input[type="email"]:focus,
    select:focus { 
        border-color: #f97316; /* orange focus */
    }

    input[type="checkbox"] { 
        margin-right: 8px; 
        accent-color: #f97316; 
    }

    button { 
        width: 100%; 
        padding: 12px; 
        background: #111827; /* black button */
        border: none; 
        border-radius: 6px; 
        color: #ffffff; 
        font-size: 16px; 
        font-weight: 600;
        cursor: pointer; 
        transition: 0.3s; 
        margin-top: 10px;
    }

    button:hover { 
        background: #f97316; /* orange hover */
    }

    /* ===== Message Styles ===== */
    .message { 
        padding: 10px; 
        margin-bottom: 15px; 
        border-radius: 6px; 
        text-align: center; 
        color: #065f46; 
        background-color: #ecfdf5; 
        border: 1px solid #a7f3d0; 
    }

    .error { 
        padding: 10px; 
        margin-bottom: 15px; 
        border-radius: 6px; 
        text-align: center; 
        color: #7c2d12; 
        background-color: #fff7ed; 
        border: 1px solid #fed7aa; 
    }
</style>

</head>
<body>

<h2>Volunteer Registration</h2>

<div class="container">
    <div class="card">
        <%
            String message = "";
            String messageClass = "message";

            if ("POST".equalsIgnoreCase(request.getMethod())) {
                try {
                    String fullName = request.getParameter("full_name");
                    String email = request.getParameter("email");
                    String mobile = request.getParameter("mobile");
                    String skill = request.getParameter("skill");
                    String availability = request.getParameter("availability");
                    String consentStr = request.getParameter("consent");
                    String eventIdStr = request.getParameter("event_id");

                    if (eventIdStr == null || eventIdStr.isEmpty()) {
                        message = "Error: Please select an event.";
                        messageClass = "error";
                    } else {
                        int eventId = Integer.parseInt(eventIdStr);
                        boolean consent = "1".equals(consentStr);

                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection(
                                "jdbc:mysql://localhost:3306/volunteer_db", "root", "root");

                        String sql = "INSERT INTO event_registrations (event_id, full_name, email, mobile, skill, availability, consent) "
                                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

                        PreparedStatement ps = con.prepareStatement(sql);
                        ps.setInt(1, eventId);
                        ps.setString(2, fullName);
                        ps.setString(3, email);
                        ps.setString(4, mobile);
                        ps.setString(5, skill);
                        ps.setString(6, availability);
                        ps.setBoolean(7, consent);

                        int rows = ps.executeUpdate();

                        if (rows > 0) {
                            String notifMsg = "You are successfully registered for the event!";

                            PreparedStatement notifPs = con.prepareStatement(
                              "INSERT INTO notifications (message, role, is_read, created_at) VALUES (?, 'volunteer', 0, NOW())"
                            );
                            notifPs.setString(1, notifMsg);
                            notifPs.executeUpdate();
                            notifPs.close();

                            message = "Registration successful!";
                        } 
                        else {
                            message = "Registration failed. Please try again.";
                            messageClass = "error";
                        }

                        ps.close();
                        con.close();
                    }
                }
                catch (Exception e) {
                    message = "Error: " + e.getMessage();
                    messageClass = "error";
                }
            }
        %>

        <div class="<%= messageClass %>"><%= message %></div>

        <form method="post">
            <h3>Register Now</h3>

            <label>Full Name:</label>
            <input type="text" name="full_name" required>

            <label>Email:</label>
            <input type="email" name="email" required>

            <label>Mobile:</label>
            <input type="text" name="mobile" required>

            <label>Skill:</label>
            <select name="skill" required>
                <option value="">Select Skill</option>
                <option>Medical</option>
                <option>Teaching</option>
                <option>IT</option>
                <option>Other</option>
            </select>

            <label>Availability:</label>
            <input type="text" name="availability" required>

            <label>Select Event:</label>
            <select name="event_id" required>
                <option value="">Select Event</option>
                <option value="1">Blood Donation Camp</option>
                <option value="2">Tree Plantation</option>
                <option value="3">Cleanliness Drive</option>
            </select>

            <input type="checkbox" name="consent" value="1" required>
            I confirm the information

            <button type="submit">Register</button>
        </form>
    </div>
</div>

</body>
</html>
