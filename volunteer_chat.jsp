<%@ page session="true" %>
<%
Integer volunteerId = (Integer) session.getAttribute("volunteer_id");
if(volunteerId == null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Volunteer Chat</title>

<style>
.chat-box{width:400px;margin:40px auto;border:1px solid #ccc;}
.messages{height:300px;overflow-y:auto;padding:10px;}
.msg.volunteer{text-align:right;color:#f97316;}
.msg.admin{text-align:left;color:#111827;}
</style>

<script>
function loadMessages(){
    fetch("volunteer_fetchMessages.jsp")
    .then(r=>r.text())
    .then(data=>{
        document.getElementById("messages").innerHTML=data;
    });
}
setInterval(loadMessages,2000);

function sendMessage(){
    let msg=document.getElementById("msg").value;
    fetch("volunteer_sendMessage.jsp",{
        method:"POST",
        headers:{'Content-Type':'application/x-www-form-urlencoded'},
        body:"message="+encodeURIComponent(msg)
    }).then(()=>{
        document.getElementById("msg").value="";
        loadMessages();
    });
}
</script>
</head>

<body onload="loadMessages()">

<div class="chat-box">
    <div class="messages" id="messages"></div>
    <input type="text" id="msg" placeholder="Type message">
    <button onclick="sendMessage()">Send</button>
</div>

</body>
</html>
