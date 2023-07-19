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
 * Servlet implementation class CustomerAdd
 */
@WebServlet("/CustomerAdd")
public class CustomerAdd extends HttpServlet {
	 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fname=request.getParameter("fname");
		String lname=request.getParameter("lname");
		String email=request.getParameter("uname");
		String bacc=request.getParameter("accnum");
		String bala=request.getParameter("bala");
		String pass=request.getParameter("pass");
		RequestDispatcher dispatcher=null;
		
		//database code 
        Connection con=null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			 con=DriverManager.getConnection("jdbc:mysql://localhost:3306/basedemo4", "root", "Anil16@db");
			PreparedStatement pst=con.prepareStatement("insert into customerTable2(firstName,lastName,emailID,accountNumber,balance,passsword) values(?,?,?,?,?,?)");
			pst.setString(1, fname);
			pst.setString(2, lname);
			pst.setString(3, email);
			pst.setString(4, bacc);
			pst.setString(5, bala);
			pst.setString(6, pass);
			int rowCount=pst.executeUpdate();
			HttpSession session=request.getSession();
			session.setAttribute("username", email);
			response.sendRedirect("menuAC.jsp");
			
//			dispatcher=request.getRequestDispatcher("welcome.jsp");
			if(rowCount>0)
			{
				 request.setAttribute("status", "success");
				 
			}
			else
			{
				 request.setAttribute("status", "failed");
			}
			dispatcher.forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
	}

}
