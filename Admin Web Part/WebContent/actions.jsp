<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Actions</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type ="text/css" href="css/bootstrap.css"/>
<link rel="stylesheet" type ="text/css" href="css/admin.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
<script src="js/bootstrap.js"></script>
</head>
<body class="bg">
<c:if test ="${success == true}">
<script type="text/javascript">
function PopUp(){
	   alert("User Registered Sucucessfully");
	}
	PopUp();
	<% HttpSession sessio = request.getSession();
	   sessio.removeAttribute("success");
	%>
        </script>
</c:if>
<nav class="navbar navbar-light bg-light">
<ul class="nav justify-content-end">
  <li class="nav-item liitem" style="font-size:20px">
   <button type="submit" class="btn btn-primary" onclick="location.href='actions.jsp';">Home</button>
  </li>
  <li class="nav-item liitem" style="font-size:20px">
   <form method="post" action="AdminAction">
     <button type="submit" class="btn btn-primary" name ="submit" value="logout">Log Out</button>
       </form>
  </li>
</ul>
<div class ="test">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><button type="submit" class="btn btn-primary" onclick="location.href='register.jsp';">Register Patient</button></li>
  </ol>
</nav>

<form method="post" action="AdminAction">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><button type="submit" class="btn btn-primary" name ="submit" value="list">Patients List</button></li>
  </ol>
</nav>
</form>
<form method="post" action="AdminAction">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><button type="submit" class="btn btn-primary" name ="submit" value="response">Patient Survey Responses</button></li>
  </ol>
</nav>
</form>
</div>
</nav>
</body>
</html>