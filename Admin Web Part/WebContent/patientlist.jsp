<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient List</title>
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
<h3 class="heading">Patients List</h3>
<table class="table table-bordered patient">
  <thead>
    <tr>
      <th scope="col">Name</th>
      <th scope="col">Email</th>
      <th scope="col">Address</th>
      <th scope="col">Password</th>
      <th scope="col">See Responses</th>
    </tr>
  </thead>
</table>
<script>

/* 'ajax':{

'url':'',
'dataSrc':''
},

'columns': [

{'data':'First Name'},
{'data':'Last Name'}
//{'data':'Email'}
],

//'order':[[3,desc]],
'dom':'Bfrtip',
'buttons':['copy','csv','excel','pdf','print'] */

$(document).ready(function() {
    $('.patient').DataTable( {
    	ajax: {
    		"url":"http://localhost:4000/userslist",
    		 headers:{'Authorization':"${sessionScope.token}"},	
    	},
    	columns:[  {
            "data" : "name"
        }, {
            "data" : "username"
        }, {
            "data" : "address"
        }, {
            "data" : "passw"
        },{
            "data" : "age"
        }
        ],
        "fnRowCallback": function( nRow, aData, iDisplayIndex ) {
            $('td:eq(4)', nRow).html(' <form method="post" action="AdminAction">' + '<button type="submit" class="btn btn-primary" name ="submit" value="getuserresponse">' +
                'See Responses' + '</button>' + '<input type="hidden" name="myField" id="myField" value="" />' + '</form>');
            return nRow;
        },	
        dom: 'Bfrtip',
        buttons: [
            'print'
        ]
    });
    
    var table = $('.patient').DataTable();
    $('.patient tr').on('click', 'tr', function () {
        var data = table.row(this).data();
        document.getElementById('myField').value = data.username;
        alert(document.getElementById('myField'));
    });
    
});
</script>
</nav>
</body>
</html>