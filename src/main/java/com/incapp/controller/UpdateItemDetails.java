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
@WebServlet("/UpdateItemDetails")
public class UpdateItemDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String name=request.getParameter("name");
			String newname=request.getParameter("newname");
			String cname=request.getParameter("cname");
			String salt=request.getParameter("salt");
			double price=Double.parseDouble(request.getParameter("price"));
			
			DAO db=new DAO();
			String result=db.updateItemDetails(name,newname,cname,salt,price);
			db.closeDBConnection();
			
			HttpSession session=request.getSession();
			session.setAttribute("msg", result);
			response.sendRedirect("EditItem.jsp?name="+newname);
			
		}catch (Exception e) {
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
