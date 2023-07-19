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
<style><%@include file="/style.css"%></style>
</head>
<body>	
     
         
		<%
if (session.getAttribute("username") == null) {
    response.sendRedirect("customerLogin.jsp");
} else {
    String username = session.getAttribute("username").toString();
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
         
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/basedemo4";
        String user = "root";
        String password = "Anil16@db";
        conn = DriverManager.getConnection(url, user, password);

        
        String customerQuery = "SELECT * FROM customerTable2 WHERE emailID = ?";
        stmt = conn.prepareStatement(customerQuery);
        stmt.setString(1, username);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            String firstName = rs.getString("firstName");
            String lastName = rs.getString("lastName");

            
            %>
            <h3>Edit Customer Details</h3>
            <form action="updateCustomer.jsp" method="POST">
                <label for="firstName">First Name:</label>
                <input type="text" name="firstName" value="<%= firstName %>" required><br>

                <label for="lastName">Last Name:</label>
                <input type="text" name="lastName" value="<%= lastName %>" required><br>

                <label for="password">New Password:</label>
                <input type="password" name="password"  required><br>

                <input type="submit" value="Save Changes">
            </form>
            <% 
        } else {
            
            out.println("Customer not found for the username: " + username);
        }
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