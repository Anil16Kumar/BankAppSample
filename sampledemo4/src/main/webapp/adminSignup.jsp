<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style><%@include file="/style.css"%></style>
</head>
<body>	
     
         <h2>some thing went wrong:- </h2>
		
		<h3>if you think you entered wrong ID password, then try again</h3>
		<a href="adminLogin.jsp"> admin Login button </a> 
		
		<h3>or, maybe you are not an admin member then signup yourself here:-)</h3>
		<form method="post" action="AdminAdd" >
		 Enter user name: <input type="text" name="uname"><br>
		 Enter password: <input type="password" name="pass"><br>
		<input type="submit" value="SignUp">
	
		</form>
</body>
</html>