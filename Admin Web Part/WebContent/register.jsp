<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type ="text/css" href="css/bootstrap.css"/>
<link rel="stylesheet" type ="text/css" href="css/admin.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
<script src="js/bootstrap.js"></script>
<style>
body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box}

/* Full-width input fields */
input[type=text], input[type=password], input[type=Email] {
    width: 100%;
    padding: 15px;
    margin: 5px 0 22px 0;
    display: inline-block;
    border: none;
    background: #f1f1f1;
}

input[type=text]:focus, input[type=password]:focus {
    background-color: #ddd;
    outline: none;
}

hr {
    border: 1px solid #f1f1f1;
    margin-bottom: 25px;
}

/* Set a style for all buttons */
button {
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    cursor: pointer;
    width: 100%;
    opacity: 0.9;
}

button:hover {
    opacity:1;
}

/* Extra styles for the cancel button */
.cancelbtn {
    padding: 14px 20px;
    background-color: #f44336;
}

/* Float cancel and signup buttons and add an equal width */
.cancelbtn, .signupbtn {
  float: left;
  width: 50%;
}

/* Add padding to container elements */
.container {
    padding: 16px;
}

/* Clear floats */
.clearfix::after {
    content: "";
    clear: both;
    display: table;
}

/* Change styles for cancel button and signup button on extra small screens */
@media screen and (max-width: 300px) {
    .cancelbtn, .signupbtn {
       width: 100%;
    }
}
</style>
</head>
<body>
<div class="container">
<nav class="navbar navbar-light bg-light">
 <ul class="nav justify-content-end">
  <li class="nav-item liitem" style="font-size:20px">
   <button type="submit" class="btn btn-primary" onclick="location.href='actions.jsp';">Home</button>
  </li>
  <li class="nav-item liitem" style="font-size:20px">
   <form method="Post" action="AdminAction">
     <button type="submit" class="btn btn-primary" name ="submit" value="logout">Log Out</button>
     </form>
  </li>
</ul>
 <form method="Post" action="AdminAction">
    <hr>
    <label for="fname"><b>First Name</b></label>
    <input type="text" placeholder="Enter First Name" name="fname" required>
    <label for="lname"><b>Last Name</b></label>
    <input type="text" placeholder="Enter Last Name" name="lname" required>
    <label for="email"><b>Email</b></label>
    <input type="Email" placeholder="Enter Email" name="email" required>
     <label for="address"><b>Address</b></label>
    <input type="text" placeholder="Enter Address" name="address" required>
    <label for="psw"><b>Password</b></label>
    <input type="password" placeholder="Enter Password" name="psw" required>

    <label for="psw-repeat"><b>Repeat Password</b></label>
    <input type="password" placeholder="Repeat Password" name="psw-repeat" required>
    <button type="submit" class="signupbtn" name="submit" value="signup">Register</button>
    </form>
    <div class="clearfix">
    <form action="actions.jsp">
      <button type="submit" class="cancelbtn" name="submit">Cancel</button>
     </form>
    </div>
    </nav>
    </div>
</body>
</html>

