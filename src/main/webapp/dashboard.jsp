<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<jsp:include page="header.jsp" />
<jsp:include page="auth.jsp" />
<link rel="stylesheet" href="css/dashboard.css">
<link rel="stylesheet" href="css/anime.css">

<style>
.table tr th:first-child, .table tr td:first-child {
	width: 10%;
}

.table tr th:last-child, .table tr td:last-child {
	width: 15%;
}

.table tr th:nth-child(3), .table tr td:nth-child(3) {
	width: 15%;
}
</style>

<title>DashBoard</title>
</head>
<body>
	<div class="back">
		<img src="img/4.jpg" class="bgimg" type="jpg/jpeg">
	</div>
	
	<%@page import="java.sql.*"%>
		<%@page import="javax.servlet.*, javax.servlet.http.*, models.User"%>

		<%
		String username;
		Connection con;
		Statement stmt, stmt2;
		ResultSet rs, rs2;
		User user = null;

		HttpSession sess;
		sess = request.getSession();
		username = (String) sess.getAttribute("username");

		Class.forName("com.mysql.cj.jdbc.Driver");
		// con = DriverManager.getConnection("jdbc:mysql://bxdckaiotjos6uxqsxij-mysql.services.clever-cloud.com:3306/bxdckaiotjos6uxqsxij", "u1bl3chv4wysc2pd", "fFWLbfvEvE8CYje7Cv3o");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/online-quiz", "root", "");
		stmt = con.createStatement();
		stmt2 = con.createStatement();
		
		rs2 = stmt2.executeQuery("SELECT * FROM users WHERE username='"+username+"'");
		if(rs2.next()) user = new User(username, rs2.getString("name"), rs2.getString("email"));
		if(user == null) response.sendRedirect("index.jsp");
		
		rs = stmt.executeQuery(
				"SELECT *, (SELECT AVG(rating) FROM feedback WHERE quiz.quizid=quizid) as total FROM quiz WHERE username='" + username + "' ORDER BY timestamp DESC;");
		int i = 1;
		%>

	<div class="container-fluid text-center">
		<div class="row1">
			<div class="col-md-12">
				<p class="text-right heading">
					<a class="btn btn-danger" href="Logout"><i
						class="fa fa-sign-out" aria-hidden="true"></i> Logout</a>
				</p>
				<h1 class="heading">Welcome, <%=user.name %>!</h1>

			</div>
		</div>
		<div class="row" style="margin-top: 15vh">

			<div class="col animated slideInLeft">
				<a class="btn btn-primary tbtn" href="#createQuizModal"
					data-toggle="modal"><h1 class="q">
						<i class="fa fa-plus" aria-hidden="true"></i> Create Quiz
					</h1></a>
			</div>
			<div class="col animated slideInRight">
				<a class="btn btn-danger tbtn" href="#participateModal"
					data-toggle="modal">
					<h1 class="q">
						<i class="fa fa-graduation-cap" aria-hidden="true"></i>
						Participate
					</h1>
				</a>
			</div>
		</div>
		<div class="row mt-5">
			<div class="col-md-12">
		<%
		if(rs.isBeforeFirst()) {
		%>
				<table class="table table-hover table-light table-borderless"
					style="width: 60%; margin: 0 auto;'">
					<thead class="thead-dark">
						<tr>
							<th scope="col">No.</th>
							<th scope="col">Quiz Name</th>
							<th scope="col">Rating</th>
							<th scope="col">View</th>
							<th scope="col">Delete</th>
						</tr>
					</thead>
					<tbody>
						<%
						while (rs.next()) {
							String quizid = rs.getString("quizid");
							String quizname = rs.getString("quizname");
							double total = rs.getDouble("total");
						%>
						<tr>
							<th scope="row"><%=i++%></th>
							<td><%=quizname%></td>
							<td>
                                <span class="fa fa-star<%=total>0?(total<1?"-half-o":""):"-o"%>"></span>
                                <span class="fa fa-star<%=total>1?(total<2?"-half-o":""):"-o"%>"></span>
                                <span class="fa fa-star<%=total>2?(total<3?"-half-o":""):"-o"%>"></span>
                                <span class="fa fa-star<%=total>3?(total<4?"-half-o":""):"-o"%>"></span>
                                <span class="fa fa-star<%=total>4?(total<5?"-half-o":""):"-o"%>"></span>
                            </td>
							<td><a class="btn btn-info"
								href="quiz.jsp?id=<%=quizid%>&name=<%=quizname%>"><i
									class="fa fa-eye" aria-hidden="true"></i> View</a></td>
							<td><a class="btn btn-danger"
								href="DeleteQuiz?id=<%=quizid%>"><i class="fa fa-trash"
									aria-hidden="true"></i> Delete</a></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
		<%
		} else {
			%>
			<div class="jumbotron"><h2>You haven't created any quiz yet!</h2></div>
			<%
		}
		%>

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
</body>

<!-- Create Modal HTML -->
<div id="createQuizModal" class="modal fade" style="z-index: 9999;"
	role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="card">
				<form method="post" action="CreateQuiz">
					<div class="card-header">
						<h2 class="custom-heading">Quiz</h2>
					</div>

					<div class="card-body">
						<div class="form-group">
							<input type="text" name="quizname" class="form-control"
								placeholder="Quiz Name" required />
						</div>

						<div class="form-group">
							<input type="submit" name="submit" value="Create"
								class="btn btn-success bb">
						</div>
					</div>
				</form>

			</div>
		</div>
	</div>
</div>

<!-- Participate Modal HTML -->
<div id="participateModal" class="modal fade" style="z-index: 9999;"
	role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="card">
				<form method="get" action="participate.jsp">
					<div class="card-header">
						<h2 class="custom-heading">Participate</h2>
					</div>

					<div class="card-body">
						<div class="form-group">
							<input type="text" name="id" class="form-control"
								placeholder="Quiz ID" required />
						</div>

						<div class="form-group">
							<input type="submit" value="Participate"
								class="btn btn-success bb">
						</div>
					</div>
				</form>

			</div>
		</div>
	</div>
</div>

</html>
</body>
</html>