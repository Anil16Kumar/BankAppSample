package com.techlabs;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CreditCustomer
 */
@WebServlet("/CreditCustomer")
public class CreditCustomer extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNum = request.getParameter("bacc");
        String amount = request.getParameter("amt");
        RequestDispatcher dispatcher = null;

        // Database code
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/basedemo4", "root", "Anil16@db");
            PreparedStatement stmt = con.prepareStatement("UPDATE customerTable2 SET balance = balance + ? WHERE accountNumber = ?");
            stmt.setString(1, amount);
            stmt.setString(2, accountNum);
            int rowCount = stmt.executeUpdate();

            if (rowCount > 0) {
                
                // Record credit transaction in the Transaction table
                PreparedStatement creditStmt = con.prepareStatement(
                        "INSERT INTO Transaction1 (senderAccountNumber, receiverAccountNumber, transactionType, amount, transactionDate) VALUES (?, ?, ?, ?, ?)");
                creditStmt.setString(1, accountNum);
                creditStmt.setString(2, accountNum); // Same source and destination account for credit
                creditStmt.setString(3, "credit");
                creditStmt.setInt(4, Integer.parseInt(amount));
                creditStmt.setDate(5, new java.sql.Date(System.currentTimeMillis()));
                creditStmt.executeUpdate();
                
                response.sendRedirect("done.jsp");
                request.setAttribute("status", "success");
            } else {
                response.sendRedirect("wrong.jsp");
                request.setAttribute("status", "failed");
            }
            dispatcher = request.getRequestDispatcher("welcome.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}