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
			response.sendRedirect("adminLogin.jsp");
		}
	    %>
	    
		hello!! ${username}
		<h2>you are in ADMIN HOME PAGE!!!!</h2>
		
		<h3>New Customer</h3>
		<a href="customerSignup.jsp"> ADD customer </a> 
		<br><br>
		<br><br>
		<h3>View Customers</h3>
		<a href="viewCustomer.jsp"> view </a> 
		<br><br>
		<br><br>
		<h3>View Transactions</h3> 
		<a href="viewAllTransection.jsp"> view </a> 
		<br><br>
		<br><br>
		
		<form action="Logout">
			<input type="submit" value="logout"> 
		</form>
		
		
</body>
</html>