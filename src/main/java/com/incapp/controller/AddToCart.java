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
@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String name=request.getParameter("name");
			String itemSearchName=request.getParameter("itemSearchName");
			
			HttpSession session=request.getSession();
			String uemail=(String)session.getAttribute("uemail");
			if(uemail==null) {
				session.setAttribute("msg", "Please Login first!");
				response.sendRedirect("UserLogin.jsp");
			}else {
				DAO db=new DAO();
				HashMap item=db.getItemByName(name);
				int qty=(int)item.get("qty");
				if(qty>0) {
					String result=db.addToCart(uemail,name);
					session.setAttribute("msg", result);
				}else {
					session.setAttribute("msg", "Item No more available!");
				}
				db.closeDBConnection();
				response.sendRedirect("SearchItems.jsp?name="+itemSearchName);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
