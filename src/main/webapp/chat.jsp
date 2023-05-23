<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>

<link rel="stylesheet" href="./css/chat.css">
<%
String uname = (String) session.getAttribute("username");
%>
<script>
var wsChat = new WebSocket(wsUrl + window.location.host
		+ "/OnlineQuiz/Chat");

function sendChat(){
	var msgContent = document.getElementById("msgContent").value;
	console.log(msgContent);
	wsChat.send( '<%=uname%>' +","+msgContent);
	document.getElementById("msgContent").value = "";
}
wsChat.onmessage = function(event) {
	$('.card-body').scrollTop(1000000);
	console.log("MSG RECEIVED : "+event.data);
	var dd = event.data.split(",");
	if(dd[0] === '<%=uname%>'){
		document.getElementById("chat-screen").innerHTML += 
		`<li class="admin clearfix">
        <span class="chat-img right clearfix  mx-2">
            <img src="http://placehold.it/50/FA6F57/fff&text=ME" alt="Admin" class="img-circle" />
        </span>
        <div class="chat-body clearfix">
            <div class="header clearfix">
                
                <strong class="right primary-font">` + dd[0] + `</strong>
            </div>
            <p>
            ` + dd[1] + `
            </p>
        </div>
    </li>`;
    
		
	}else{
		document.getElementById("chat-screen").innerHTML += 
		` <li class="agent clearfix">
        <span class="chat-img left clearfix mx-2">
            <img src="http://placehold.it/50/55C1E7/fff&text=`+dd[0].substr(0,1) + `" alt="Agent" class="img-circle" />
        </span>
        <div class="chat-body clearfix">
            <div class="header clearfix">
                <strong class="primary-font">` + dd[0] + `</strong> <small class="right text-muted">
                    
            </div>
            <p>
                ` + dd[1] + ` 
            </p>
        </div>
    </li> `;
	}
	
}
</script>
<div class="col-md-3 mx-auto" style="float: right; margin-top: 10px;">
	<div class="card">
		<div class="card-header text-center">
			<span>Chat Box</span>
		</div>
		<div class="card-body chat-care">
			<ul class="chat" id="chat-screen">



			</ul>
		</div>
		<div class="card-footer">
			<div class="input-group">
				<input id="msgContent" type="text" class="form-control input-sm"
					placeholder="Type your message here..." /> <span
					class="input-group-btn">
					<button class="btn btn-primary" id="btn-chat" onClick="sendChat()">
						Send</button>
				</span>
			</div>
		</div>
	</div>
</div>

</html>