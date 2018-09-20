# AMAD_Assignment2
To create a survey tool 
  
  
Below is the description of all the API's with example. 

API DESCRIPTION FOR APP
Description: API logs the admin to the system
Admin Login:
admin
Method: post()
Body:
{"username":"narahari93"
"password":"12345"
}
JWT not needed. 

This API adds the user to the database and is carried out by the admin
URL: /adminadd
Method: post()
Body:
{
    "username": "kartik90",
     "name":"kartik",
     "age":"27",
     "weight":"80",
     "address": "Charlotte",
     "password":"987555"
}
JWT needed:
Header:
Key: Authorization
Value: Bearer jwt Token

This API logs the user to the system.
JWT not needed for login purpose
Login by user:
URL: /login
Method: post()
Body:
{"username":"kartik90"
"password":"000111"
}

This API is used to update the user
JWT is needed for updating user details:
URL: /users
Method: put()
Body:
{ "name":"kartik",
     "age":"27",
     "weight":"80",
     "address": "Charlotte",
     "password":"987555",
"weight":"100"
	 }
Header:
Key: Authorization
Value: Bearer jwt Token




This API stores the user answers in database.
URL: /userresponse
Method: post()
Body:
{
"q1":"Question1",
"q1value":"Answer1",
"q2":"Question2",
"q2value":"Answer2",
"q3":"Question3",
"q3value":"Answer3",
"q4":"Question4",
"q4value":"Answer4",
"q5":"Question5",
"q5value":"Answer5",
"q6":"Question6",
"q6value":"Answer6",
"q7":"Question7",
"q7value":"Answer7",
"q8":"Question8",
"q8value":"Answer8",
"q9":"Question9",
"q9value":"Answer9",
"q10":"Question10",
"q10value":"Answer10",
"total":"35"
}
JWT needed:
Header:
Key: Authorization
Value: Bearer jwt Token


This API gets the answers entered by user
URL: /userresponses
Method: post()
Body{
"username":"kartik90"
}
JWT needed:
Header:
Key: Authorization
Value: Bearer jwt Token


This API gets all the responses stored by the user.
URL: /responses
Method: get()
JWT needed:
Header:
Key: Authorization
Value: Bearer jwt Token
