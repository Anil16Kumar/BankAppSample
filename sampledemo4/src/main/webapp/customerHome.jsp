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
     
         
<%
		if(session.getAttribute("username")==null )
		{
			response.sendRedirect("customerLogin.jsp");
		}
	%>
		hello!! ${username}
		
		<h2>customer HOME PAGE !!</h2>
		
		<h3>Passbook</h3>
		<a href="passbook.jsp"> Go To </a> passbook  
		
		<br><br><br>
		
		<h3>New Transaction </h3>
		<a href="newTransactionCustomer.jsp"> Go To </a> new transaction 
		<br><br><br>
		
		<h3>Edit Profile</h3>
		<a href="edit.jsp"> Go To </a> edit page 
		<br><br><br>
		
		<form action="Logout">
			<input type="submit" value="logout"> 
		</form>
</body>
</html>