<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>


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
if (session.getAttribute("username") == null) {
    response.sendRedirect("customerLogin.jsp");
} else {
    String username = session.getAttribute("username").toString();
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String newPassword = request.getParameter("password");
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
         
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/basedemo4";
        String user = "root";
        String password = "Anil16@db";
        conn = DriverManager.getConnection(url, user, password);

        
        String updateCustomerQuery = "UPDATE customerTable2 SET firstName = ?, lastName = ?, passsword = ? WHERE emailID = ?";
        stmt = conn.prepareStatement(updateCustomerQuery);
        stmt.setString(1, firstName);
        stmt.setString(2, lastName);
        stmt.setString(3, newPassword);
        stmt.setString(4, username);
        int customerUpdateCount = stmt.executeUpdate();

      
        String updateTransactionQuery = "UPDATE Transaction1 SET transactionType = ?  WHERE senderAccountNumber IN (SELECT accountNumber FROM customerTable2 WHERE emailID = ?)";
        stmt = conn.prepareStatement(updateTransactionQuery);
        stmt.setString(1, "credit");        
        stmt.setString(2, username);
        int transactionUpdateCount = stmt.executeUpdate();

       
        out.println("Customer details updated successfully!");
       %> 
       <br><br>
       <a href="customerHome.jsp"> customer home </a>
       <%

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
      
        try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }
}
%>



</body>
</html>