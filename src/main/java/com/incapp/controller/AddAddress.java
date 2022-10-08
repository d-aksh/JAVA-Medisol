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
@WebServlet("/AddAddress")
@MultipartConfig
public class AddAddress extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session=request.getSession();
			String email=(String)session.getAttribute("uemail");
			String address=request.getParameter("address");
			DAO db=new DAO();
			String result=db.addAddress(email,address);
			db.closeDBConnection();
			
			session.setAttribute("msg", result);
			response.sendRedirect("UserAddress.jsp");
			
		}catch (Exception e) {
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
