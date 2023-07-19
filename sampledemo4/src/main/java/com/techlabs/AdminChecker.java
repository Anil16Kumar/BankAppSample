package com.techlabs;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

  
@WebServlet("/AdminChecker")
public class AdminChecker extends HttpServlet {
	 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uname=request.getParameter("uname");
		 String pass=request.getParameter("pass");
		PrintWriter out = response.getWriter();
	
//		out.println(uname);
//		out.println(pass);
		
		// HttpSession session=request.getSession();
		// RequestDispatcher dispatcher=null;
		 try {
			  
			 Class.forName("com.mysql.cj.jdbc.Driver");
			 Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/basedemo4", "root", "Anil16@db");
			 PreparedStatement pst = con.prepareStatement("SELECT * FROM adminTable WHERE userName=? AND passsword=?");
			 pst.setString(1, uname);
			 pst.setString(2, pass);
		     ResultSet rs= pst.executeQuery();
		     //---------
		     HttpSession session=request.getSession();
				session.setAttribute("username", uname);
				//---------------
		     if(rs.next())
		     {
		    	 PrintWriter out1 = response.getWriter();
		    	 out1.println("you are authorized person");
		 		out1.println(uname);
		 		out1.println(pass);
		 		response.sendRedirect("adminHome.jsp");
		 		
		 	//	response.sendRedirect("welcome.jsp");
//		    	 session.setAttribute("name", rs.getString("uname"));
//		    	 dispatcher=request.getRequestDispatcher("welcome.jsp");
		     }
		     else
		     {
		 		PrintWriter out3 = response.getWriter();
		 		out3.println("you are not autorized, you need to register youself!!");
		 		response.sendRedirect("adminSignup.jsp");
		     }
		     
		    // dispatcher.forward(request, response);
		 } catch (Exception e) {
			// TODO: handle exception
			 e.printStackTrace();
		}
	}

}
