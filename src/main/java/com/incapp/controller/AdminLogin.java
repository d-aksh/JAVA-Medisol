package com.incapp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.incapp.dao.DAO;

/**
 * Servlet implementation class AdminLogin
 */
@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String id=request.getParameter("id");
			String password=request.getParameter("password");
			DAO db=new DAO();
			String name=db.checkAdminLogin(id, password);
			db.closeDBConnection();
			HttpSession session=request.getSession();
			if(name!=null) {
				session.setAttribute("adminname", name);
				response.sendRedirect("AdminHome.jsp");
			}else {
				session.setAttribute("msg", "Invalid ID or Password!");
				response.sendRedirect("index.jsp");
			}
		}catch (Exception e) {
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
