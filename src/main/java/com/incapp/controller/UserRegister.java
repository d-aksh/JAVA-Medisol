package com.incapp.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.incapp.dao.DAO;

/**
 * Servlet implementation class AdminLogin
 */
@WebServlet("/UserRegister")
@MultipartConfig
public class UserRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String name=request.getParameter("name");
			String email=request.getParameter("email");
			String phone=request.getParameter("phone");
			String password=request.getParameter("password");
			
			DAO db=new DAO();
			String result=db.registerUser(email,name,phone,password);
			db.closeDBConnection();
			HttpSession session=request.getSession();
			if(result.contains("success")) {
				session.setAttribute("uemail", email);
				response.sendRedirect("UserHome.jsp");
			}else {
				session.setAttribute("msg", result);
				response.sendRedirect("UserLogin.jsp");
			}
		}catch (Exception e) {
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
