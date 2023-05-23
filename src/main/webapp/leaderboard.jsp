<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<jsp:include page="header.jsp" />
<title>Winners</title>
<style>
.demo {
	background: #dad9d4;
}

.progress {
	height: 40px;
	background: #fff;
	border-radius: 100px;
	box-shadow: none;
	margin-top: 40px;
	position: relative;
}

.progress .progress-title {
	width: 20%;
	height: 100%;
	background: #fff;
	border-radius: 100px 0 0 100px;
	float: left;
	margin: 0;
	font-size: 15px;
	color: #000;
	line-height: 40px;
	letter-spacing: 1px;
	text-align: center;
	text-transform: uppercase;
	position: relative;
}

.progress .progress-title:after {
	content: "";
	border-left: 10px solid #fff;
	border-top: 10px solid transparent;
	border-bottom: 10px solid transparent;
	position: absolute;
	top: 10px;
	right: -10px;
	z-index: 1;
}

.progress .progress-bar {
	width: 80%;
	background: #fff;
	box-shadow: none;
	position: relative;
}

.progress .progress-value {
	height: 100%;
	border-radius: 0 100px 100px 0;
	font-size: 15px;
	font-weight: bold;
	line-height: 40px;
	color: #fff;
	animation: animate-positive 2s;
}

.progress.red .progress-value{ background: #e53935; }
.progress.pink .progress-value{ background: #D81B60; }
.progress.purple .progress-value{ background: #8E24AA; }
.progress.deeppurple .progress-value{ background: #5E35B1; }
.progress.indigo .progress-value{ background: #3949AB; }
.progress.blue .progress-value{ background: #1E88E5; }
.progress.lightblue .progress-value{ background: #039BE5; }
.progress.cyan .progress-value{ background: #00ACC1; }
.progress.teal .progress-value{ background: #00897B; }
.progress.green .progress-value{ background: #43A047; }
.progress.lightgreen .progress-value{ background: #7CB342; }
.progress.lime .progress-value{ background: #C0CA33; }
.progress.yellow .progress-value{ background: #FDD835; }
.progress.amber .progress-value{ background: #FFB300; }
.progress.orange .progress-value{ background: #FB8C00; }
.progress.deeporange .progress-value{ background: #F4511E; }
.progress.brown .progress-value{ background: #6D4C41; }
.progress.grey .progress-value{ background: #757575; }
.progress.bluegrey .progress-value{ background: #546E7A; }

@keyframes animate-positive { 
	0%{ width: 0%; }
}
@media only screen and (max-width: 480px) {
	.progress .progress-title {
		font-size: 12px;
		letter-spacing: 0;
	}
}
</style>
</head>
<body>
	<div class="back">
		<img src="img/5.jpg" class="bgimg" type="jpg/jpeg">
	</div>

	<div class="container-fluid text-center mt-5">
		<div class="row1">
			<div class="col-md-12">
				<p class="text-right heading">
					<a class="btn btn-primary float-left" href="dashboard.jsp"> <i class="fa fa-arrow-left" aria-hidden="true"></i> 
						Dashboard</a> <a class="btn btn-danger" href="Logout"><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</a>
				</p>
				<h1 style="color: white">Leaderboard</h1>
			</div>
		</div>
		<div class="row mt-4">
			<div class="col-md-12">
				<%@page import="java.sql.*, java.lang.Math"%>
				<%@page import="javax.servlet.*, javax.servlet.http.*"%>

				<%
				String[] color = { "red", "pink", "purple", "deeppurple", "indigo", "blue", "lightblue", "cyan", "teal", "green",
						"lightgreen", "lime", "yellow","amber","orange","deeporange", "brown", "grey", "bluegrey" };
				Connection con;
				Statement stmt;
				ResultSet rs;

				String quizid = request.getParameter("id");
				Class.forName("com.mysql.cj.jdbc.Driver");
				// con = DriverManager.getConnection("jdbc:mysql://bxdckaiotjos6uxqsxij-mysql.services.clever-cloud.com:3306/bxdckaiotjos6uxqsxij", "u1bl3chv4wysc2pd", "fFWLbfvEvE8CYje7Cv3o");
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/online-quiz", "root", "");
				stmt = con.createStatement();
				rs = stmt.executeQuery("Select Count(questionid) from questions where quizid='" + quizid + "'");
				rs.next();
				int totalQuestion = rs.getInt(1);
				String sql = "SELECT s.username, SUM(s.isCorrect) AS score FROM quiz qu, scoreboard s WHERE qu.quizid='" + quizid
						+ "' and s.questionid IN(SELECT questionid FROM questions WHERE quizid='" + quizid
						+ "') GROUP BY username ORDER BY score DESC;";
				rs = stmt.executeQuery(sql);
				int i = 1;
				while (rs.next()) {
					String username = rs.getString("username");
					int score = rs.getInt("score");
					float percentage = (float) ((float) score / totalQuestion) * 100;
				%>

				<div class="progress <%=color[(int) (Math.random() * 19)]%>">
					<h3 class="progress-title"><%=username%></h3>
					<div class="progress-bar">
						<div class="progress-value" style="width: <%=percentage%>%;"><%=score%></div>
					</div>
				</div>
				<%
				}
				%>
			</div>
		</div>
		
		<div class="row mt-5">
		  <div class="col col-lg-4"></div>
		    <div class="col col-lg-4 text-center">	
				<a href="rate.jsp?id=<%= quizid %>" class="btn btn-warning btn-lg" style="font-weight:bold;"> Rate this Presentation </a>	
			</div>
			<div class="col col-lg-4"></div>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</html>