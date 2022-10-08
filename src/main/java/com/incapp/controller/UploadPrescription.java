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
@WebServlet("/UploadPrescription")
@MultipartConfig
public class UploadPrescription extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Part p=request.getPart("image");
			InputStream image=p.getInputStream();
			
			HttpSession session=request.getSession();
			String email=(String)session.getAttribute("uemail");
			if(email==null) {
				session.setAttribute("msg", "Please Login first!");
				response.sendRedirect("UserLogin.jsp");
			}else {
				DAO db=new DAO();
				String result=db.uploadPrescription(email,image);
				session.setAttribute("msg", result);
				db.closeDBConnection();
				response.sendRedirect("UserHome.jsp");
				
			}
		}catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
