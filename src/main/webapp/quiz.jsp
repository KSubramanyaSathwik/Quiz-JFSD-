<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
	color: #566787;
	background: #f5f5f5;
	font-family: 'Varela Round', sans-serif;
	font-size: 13px;
}

.table-responsive {
	margin: 30px 0;
}

.table-wrapper {
	background: #fff;
	padding: 20px 25px;
	border-radius: 3px;
	min-width: 1000px;
	box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
}

.table-title {
	padding-bottom: 15px;
	background: #435d7d;
	color: #fff;
	padding: 16px 30px;
	min-width: 100%;
	margin: -20px -25px 10px;
	border-radius: 3px 3px 0 0;
}

.table-title h2 {
	margin: 5px 0 0;
	font-size: 24px;
}

.table-title .btn-group {
	float: right;
}

.table-title .btn {
	color: #fff;
	float: right;
	font-size: 13px;
	border: none;
	min-width: 50px;
	border-radius: 2px;
	border: none;
	outline: none !important;
	margin-left: 10px;
}

.table-title .btn i {
	float: left;
	font-size: 21px;
	margin-right: 5px;
}

.table-title .btn span {
	float: left;
	margin-top: 2px;
}

table.table tr th, table.table tr td {
	border-color: #e9e9e9;
	padding: 12px 15px;
	vertical-align: middle;
}

table.table tr th:first-child {
	width: 60%;
}

table.table tr th:last-child {
	width: 30%;
}

table.table-striped tbody tr:nth-of-type(odd) {
	background-color: #fcfcfc;
}

table.table-striped.table-hover tbody tr:hover {
	background: #f5f5f5;
}

table.table th i {
	font-size: 13px;
	margin: 0 5px;
	cursor: pointer;
}

table.table td:last-child i {
	opacity: 0.9;
	font-size: 22px;
	margin: 0 5px;
}

table.table td a {
	font-weight: bold;
	color: #566787;
	display: inline-block;
	text-decoration: none;
	outline: none !important;
}

table.table td a:hover {
	color: #2196F3;
}

table.table td a.edit {
	color: #FFC107;
}

table.table td a.delete {
	color: #F44336;
}

table.table td i {
	font-size: 19px;
}

table.table .avatar {
	border-radius: 50%;
	vertical-align: middle;
	margin-right: 10px;
}

.pagination {
	float: right;
	margin: 0 0 5px;
}

.pagination li a {
	border: none;
	font-size: 13px;
	min-width: 30px;
	min-height: 30px;
	color: #999;
	margin: 0 2px;
	line-height: 30px;
	border-radius: 2px !important;
	text-align: center;
	padding: 0 6px;
}

.pagination li a:hover {
	color: #666;
}

.pagination li.active a, .pagination li.active a.page-link {
	background: #03A9F4;
}

.pagination li.active a:hover {
	background: #0397d6;
}

.pagination li.disabled i {
	color: #ccc;
}

.pagination li i {
	font-size: 16px;
	padding-top: 6px
}

.hint-text {
	float: left;
	margin-top: 10px;
	font-size: 13px;
}
/* Custom checkbox */
.custom-checkbox {
	position: relative;
}

.custom-checkbox input[type="checkbox"] {
	opacity: 0;
	position: absolute;
	margin: 5px 0 0 3px;
	z-index: 9;
}

.custom-checkbox label:before {
	width: 18px;
	height: 18px;
}

.custom-checkbox label:before {
	content: '';
	margin-right: 10px;
	display: inline-block;
	vertical-align: text-top;
	background: white;
	border: 1px solid #bbb;
	border-radius: 2px;
	box-sizing: border-box;
	z-index: 2;
}

.custom-checkbox input[type="checkbox"]:checked+label:after {
	content: '';
	position: absolute;
	left: 6px;
	top: 3px;
	width: 6px;
	height: 11px;
	border: solid #000;
	border-width: 0 3px 3px 0;
	transform: inherit;
	z-index: 3;
	transform: rotateZ(45deg);
}

.custom-checkbox input[type="checkbox"]:checked+label:before {
	border-color: #03A9F4;
	background: #03A9F4;
}

.custom-checkbox input[type="checkbox"]:checked+label:after {
	border-color: #fff;
}

.custom-checkbox input[type="checkbox"]:disabled+label:before {
	color: #b8b8b8;
	cursor: auto;
	box-shadow: none;
	background: #ddd;
}
/* Modal styles */
.modal .modal-dialog {
	max-width: 400px;
}

.modal .modal-header, .modal .modal-body, .modal .modal-footer {
	padding: 20px 30px;
}

.modal .modal-content {
	border-radius: 3px;
	font-size: 14px;
}

.modal .modal-footer {
	background: #ecf0f1;
	border-radius: 0 0 3px 3px;
}

.modal .modal-title {
	display: inline-block;
}

.modal .form-control {
	border-radius: 2px;
	box-shadow: none;
	border-color: #dddddd;
}

.modal textarea.form-control {
	resize: vertical;
}

.modal .btn {
	border-radius: 2px;
	min-width: 100px;
}

.modal form label {
	font-weight: normal;
}
</style>

<script>
	function setValueById(id, value) {
		document.getElementById(id).value = value;
	}

	function loadData(qname, a, b, c, d, ca) {
		document.getElementById("update_qname").value = qname;
		document.getElementById("update_a").value = a;
		document.getElementById("update_b").value = b;
		document.getElementById("update_c").value = c;
		document.getElementById("update_d").value = d;
		document.getElementById("update_ca").value = ca;
	}

	function update(id, value, qname, a, b, c, d, ca) {
		setValueById(id, value);
		loadData(qname, a, b, c, d, ca);
	}
</script>

</head>
<body>
	<jsp:include page="navbar.jsp" />
	<div class="container-xl">
		<div class="table-responsive">
			<div class="table-wrapper">
				<div class="table-title">
					<div class="row">
						<div class="col-sm-6">
							<h2>
								<b> <%=request.getParameter("name")%>
								</b>
							</h2>
						</div>
				<%@page import="java.sql.*"%>
				<%@page import="javax.servlet.*, javax.servlet.http.*"%>
				<%
				String quizid;
				quizid = request.getParameter("id");

				String username;
				Connection con;
				Statement stmt;
				ResultSet rs;

				HttpSession sess;
				sess = request.getSession();
				username = (String) sess.getAttribute("username");

				Class.forName("com.mysql.cj.jdbc.Driver");
				// con = DriverManager.getConnection("jdbc:mysql://bxdckaiotjos6uxqsxij-mysql.services.clever-cloud.com:3306/bxdckaiotjos6uxqsxij", "u1bl3chv4wysc2pd", "fFWLbfvEvE8CYje7Cv3o");
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/online-quiz", "root", "");
				stmt = con.createStatement();
				rs = stmt.executeQuery("SELECT * FROM questions WHERE quizid='" + quizid + "' ORDER BY timestamp, qno");
				%>
						<div class="col-sm-6">
							<a href="#uploadCSVModal" class="btn btn-success"
								data-toggle="modal"><i class="fa fa-file" aria-hidden="true"></i>
								<span> Upload Questions (CSV)</span></a> <a href="#addQuestionModal"
								class="btn btn-success" data-toggle="modal"><i
								class="material-icons">&#xE147;</i> <span> New Question</span></a> <a
								href='presentation.jsp?id=<%=request.getParameter("id")%>'
								class="btn btn-success <%=rs.isBeforeFirst()?"":"disabled" %>"><i class="fa fa-desktop"
								aria-hidden="true"></i> <span> Present</span></a>
						</div>
					</div>
				</div>
				<%
				if(rs.isBeforeFirst()) {
				%>
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th>Question</th>
							<th>Type</th>
						</tr>
					</thead>
					<tbody>
						<%
						while (rs.next()) {
							String qid = rs.getString("questionid");
							String question = rs.getString("question");
							String a = rs.getString("option1");
							String b = rs.getString("option2");
							String c = rs.getString("option3");
							String d = rs.getString("option4");
							String ca = rs.getString("correctanswer");
							String qType = rs.getString("type");
						%>
						<tr>
							<td><%=question%></td>
							<td><%=qType%></td>
							<td><a href="#editQuestionModal" class="edit"
								data-toggle="modal"><i class="material-icons"
									data-toggle="tooltip" title="Edit" id="<%=qid%>"
									onclick="update('update_qsid', '<%=qid%>', '<%=question%>', '<%=a%>', '<%=b%>', '<%=c%>', '<%=d%>', '<%=ca%>')">&#xE254;</i></a>
								<a href="#deleteQuestionModal" class="delete"
								data-toggle="modal"><i class="material-icons"
									data-toggle="tooltip" title="Delete" id="<%=qid%>"
									onclick="setValueById('delete_qsid', '<%=qid%>')">&#xE872;</i></a></td>
						</tr>
						<%
						}
						%>

					</tbody>
				</table>
				<%
				} else {
					%>
					<div class="jumboron" style="text-align: center;"><h2>You haven't added any questions yet!</h2></div>
					<%
				}
				%>
			</div>
		</div>
	</div>
	<!-- Add Modal HTML -->
	<div id="addQuestionModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="card custom-card">

					<form method="post" action="AddQuestion?id=<%=quizid%>">

						<div class="card-header">
							<h2 class="custom-heading">Add Question</h2>
						</div>

						<div class="card-body">

							<div class="form-group">
								<input type="text" name="q" class="form-control"
									placeholder="Enter Question" required />
							</div>
							<div class="form-group">
								<input type="text" name="a" class="form-control" placeholder="A"
									required />
							</div>
							<div class="form-group">
								<input type="text" name="b" class="form-control" placeholder="B"
									required />
							</div>
							<div class="form-group">
								<input type="text" name="c" class="form-control" placeholder="C" />
							</div>
							<div class="form-group">
								<input type="text" name="d" class="form-control" placeholder="D" />
							</div>
							<div class="form-group">
								<input type="number" min="1" max="4" name="ca"
									class="form-control" placeholder="Correct Answer" required />
							</div>

							<div class="form-group">
								<input type="submit" name="submit" value="Add"
									class="btn btn-success bb">
							</div>
						</div>
					</form>

				</div>
			</div>
		</div>
	</div>
	<!-- Edit Modal HTML -->
	<div id="editQuestionModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="card custom-card">

					<form method="post" action="UpdateQuestion">
						<input type="hidden" id="update_qsid" name="id">
						<div class="card-header">
							<h2 class="custom-heading">Edit Question</h2>
						</div>

						<div class="card-body">

							<div class="form-group">
								<input type="text" name="update_qname" id="update_qname"
									class="form-control" placeholder="Enter Question" required />
							</div>
							<div class="form-group">
								<input type="text" name="a" id="update_a" class="form-control"
									placeholder="A" required />
							</div>
							<div class="form-group">
								<input type="text" name="b" id="update_b" class="form-control"
									placeholder="B" required />
							</div>
							<div class="form-group">
								<input type="text" name="c" id="update_c" class="form-control"
									placeholder="C" />
							</div>
							<div class="form-group">
								<input type="text" name="d" id="update_d" class="form-control"
									placeholder="D" />
							</div>
							<div class="form-group">
								<input type="number" min="1" max="4" name="ca" id="update_ca"
									class="form-control" placeholder="Correct Answer" required />
							</div>

							<div class="form-group">
								<input type="submit" name="submit" value="Update"
									class="btn btn-success bb">
							</div>
						</div>
					</form>

				</div>
			</div>
		</div>
	</div>
	<!-- Delete Modal HTML -->
	<div id="deleteQuestionModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form method="POST" action="DeleteQuestion">
					<input type="hidden" id="delete_qsid" name="id">
					<div class="modal-header">
						<h4 class="modal-title">Delete Question</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">
						<p>Are you sure you want to delete these question?</p>
						<p class="text-warning">
							<small>This action cannot be undone.</small>
						</p>
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal"
							value="Cancel"> <input type="submit"
							class="btn btn-danger" value="Delete">
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Upload CSV Modal HTML -->
	<div id="uploadCSVModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="card custom-card">

					<form method="post" action="UploadQuestionsCSV"
						enctype="multipart/form-data" id="uploadCSVForm">

						<div class="card-header">
							<h2 class="custom-heading">Upload Questions as CSV</h2>
						</div>

						<div class="card-body">
							<input type="hidden" value="<%=quizid%>" name="quizid">

							<div class="form-group">
								<input type="file" name="questionsFile" class="form-control"
									required />
							</div>

							<div class="form-group">
								<input type="submit" id="uploadSubmit" name="uploadSubmit" value="Upload"
									class="btn btn-success bb">
							</div>

							<div class="progress" id="pbar" style="display: none;">
								<div id="progressBar" class="progress-bar" role="progressbar"
									style="width: 0%;" aria-valuenow="25"
									aria-valuemin="0" aria-valuemax="100">Uploading...</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
		document.getElementById("uploadCSVForm").addEventListener("submit", (e) => {
			e.preventDefault();
			document.getElementById("pbar").style.display="block";
			document.getElementById("uploadSubmit").disabled=true;
			var i = 0;
			var interval = setInterval(() => { 
				if(i>100) {
					clearInterval(interval);
					document.getElementById("uploadSubmit").disabled = false;
					document.getElementById("pbar").style.display="none";
				}
				i+=5;
				document.getElementById("progressBar").style.width = i+"%";
			}, 100);
			setTimeout(() => document.getElementById("uploadCSVForm").submit(), 3000)
		}, true);
	</script>
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