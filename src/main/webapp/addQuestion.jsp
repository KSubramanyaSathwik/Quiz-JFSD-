<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<jsp:include page="header.jsp" />

<%
session = request.getSession(true);
if (session.getAttribute("username") != null) {
%>
<jsp:forward page="dashboard.jsp" />
<%
}
%>
<title>Insert title here</title>
</head>
<body>
	<div class="card custom-card">

		<form method="post" id="lol">

			<div class="card-header">
				<h2 class="custom-heading">Add Question</h2>
			</div>

			<div class="card-body">

				<div class="form-group">
					<input type="text" name="que" class="form-control"
						placeholder="Enter Question" required />
				</div>
				<div class="form-group">
					<input type="text" name="o1" class="form-control"
						placeholder="A" required />
				</div>
				<div class="form-group">
					<input type="text" name="o2" class="form-control"
						placeholder="B" required />
				</div>
				<div class="form-group">
					<input type="text" name="o3" class="form-control"
						placeholder="C"/>
				</div>
				<div class="form-group">
					<input type="text" name="o4" class="form-control"
						placeholder="D"/>
				</div>
				<div class="form-group">
					<input type="text" name="ra" class="form-control"
						placeholder="Correct Answer" required />
				</div>
				<div class="form-group">
					<input type="submit" name="submit" value="Add"
						class="btn btn-success bb">
				</div>
			</div>
		</form>

	</div>
</body>
</html>