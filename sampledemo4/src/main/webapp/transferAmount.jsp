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
		<form method="post" action="TransferAmount" >
		Enter Source Bank Account Number: <input type="number" name="sourceAccount"><br>
		Enter Destination Bank Account Number: <input type="number" name="destinationAccount"><br>
		Enter Amount: <input type="number" name="amount"><br>
		<input type="submit" value="SUBMIT">
	
		</form>
</body>
</html>