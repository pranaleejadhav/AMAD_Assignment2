<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Responses</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type ="text/css" href="css/bootstrap.css"/>
<link rel="stylesheet" type ="text/css" href="css/admin.css"/>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
<link rel="stylesheet" type ="text/css" href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css"/>
<script src="js/jquery-3.3.1.js"></script>
<script src="js/bootstrap.js"></script>
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
<script type='text/javascript' src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.4.1/js/buttons.flash.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.4.1/js/buttons.html5.min.js"></script>
<script type='text/javascript' src="https://cdn.datatables.net/buttons/1.2.4/js/buttons.print.min.js"></script>
<meta charset="UTF-8">
</head>
<body class="testtable">
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
<h3 class="heading">Patient Responses</h3>
<table class="table table-bordered patient">
  <thead>
    <tr>
      <th scope="col">Username</th>
      <th scope="col">Question 1</th>
      <th scope="col">Question 2</th>
      <th scope="col">Question 3</th>
      <th scope="col">Question 4</th>
      <th scope="col">Question 5</th>
      <th scope="col">Question 6</th>
      <th scope="col">Question 7</th>
      <th scope="col">Question 8</th>
      <th scope="col">Question 9</th>
      <th scope="col">Question 10</th>
    </tr>
  </thead>
</table>
<script>


//'buttons':['copy','csv','excel','pdf','print'] */\

$(document).ready(function() {
	
    $('.patient').DataTable( {
    	ajax: {
    		"type":"POST",
    		"url":"http://localhost:4000/userresponses" + "?username=" + "battala",
    		 headers:{'Authorization':"${sessionScope.token}"},	
    		 data:{
    			 'username':'nbattala'
    		 }
    		 },
    	columns:[
    		{
            "data" : "username"
        },{
            "data" : "Q1"
        }, {
            "data" : "Q2"
        }, {
            "data" : "Q3"
        }, {
            "data" : "Q4"
        },{
            "data" : "Q5"
        },{
            "data" : "Q6"
        },{
            "data" : "Q7"
        },{
            "data" : "Q8"
        },{
            "data" : "Q9"
        },{
            "data" : "Q10"
        }
        ],
        dom: 'Bfrtip',
        buttons: [
            'print'
        ]
    });
});
</script>
</nav>
</body>
</html>