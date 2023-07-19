<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
		if(session.getAttribute("username")==null )
		{
			response.sendRedirect("customerLogin.jsp");
		}
	%>
		hello!! ${username}
		
	<h2> Type of transaction you want:-</h2>
	<h3>Credit</h3>
	<a href="credit.jsp"> GoTo </a> credit page now !!
	<br><br><br> 
	
	<h3>Debit</h3>
	<a href="debit.jsp"> GoTo </a> debit page now !!
	<br><br><br>
	
	<h3>Transfer</h3>
	<a href="transferAmount.jsp"> GoTo </a> transfer Amount page now !!
	<br><br><br>
	
	<form action="Logout">
			<input type="submit" value="logout"> 
		</form>
</body>
</html>