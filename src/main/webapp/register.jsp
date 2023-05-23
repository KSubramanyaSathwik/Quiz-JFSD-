<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<jsp:include page="header.jsp" />
<title>Register</title>
</head>
<body>
	<div class="back">
		<img src="img/3.jpg" class="bgimg" type="jpg/jpeg">
	</div>
	<div class="card custom-card">
		<div class="card-header"><h2 class="custom-heading">Register</h2></div>
		<div class="card-body">
			<form action="Register" method="post">
				<div class="form-group" >
					<input type="text" name="name" class="form-control" placeholder="Full Name" />
				</div>

				<div class="form-group" >
					<input type="text" name="email" class="form-control" placeholder="Email" />
				</div>

				<div class="form-group" >
					<input type="text" name="username" class="form-control" placeholder="Username" />
				</div>

				<div class="form-group" >
					<input type="password" name="password" class="form-control" placeholder="Password" />
				</div>

				<div class="form-group" >
					<input type="password" name="repassword" class="form-control" placeholder="Re-enter Password" />
				</div>

				<div class="form-group">
					<button type="submit" class="btn btn-primary" ><i class="fa fa-user-circle" aria-hidden="true"></i> Register</button>
				</div>
			</form>
			<br>
			<a href="index.jsp"><button class="btn btn-success">Already have an account? Login <i class="fa fa-sign-in" aria-hidden="true"></i></button></a>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</html>