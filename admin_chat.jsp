<%@ page session="true" %>
<%
Integer adminId = (Integer) session.getAttribute("admin_id");
if(adminId == null){
    response.sendRedirect("admin_login.jsp");
    return;
}
int volunteerId = Integer.parseInt(request.getParameter("volunteer_id"));
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Chat</title>

<style>
.chat-box{width:450px;margin:40px auto;border:1px solid #ccc;}
.messages{height:300px;overflow-y:auto;padding:10px;}
.msg.admin{text-align:right;color:#111827;}
.msg.volunteer{text-align:left;color:#f97316;}
</style>

<script>
function loadMessages(){
    fetch("admin_fetchMessages.jsp?volunteer_id=<%=volunteerId%>")
    .then(r=>r.text())
    .then(data=>{
        document.getElementById("messages").innerHTML=data;
    });
}
setInterval(loadMessages,2000);

function sendMessage(){
    let msg=document.getElementById("msg").value;
    fetch("admin_sendMessage.jsp",{
        method:"POST",
        headers:{'Content-Type':'application/x-www-form-urlencoded'},
        body:"message="+encodeURIComponent(msg)+"&volunteer_id=<%=volunteerId%>"
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
    <input type="text" id="msg">
    <button onclick="sendMessage()">Send</button>
</div>

</body>
</html>
