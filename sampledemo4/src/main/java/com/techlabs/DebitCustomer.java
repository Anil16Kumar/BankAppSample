package com.techlabs;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DebitCustomer
 */
@WebServlet("/DebitCustomer")
public class DebitCustomer extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNum = request.getParameter("bacc");
        String amount = request.getParameter("amt");
        RequestDispatcher dispatcher = null;

        // Database code 
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/basedemo4", "root", "Anil16@db");

            // Check if the account has sufficient balance
            PreparedStatement selectStmt = con.prepareStatement("SELECT balance FROM customerTable2 WHERE accountNumber = ?");
            selectStmt.setString(1, accountNum);
            ResultSet resultSet = selectStmt.executeQuery();

            if (resultSet.next()) {
                int currentBalance = resultSet.getInt("balance");

                if (currentBalance >= Integer.parseInt(amount)) {
                    // Perform the debit
                    PreparedStatement updateStmt = con.prepareStatement(
                            "UPDATE customerTable2 SET balance = balance - ? WHERE accountNumber = ? AND balance >= ?");
                    updateStmt.setInt(1, Integer.parseInt(amount));
                    updateStmt.setString(2, accountNum);
                    updateStmt.setInt(3, Integer.parseInt(amount));
                    int rowCount = updateStmt.executeUpdate();

                    if (rowCount > 0) {
                        response.sendRedirect("done.jsp");
                        request.setAttribute("status", "success");

                        // Record debit transaction in the Transaction table
                        PreparedStatement debitStmt = con.prepareStatement(
                                "INSERT INTO Transaction1 (senderAccountNumber, receiverAccountNumber, transactionType, amount, transactionDate) VALUES (?, ?, ?, ?, ?)");
                        debitStmt.setString(1, accountNum);
                        debitStmt.setString(2, accountNum); // Same source and destination account for debit
                        debitStmt.setString(3, "debit");
                        debitStmt.setInt(4, Integer.parseInt(amount));
                        debitStmt.setDate(5, new java.sql.Date(System.currentTimeMillis()));
                        debitStmt.executeUpdate();
                        response.sendRedirect("done.jsp");
                        request.setAttribute("status", "success");
                    } else {
                        response.sendRedirect("wrong.jsp");
                        request.setAttribute("status", "failed");
                    }
                } else {
                    response.sendRedirect("insufficient_balance.jsp");
                    request.setAttribute("status", "failed");
                }
            } else {
                response.sendRedirect("invalid_account.jsp");
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