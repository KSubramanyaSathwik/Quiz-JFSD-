<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<jsp:include page="header.jsp" />
<jsp:include page="auth.jsp" />
<title>Participate</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">

<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Montserrat&display=swap')
	;

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box
}

body {
	background-color: #333
}

.container-question {
	background-color: #555;
	color: #ddd;
	border-radius: 10px;
	padding: 10px;
	font-family: 'Montserrat', sans-serif;
	max-width: 700px
}

.container>p {
	font-size: 32px
}

.question {
	width: 75%
}

.options {
	position: relative;
	padding-left: 40px
}

#options label {
	display: block;
	margin-bottom: 15px;
	font-size: 14px;
	cursor: pointer
}

.options input {
	opacity: 0
}

.checkmark {
	position: absolute;
	top: -1px;
	left: 0;
	height: 25px;
	width: 25px;
	background-color: #555;
	border: 1px solid #ddd;
	border-radius: 50%
}

.options input:checked ~.checkmark:after {
	display: block
}

.options .checkmark:after {
	content: "";
	width: 10px;
	height: 10px;
	display: block;
	background: white;
	position: absolute;
	top: 50%;
	left: 50%;
	border-radius: 50%;
	transform: translate(-50%, -50%) scale(0);
	transition: 300ms ease-in-out 0s
}

.options input[type="radio"]:checked ~.checkmark {
	background: #21bf73;
	transition: 300ms ease-in-out 0s
}

.options input[type="radio"]:checked ~.checkmark:after {
	transform: translate(-50%, -50%) scale(1)
}

.btn-primary {
	background-color: #555;
	color: #ddd;
	border: 1px solid #ddd
}

.btn-primary:hover {
	background-color: #21bf73;
	border: 1px solid #21bf73
}

.btn-success {
	padding: 5px 25px;
	background-color: #21bf73
}


@media ( max-width :576px) {
	.question {
		width: 100%;
		word-spacing: 2px
	}
}
</style>
<script type="text/javascript">
	var quizid =
<%=request.getParameter("id")%>
	;
	console.log(quizid);
	var wsUrl;
	if (window.location.protocol == 'http:') {
		wsUrl = 'ws://';
	} else {
		wsUrl = 'wss://';
	}
	var ws = new WebSocket(wsUrl + window.location.host
			+ "/OnlineQuiz/SendQuestion");
	var ws5 = new WebSocket(wsUrl + window.location.host
			+ "/OnlineQuiz/SubmitAnswer");
	var currentQuestion;
	
	var ws2 = new WebSocket(wsUrl + window.location.host
			+ "/OnlineQuiz/GetDetails");
	
	var ws33 = new WebSocket(wsUrl + window.location.host
			+ "/OnlineQuiz/GetScores");

	ws33.onmessage = function(event) {
		var result = event.data.split(',');
		console.log(result);
		document.getElementById("teebodee").innerHTML = "";
		for(let i = 0; i < result.length; i++) {
			let j = i + 1;
			var dat = result[i].split(":");
			document.getElementById("teebodee").innerHTML += '<tr><th scope="row">' + j + '</th><td>'+dat[0]+'</td><td>'+dat[1]+'/'+dat[2]+'</td></tr>';				
		}
	}
	
	ws33.onerror = function(event) {
		console.log("Error ws30", event)
	}

	ws2.onmessage = function(event) {
		var result = event.data.split(',');
		//if(result[0].indexOf(":") == -1) {
			google.charts.load('current', {'packages':['corechart']});
			google.charts.setOnLoadCallback(drawChart);
			function drawChart() {
				var data = google.visualization.arrayToDataTable([
					['Result', 'Total'],
					['Correct Answers', parseInt(result[0])],
					['Wrong Answers', parseInt(result[1])]
					]);
				
				var options = {
					title: 'Score in percentage'
				};
			
				var chart = new google.visualization.PieChart(document.getElementById('piechart'));
				chart.draw(data, options);
			}
		//}
			/*else {
				console.log(result);
				document.getElementById("teebodee").innerHTML = "";
				for(let i = 0; i < result.length; i++) {
					let j = i + 1;
					var dat = result[i].split(":");
					document.getElementById("teebodee").innerHTML += '<tr><th scope="row">' + j + '</th><td>'+dat[0]+'</td><td>'+dat[1]+'/'+dat[2]+'</td></tr>';				
				}
			}*/
	};
	
	ws2.onerror = function(event) {
		console.log("Error ", event)
	}

	ws.onmessage = function(event) {
		if (event.data.indexOf("nextquestion") > -1) {
			var strs = event.data.split(",");
			if (strs[1] == quizid) {
				$("#scoreboard").modal("hide");
				document.getElementById("smbtn").disabled = false;
				document.getElementById("loading").style.display = "none";
				var btns = document.getElementsByName("radio");
				for (let i = 0; i < btns.length; i++) {
					if (btns[i].checked) {
						btns[i].checked = false;
					}
				}
			}
			return;
		}

		if (event.data.indexOf("scoreboard") > -1) {
			var strs = event.data.split(",");
			if (strs[1] == quizid) {
				var crtans;
				switch(currentQuestion['ca']) {
					case '1': crtans = 'A'; break;
					case '2': crtans = 'B'; break;
					case '3': crtans = 'C'; break;
					case '4': crtans = 'D'; break;
					default: crtans = ''; break;
				}
				document.getElementById("crtans").innerHTML = "<b>Correct Answer: " + crtans + "</b>";
				$("#scoreboard").modal("show");
			}
			return;
		}

		const question = JSON.parse(event.data);
		currentQuestion = question;

		if (question['quizid'] == quizid) {
			document.getElementById("startpt").style.display = 'none';
			document.getElementById("qdata").style.display = 'block';
			document.getElementById("disp_qname").innerHTML = question['qname'];
			document.getElementById("disp_a").innerHTML = question['a'];
			document.getElementById("disp_b").innerHTML = question['b'];
			document.getElementById("disp_c").innerHTML = question['c'];
			document.getElementById("disp_d").innerHTML = question['d'];
			if(question['isLast']) {
				document.getElementById("nextqbtn").innerHTML = '<a href="leaderboard.jsp?id='+quizid+'" class="btn btn-info btn-lg" role="alert"><i class="fa fa-trophy" aria-hidden="true"></i> Display Results</a>';
			}
		}
	};

	ws.onerror = function(event) {
		console.log("Error ", event)
	}
	
	ws5.onerror = function(event) {
		console.log("Error ", event)
	}

	function sendMsg(msg) {
		if (msg) {
			ws.send(msg);
		}
	}

	function submitAnswer() {
		document.getElementById("smbtn").disabled = true;
		document.getElementById("loading").style.display = "block";
		var selectedValue = 0;
		var btns = document.getElementsByName("radio");
		for (let i = 0; i < btns.length; i++) {
			if (btns[i].checked) {
				selectedValue = i + 1;
			}
		}
		<%String uname = (String) session.getAttribute("username");%>
		var isCorrect = selectedValue == currentQuestion['ca'] ? 1: 0;
		var msg = currentQuestion['qid'] + "," + "<%=uname%>" + "," + selectedValue + "," + isCorrect;
		console.log("MSG: " + msg);
		ws5.send(msg);
	}
	
	<%-- var wsChat = new WebSocket(wsUrl + window.location.host
			+ "/OnlineQuiz/Chat");
	
	function sendChat(){
		var msgContent = document.getElementById("msgContent").value;
		console.log(msgContent);
		wsChat.send( '<%=uname%>' +","+msgContent);
		document.getElementById("msgContent").value = "";
	}
	wsChat.onmessage = function(event) {
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
		
	} --%>
	
</script>
</head>
<body onload="sendMsg('')">
	<jsp:include page="navbar.jsp" />
	<jsp:include page="scoreboard.jsp" />
	<script>
		document.getElementById("nextqbtn").innerHTML = '<div style="text-align: center;" class="alert alert-info" role="alert"><i class="fa fa-hourglass-end" aria-hidden="true"></i> Waiting for presenter...</div>';
	</script>

	<%
	String quizid = request.getParameter("id");
	if (db.Database.quizExists(quizid)) {
	%>

	<div id="startpt" class="jumbotron" style="text-align: center;">
		<h3><i class="fa fa-hourglass-end" aria-hidden="true"></i> Please wait for the question!</h3>
	</div>
	<div class="row ">
	<div id="qdata" class="col-md-8" style="display: none;">
		<div class="container container-question mt-sm-5 my-1">
			<div class="question ml-sm-5 pl-sm-5 pt-2">
				<div class="py-2 h5">
					<b id="disp_qname"></b>
				</div>
				<div class="" id="options">
					<label class="options"><span id="disp_a"></span><input
						type="radio" name="radio"> <span class="checkmark"></span>
					</label> <label class="options"><span id="disp_b"></span><input
						type="radio" name="radio"> <span class="checkmark"></span>
					</label> <label class="options"><span id="disp_c"></span><input
						type="radio" name="radio"> <span class="checkmark"></span>
					</label> <label class="options"><span id="disp_d"></span><input
						type="radio" name="radio"> <span class="checkmark"></span>
					</label>
					<button id="smbtn" class="btn btn-success btn-lg"
						onclick="submitAnswer()" style="float:right"><i class="fa fa-thumbs-up" aria-hidden="true"></i> Submit</button>
					<br /> <br />
					<div id="loading" style="display: none; text-align: center;"
						class="alert alert-info" role="alert"><i class="fa fa-hourglass-end" aria-hidden="true"></i> Waiting for results...</div>
				</div>
			</div>
		</div>
		
			<!-- <div class="col-md-3 mx-auto" style="float:right;margin-top: 10px;">
            <div class="card">
                <div class="card-header text-center">
                    <span>Chat Box</span>
                </div>
                <div class="card-body chat-care">
                    <ul class="chat" id = "chat-screen">
                        
                        
                        
                    </ul>
                </div>
                <div class="card-footer">
                    <div class="input-group">
                        <input id="msgContent" type="text" class="form-control input-sm" placeholder="Type your message here..." />
                        <span class="input-group-btn">
                            <button class="btn btn-primary" id="btn-chat" onClick="sendChat()">
                                Send</button>
                        </span>
                    </div>
                </div>
            </div>
        </div> -->
		</div>
		<jsp:include page="chat.jsp" />
	</div>
	<%
	} else {
	%>
	<div style="text-align: center;" class="jumbotron">
		No such quiz available.<br> <a href="dashboard.jsp"
			class="btn btn-info">Dashboard</a>
	</div>
	<%
	}
	%>
</body>



<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
	integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	crossorigin="anonymous"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script>
</html>
</html>