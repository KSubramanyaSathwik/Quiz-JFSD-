<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<jsp:include page="header.jsp" />
<% String quizid = request.getParameter("id"); 
String username = (String) session.getAttribute("username");
%>
<title>Rate us</title>
<style>
.slidecontainer {
	width: 100%;
}

.slider {
  border: solid #0db3dd 1px;
  -webkit-appearance: none;
  width: 100%;
  height: 25px;
  background: #d3d3d3;
  border-radius: 33px;
  outline: none;
  opacity: 0.7;
  -webkit-transition: .2s;
  transition: opacity .2s;
}

.slider:hover {
  opacity: 1;
}

.slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  appearance: none;
  width: 25px;
  height: 25px;
  background: #007bff;
  border-radius: 10rem;
  cursor: pointer;
}

.slider::-moz-range-thumb {
  width: 25px;
  height: 25px;
  background: #007bff;
  border-radius: 10rem;
  cursor: pointer;
}
</style>
</head>
<body>
<div class="row mt-5">
	<div class="col col-lg-12">
		<h1 style="text-align:center;">Rate us</h1>
	</div>
</div>
<form method="post" action="SubmitFeedback">
	<div class="row mt-5">
		<div class="col col-lg-4"></div>
		<div class="col col-lg-4">
			<div class="slidecontainer">
				<input type="hidden" name="quizid" value="<%= quizid %>"/>
				<input type="hidden" name="username" value="<%= username %>"/>
		  		<input type="range" name="rating" min="1" max="5" value="1" class="slider" id="myRange">
		  		<p style="text-align:center;"><span id="demo" style="font-size: 50px;"></span></p>
			</div>
		</div>
		<div class="col col-lg-4"></div>
	</div>
	<div class="row mt-5">
	  <div class="col col-lg-4"></div>
	    <div class="col col-lg-4 text-center">	
			<input type="submit" name="submit" class="btn btn-primary btn-lg" value="Submit" />
		</div>
		<div class="col col-lg-4"></div>
	</div>
</form>
<script>
var slider = document.getElementById("myRange");
var output = document.getElementById("demo");
output.innerHTML = slider.value;

slider.oninput = function() {
  output.innerHTML = this.value;
  var value = (this.value-this.min)/(this.max-this.min)*100
  this.style.background = 'linear-gradient(to right, #82CFD0 0%, #82CFD0 ' + value + '%, #fff ' + value + '%, white 100%)'
}
</script>

<jsp:include page="footer.jsp" />
</html>