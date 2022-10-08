package com.incapp.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

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
@WebServlet("/ChangePrescriptionStatus")
public class ChangePrescriptionStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String status=request.getParameter("status");
			int id=Integer.parseInt(request.getParameter("id"));
			DAO db=new DAO();
			String result=db.changePrescriptionStatus(status, id);
			HttpSession session=request.getSession();
			session.setAttribute("msg", result);
			db.closeDBConnection();
			response.sendRedirect("Prescriptions.jsp");
		}catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
