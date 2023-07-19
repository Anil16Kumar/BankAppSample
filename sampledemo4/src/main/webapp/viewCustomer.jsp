<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>


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
		
		<h3>you are in view customer page</h3>
		<sql:setDataSource driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3306/basedemo4" user="root" password="Anil16@db" var="ds"></sql:setDataSource>
		<sql:query dataSource="${ds}" var="rs">select * from customerTable2</sql:query>
		
	 
		 <table>
			<tr>
				<td>First Name</td>
				<td>Last Name</td>
				<td>Account Number</td>
				<td>Balance</td>
			</tr>
			 <c:forEach items="${rs.rows}" var="row">
			  <tr>
			  		<td><c:out value="${row.firstName}"></c:out></td><!-- ${row.customerID+100} chal raha hai -->
			  		<td><c:out value="${row.lastName}"></c:out></td>
			  		<td><c:out value="${row.accountNumber}"></c:out></td>
			  		<td><c:out value="${row.balance}"></c:out></td>
			  </tr>
			 </c:forEach>
		</table>
		
		<form action="Logout">
			<input type="submit" value="logout"> 
		</form>
</body>
</html>