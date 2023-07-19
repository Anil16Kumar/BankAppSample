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
 
@WebServlet("/TransferAmount")
public class TransferAmount extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sourceAccount = request.getParameter("sourceAccount");
        String destinationAccount = request.getParameter("destinationAccount");
        String amount = request.getParameter("amount");
        RequestDispatcher dispatcher = null;

        // Database code
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/basedemo4", "root", "Anil16@db");

  
            PreparedStatement selectStmt = con.prepareStatement("SELECT balance FROM customerTable2 WHERE accountNumber = ?");
            selectStmt.setString(1, sourceAccount);
            ResultSet resultSet = selectStmt.executeQuery();

            if (resultSet.next()) {
                int sourceBalance = resultSet.getInt("balance");

                if (sourceBalance >= Integer.parseInt(amount)) {
                    
                    PreparedStatement updateStmt = con.prepareStatement(
                            "UPDATE customerTable2 SET balance = balance - ? WHERE accountNumber = ?");
                    updateStmt.setInt(1, Integer.parseInt(amount));
                    updateStmt.setString(2, sourceAccount);
                    int sourceUpdateCount = updateStmt.executeUpdate();

                    updateStmt = con.prepareStatement(
                            "UPDATE customerTable2 SET balance = balance + ? WHERE accountNumber = ?");
                    updateStmt.setInt(1, Integer.parseInt(amount));
                    updateStmt.setString(2, destinationAccount);
                    int destinationUpdateCount = updateStmt.executeUpdate();

                    if (sourceUpdateCount > 0 && destinationUpdateCount > 0) {
                        // Transfer successful
                        

                        // Record credit transaction in the Transaction table
                        PreparedStatement creditStmt = con.prepareStatement(
                                "INSERT INTO Transaction1 (senderAccountNumber, receiverAccountNumber, transactionType, amount, transactionDate) VALUES (?, ?, ?, ?, ?)");
                        creditStmt.setString(1, sourceAccount);
                        creditStmt.setString(2, destinationAccount);
                        creditStmt.setString(3, "credit");
                        creditStmt.setInt(4, Integer.parseInt(amount));
                        creditStmt.setDate(5, new java.sql.Date(System.currentTimeMillis()));
                        creditStmt.executeUpdate();

                         
                        PreparedStatement debitStmt = con.prepareStatement(
                                "INSERT INTO Transaction1 (senderAccountNumber, receiverAccountNumber, transactionType, amount, transactionDate) VALUES (?, ?, ?, ?, ?)");
                        debitStmt.setString(1, sourceAccount);
                        debitStmt.setString(2, destinationAccount);
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