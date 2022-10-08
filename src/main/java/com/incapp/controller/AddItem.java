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
@WebServlet("/AddItem")
@MultipartConfig
public class AddItem extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String name=request.getParameter("name");
			String cname=request.getParameter("cname");
			double price=Double.parseDouble(request.getParameter("price"));
			String salt=request.getParameter("salt");
			int qty=Integer.parseInt(request.getParameter("qty"));
			Part p=request.getPart("image");
			InputStream image=p.getInputStream();
			
			HashMap<String,Object> item=new HashMap();
			item.put("name", name);
			item.put("cname", cname);
			item.put("price", price);
			item.put("salt", salt);
			item.put("qty", qty);
			item.put("image", image);
			
			DAO db=new DAO();
			String result=db.addItem(item);
			db.closeDBConnection();
			
			HttpSession session=request.getSession();
			session.setAttribute("msg", result);
			response.sendRedirect("AdminHome.jsp");
			
		}catch (Exception e) {
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
