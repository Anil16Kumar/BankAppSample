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
     
         
		<h2>you are in admin login page :-)</h2>
		
		<form method="post" action="AdminChecker" >
		Enter user name: <input type="text" name="uname"><br>
		Enter password: <input type="password" name="pass"><br>
		<input type="submit" value="login">
		</form>
</body>
</html>