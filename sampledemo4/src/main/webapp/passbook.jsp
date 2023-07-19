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
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
         
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/basedemo4";
        String user = "root";
        String password = "Anil16@db";
        conn = DriverManager.getConnection(url, user, password);

        
        String accountNumberQuery = "SELECT accountNumber FROM customerTable2 WHERE emailID = ?";
        stmt = conn.prepareStatement(accountNumberQuery);
        stmt.setString(1, username);
        rs = stmt.executeQuery();
        if (rs.next()) {
            int accountNumber = rs.getInt("accountNumber");

            
            String transactionQuery = "SELECT * FROM Transaction1 WHERE senderAccountNumber = ? OR receiverAccountNumber = ?";
            stmt = conn.prepareStatement(transactionQuery);
            stmt.setInt(1, accountNumber);
            stmt.setInt(2, accountNumber);
            rs = stmt.executeQuery();

            %>
            Hello, <%= username %><br><br>
            <h3>View Transactions for Account Number: <%= accountNumber %></h3>
            <table>
                <tr>
                    <th>Sender Account Number</th>
                    <th>Receiver Account Number</th>
                    <th>Transaction Type</th>
                    <th>Amount</th>
                    <th>Transaction Date</th>
                </tr>
                <% while (rs.next()) { %>
                <tr>
                    <td><%= rs.getInt("senderAccountNumber") %></td>
                    <td><%= rs.getInt("receiverAccountNumber") %></td>
                    <td><%= rs.getString("transactionType") %></td>
                    <td><%= rs.getInt("amount") %></td>
                    <td><%= rs.getDate("transactionDate") %></td>
                </tr>
                <% } %>
            </table>
            <% 
        } else {
             
            out.println("Account number not found for the username: " + username);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        
        try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }
}
%>

<form action="Logout">
    <input type="submit" value="Logout"> 
</form>

</body>
</html>