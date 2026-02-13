<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cloud-Based Volunteer Coordination System</title>

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<!-- AOS Animation Library -->
<link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
<style>
* { box-sizing: border-box; margin:0; padding:0; font-family: 'Poppins', sans-serif; }

/* ---------- BODY ---------- */
body {
    background: linear-gradient(120deg, #f4f7fb, #e8f0f8);
    color: #333;
}

/* ---------- TOP HEADER ---------- */
.top-header {
    background: #1d3557;
    color: white;
    padding: 14px 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: sticky;
    top:0;
    z-index: 100;
}

.top-header h3 { font-weight: 600; }
.top-header i {
    font-size: 24px;
    color: #fff;
    transition: 0.3s;
}
.top-header i:hover {
    color: #e63946;
    transform: scale(1.3);
}

/* ---------- HERO ---------- */
.hero {
    position: relative;
    height: 90vh;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
}

.hero video {
    position: absolute;
    top: 0; left: 0;
    width: 100%; height: 100%;
    object-fit: cover;
    z-index: 1;
    filter: brightness(0.6);
}

.hero-content {
    position: relative;
    z-index: 2;
    text-align: center;
    color: white;
    padding: 20px;
    animation: fadeInUp 1.5s ease forwards;
}

.hero-content h1 {
    font-size: 48px;
    margin-bottom: 15px;
    text-shadow: 2px 2px 6px rgba(0,0,0,0.5);
}

.hero-content p {
    font-size: 20px;
    margin-bottom: 25px;
    text-shadow: 1px 1px 4px rgba(0,0,0,0.5);
}

.btn {
    padding: 14px 32px;
    border-radius: 30px;
    font-weight: 600;
    margin: 8px;
    text-decoration: none;
    display: inline-block;
    transition: 0.3s;
}

.btn-primary {
    background: linear-gradient(45deg, #e63946, #f77f00);
    color: white;
}
.btn-primary:hover {
    transform: scale(1.05);
}

.btn-secondary {
    background: white;
    color: #1d3557;
}
.btn-secondary:hover {
    background: transparent;
    color: white;
    border: 2px solid white;
}

/* ---------- SECTIONS ---------- */
section {
    padding: 80px 20px;
    text-align: center;
}
section h2 {
    font-size: 36px;
    color: #1d3557;
    margin-bottom: 25px;
}
section p {
    max-width: 900px;
    margin: auto;
    line-height: 1.8;
    color: #555;
}

/* ---------- IMAGE GALLERY ---------- */
.gallery {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 25px;
    margin-top: 40px;
}
.gallery img {
    width: 100%;
    height: 250px;
    object-fit: cover;
    border-radius: 15px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
    transition: transform 0.5s, box-shadow 0.5s;
}
.gallery img:hover {
    transform: scale(1.08);
    box-shadow: 0 15px 35px rgba(0,0,0,0.25);
}

/* ---------- FEATURES ---------- */
.features {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 25px;
    margin-top: 40px;
}
.feature-box {
    background: white;
    padding: 30px 20px;
    border-radius: 15px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.08);
    transition: transform 0.3s, box-shadow 0.3s;
}
.feature-box:hover {
    transform: translateY(-10px);
    box-shadow: 0 15px 35px rgba(0,0,0,0.15);
}
.feature-box h3 {
    color: #e63946;
    margin-bottom: 12px;
}

/* ---------- FOOTER ---------- */
footer {
    background: #1d3557;
    color: white;
    text-align: center;
    padding: 30px;
}
footer i {
    font-size: 20px;
    margin-left: 10px;
    transition: 0.3s;
}
footer i:hover {
    color: #e63946;
}

/* ---------- ANIMATIONS ---------- */
@keyframes fadeInUp {
    0% { opacity: 0; transform: translateY(40px);}
    100% { opacity: 1; transform: translateY(0);}
}
</style>
</head>

<body>

<!-- TOP HEADER -->
<div class="top-header">
    <h3>Cloud-Based Volunteer Coordination System</h3>
    <a href="https://www.instagram.com/gadkari_trekkers/" target="_blank">
        <i class="fa-brands fa-instagram"></i>
    </a>
</div>

<!-- HERO SECTION WITH VIDEO -->
<div class="hero">
    <video autoplay muted loop>
        <source src="video/video2.mp4" type="video/mp4">
        Your browser does not support HTML5 video.
    </video>
    <div class="hero-content">
        <h1 data-aos="fade-up">Gadkari Trekkers Volunteer Platform</h1>
        <p data-aos="fade-up" data-aos-delay="200">Connecting Volunteers • Organizing Treks • Building Community</p>

        <a href="loginVolunteer.jsp" class="btn btn-primary" data-aos="fade-up" data-aos-delay="400">Become a Volunteer</a>
        <a href="adminLogin.jsp" class="btn btn-secondary" data-aos="fade-up" data-aos-delay="600">Admin Login</a>
    </div>
</div>

<!-- ABOUT -->
<section data-aos="fade-up">
    <h2>About Gadkari Trekkers</h2>
    <p>
        Gadkari Trekkers is a passionate trekking community focused on
        adventure, nature conservation, and teamwork. This cloud-based system
        helps manage volunteers, events, and communication efficiently.
    </p>
</section>

<!-- ACTIVITY GALLERY -->
<section data-aos="fade-up">
    <h2>Our Trekking Activities</h2>
    <div class="gallery">
        <img src="${pageContext.request.contextPath}/img/trek2.jpg" alt="Trek 1">
        <img src="${pageContext.request.contextPath}/img/trek3.jpg" alt="Trek 2">
        <img src="${pageContext.request.contextPath}/img/trek1.jpg" alt="Trek 3">
        <img src="${pageContext.request.contextPath}/img/trek7.jpg" alt="Trek 4">
        <img src="${pageContext.request.contextPath}/img/trek5.jpg" alt="Trek 5">
        <img src="${pageContext.request.contextPath}/img/trek6.jpg" alt="Trek 6">
    </div>
</section>

<!-- FEATURES -->
<section data-aos="fade-up">
    <h2>System Features</h2>
    <div class="features">
        <div class="feature-box" data-aos="fade-up" data-aos-delay="100">
            <h3>Volunteer Registration</h3>
            <p>Easy onboarding and login.</p>
        </div>
        <div class="feature-box" data-aos="fade-up" data-aos-delay="200">
            <h3>Event Management</h3>
            <p>Create and manage treks.</p>
        </div>
        <div class="feature-box" data-aos="fade-up" data-aos-delay="300">
            <h3>Task Assignment</h3>
            <p>Assign roles to volunteers.</p>
        </div>
        <div class="feature-box" data-aos="fade-up" data-aos-delay="400">
            <h3>Notifications</h3>
            <p>Instant updates & alerts.</p>
        </div>
    </div>
</section>

<!-- FOOTER -->
<footer data-aos="fade-up">
    © 2026 Cloud-Based Volunteer Coordination System |
    Follow us
    <a href="https://www.instagram.com/gadkari_trekkers/" target="_blank">
        <i class="fa-brands fa-instagram"></i>
    </a>
</footer>

<!-- AOS JS -->
<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init({
        duration: 1200,
        once: true
    });
</script>

</body>
</html>
