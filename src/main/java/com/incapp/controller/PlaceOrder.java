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
@WebServlet("/PlaceOrder")
public class PlaceOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String address=request.getParameter("address");
			String itemSearchName=request.getParameter("itemSearchName");
			
			HttpSession session=request.getSession();
			String email=(String)session.getAttribute("uemail");
			if(email==null) {
				session.setAttribute("msg", "Please Login first!");
				response.sendRedirect("UserLogin.jsp");
			}else {
				DAO db=new DAO();
				HashMap<Integer,String> items=db.getCartItemsByEmail(email);
				Set set=items.keySet();
				Iterator iterator=set.iterator();
				double total=0;
				String ordersItems="";
				boolean flag=false;
				while(iterator.hasNext()){
					int id=(int)iterator.next();
					String item_name=(String)items.get(id);
					HashMap item=db.getItemByName(item_name);
					int qty=(int)item.get("qty");
					if(qty<=0) {
						flag=true;
						break;
					}
					double price=(double)item.get("price");
					total += price;
					ordersItems += item_name+":"+price+",";
				}
				if(flag) {
					session.setAttribute("msg", "Item Out of Stock");
					response.sendRedirect("Cart.jsp");
				}else {
					Set s=items.keySet();
					Iterator i=set.iterator();
					while(i.hasNext()){
						int id=(int)i.next();
						String item_name=(String)items.get(id);
						db.itemQtyIncDesc(item_name,1);
					}
					String result=db.placeOrder(email,address,total,ordersItems);
					session.setAttribute("msg", result);
					db.closeDBConnection();
					response.sendRedirect("UserHome.jsp");
				}
				
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
