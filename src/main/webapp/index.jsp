<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<jsp:include page="header.jsp" />

<%
session = request.getSession(true);
if (session.getAttribute("username") != null) {
%>
<jsp:forward page="dashboard.jsp" />
<%
}
%>

<title>Online Quiz - Login</title>
</head>
<body>
	<div class="back">
		<img src="img/1.jpg" class="bgimg" type="jpg/jpeg">
	</div>
	<div class="card custom-card">
		<div class="card-header">
			<h2 class="custom-heading">Login</h2>
		</div>
		<div class="card-body">
			<form action="Login" method="post">
				<div class="form-group">
					<input type="text" name="username" class="form-control"
						placeholder="Username" />
				</div>

				<div class="form-group">
					<input type="password" name="password" class="form-control"
						placeholder="Password" />
				</div>

				<!-- <div class="form-check">
					<input class="form-check-input" type="checkbox" value=""
						id="defaultCheck1"> <label class="form-check-label"
						for="defaultCheck1"> Remember Me </label>
				</div> -->

				<button type="submit" class="btn btn-success"><i class="fa fa-sign-out" aria-hidden="true"></i> Login</button>
			</form>
			<br /> <a href="register.jsp"><button class="btn btn-primary"><i class="fa fa-user-circle" aria-hidden="true"></i> Register</button></a>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</html>