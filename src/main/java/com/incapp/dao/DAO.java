package com.incapp.dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.HashMap;

public class DAO {
	private Connection c;
	public DAO() throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
		c=DriverManager.getConnection("jdbc:mysql://localhost:3306/medisolweb", "root","incapp");
	}
	public void closeDBConnection() throws Exception {
		c.close();
	}
	public String checkAdminLogin(String id,String password) throws Exception {
		PreparedStatement p=c.prepareStatement("select * from adminlogin where id=? and password=?");
		p.setString(1, id);
		p.setString(2, password);
		ResultSet rs=p.executeQuery();
		if(rs.next()) {
			return rs.getString("name");
		}else {
			return null;
		}
	}
	public String checkUserLogin(String email,String password) throws Exception {
		PreparedStatement p=c.prepareStatement("select * from users where email=? and password=? and status='Active'");
		p.setString(1, email);
		p.setString(2, password);
		ResultSet rs=p.executeQuery();
		if(rs.next()) {
			return "success";
		}else {
			return "failed";
		}
	}
	public String addToCart(String uemail,String name) throws Exception {
		PreparedStatement p=c.prepareStatement("insert into cart (email,item_name) values(?,?)");
		p.setString(1, uemail);
		p.setString(2, name);
		p.executeUpdate();
		return "Item Added success";
	}
	public String addAddress(String email,String address) throws Exception {
		PreparedStatement p=c.prepareStatement("insert into address (email,address) values(?,?)");
		p.setString(1, email);
		p.setString(2, address);
		p.executeUpdate();
		return "Address Added success";
	}

	public String placeOrder(String email,String address,double total,String orderItems) throws Exception {
		PreparedStatement p=c.prepareStatement("insert into orders (email,address,amount,items,status,odate) values(?,?,?,?,'Placed',CURRENT_DATE)");
		p.setString(1, email);
		p.setString(2, address);
		p.setDouble(3, total);
		p.setString(4, orderItems);
		p.executeUpdate();
		p=c.prepareStatement("delete from cart where email=?");
		p.setString(1, email);
		p.executeUpdate();
		return "Order placed success";
	}
	public String changeOrderStatus(int id,String status) throws Exception {
		PreparedStatement p=c.prepareStatement("update orders set status=? where id=?");
		p.setString(1, status);
		p.setInt(2, id);
		p.executeUpdate();
		return "Order Status Updation success";
	}
	public String changeUserStatus(String status,String email) throws Exception {
		PreparedStatement p=c.prepareStatement("update users set status=? where email=?");
		p.setString(1, status);
		p.setString(2, email);
		p.executeUpdate();
		return "User Status Updation success";
	}
	public String changePrescriptionStatus(String status,int id) throws Exception {
		PreparedStatement p=c.prepareStatement("update prescriptions set status=? where id=?");
		p.setString(1, status);
		p.setInt(2, id);
		p.executeUpdate();
		return "Prescription Status Updation success";
	}
	public String addItem(HashMap<String,Object> item) throws Exception {
		PreparedStatement p=c.prepareStatement("insert into items (name,cname,salt,price,qty,image) values(?,?,?,?,?,?)");
		p.setString(1, (String)item.get("name"));
		p.setString(2, (String)item.get("cname"));
		p.setString(3, (String)item.get("salt"));
		p.setDouble(4, (double)item.get("price"));
		p.setInt(5, (int)item.get("qty"));
		p.setBinaryStream(6, (InputStream)item.get("image"));
		try {
			p.executeUpdate();
			return "Item Insertion success";
		}catch (SQLIntegrityConstraintViolationException e) {
			return "Item Already exist";
		}
	}
	public String uploadPrescription(String email,InputStream image) throws Exception {
		PreparedStatement p=c.prepareStatement("insert into prescriptions (email,image,status) values(?,?,'Pending')");
		p.setString(1, email);
		p.setBinaryStream(2, image);
		p.executeUpdate();
		return "Prescription Uploaded success";
	}
	public String registerUser(String email,String name,String phone,String password) throws Exception {
		PreparedStatement p=c.prepareStatement("insert into users (email,name,phone,password,status) values(?,?,?,?,'Active')");
		p.setString(1, email);
		p.setString(2, name);
		p.setString(3, phone);
		p.setString(4, password);
		try {
			p.executeUpdate();
			return "User Registration success";
		}catch (SQLIntegrityConstraintViolationException e) {
			return "User Already exist";
		}
	}
	public String changeItemImage(String name, InputStream image) throws Exception {
		PreparedStatement p=c.prepareStatement("update items set image=? where name=?");
		p.setBinaryStream(1, image);
		p.setString(2, name);
		int r=p.executeUpdate();
		if(r!=0)
			return "Item Image Updation success";
		else 
			return "Item Image Updation failed";
	}
	public String updateItemQty(String name, int qty) throws Exception {
		PreparedStatement p=c.prepareStatement("update items set qty=? where name=?");
		p.setInt(1, qty);
		p.setString(2, name);
		int r=p.executeUpdate();
		if(r!=0)
			return "Item Quantity Updation success";
		else 
			return "Item Quantity Updation failed";
	}

	public void itemQtyIncDesc(String name, int a) throws Exception {
		PreparedStatement p=c.prepareStatement("update items set qty=qty-? where name=?");
		p.setInt(1, a);
		p.setString(2, name);
		p.executeUpdate();
	}
	public int getCartQty(String email) throws Exception {
		PreparedStatement p=c.prepareStatement("select * from cart where email=?");
		p.setString(1, email);
		ResultSet rs=p.executeQuery();
		int qty=0;
		while(rs.next()) {
			qty++;
		}
		return qty;
	}

	public ArrayList<String> getAddress(String email) throws Exception {
		PreparedStatement p=c.prepareStatement("select * from address where email=?");
		p.setString(1, email);
		ResultSet rs=p.executeQuery();
		ArrayList<String> addresses=new ArrayList<>();
		while(rs.next()) {
			addresses.add(rs.getString("address"));
		}
		return addresses;
	}
	public String updateItemDetails(String name,String newname,String cname,String salt,double price) throws Exception {
		PreparedStatement p=c.prepareStatement("update items set name=?,cname=?,salt=?,price=? where name=?");
		p.setString(1, newname);
		p.setString(2, cname);
		p.setString(3, salt);
		p.setDouble(4, price);
		p.setString(5, name);
		int r=p.executeUpdate();
		if(r!=0)
			return "Item Details Updation success";
		else 
			return "Item Details Updation failed";
	}
	public ArrayList<HashMap> getAllItems() throws Exception {
		ArrayList<HashMap> items=new ArrayList<>();
		PreparedStatement p=c.prepareStatement("select * from items");
		ResultSet rs=p.executeQuery();
		while(rs.next()) {
			HashMap item=new HashMap();
			item.put("name", rs.getString("name"));
			item.put("cname", rs.getString("cname"));
			item.put("qty", rs.getInt("qty"));
			item.put("price", rs.getDouble("price"));
			item.put("salt", rs.getString("salt"));
			items.add(item);
		}
		return items;
	}
	public String getPlacedOrdersById(int id) throws Exception {
		PreparedStatement p=c.prepareStatement("select items from orders where id=?");
		p.setInt(1, id);
		ResultSet rs=p.executeQuery();
		if(rs.next()) {
			return rs.getString("items");
		}else {
			return null;
		}
		
	}
	public ArrayList<HashMap> getPlacedOrdersByEmail(String email) throws Exception {
		ArrayList<HashMap> orders=new ArrayList<>();
		PreparedStatement p=c.prepareStatement("select * from orders where email=? and status='Placed' or status='Confirmed' order by id desc");
		p.setString(1, email);
		ResultSet rs=p.executeQuery();
		while(rs.next()) {
			HashMap order=new HashMap();
			order.put("id", rs.getInt("id"));
			order.put("address", rs.getString("address"));
			order.put("amount", rs.getDouble("amount"));
			order.put("items", rs.getString("items"));
			order.put("odate", rs.getString("odate"));
			order.put("status", rs.getString("status"));
			orders.add(order);
		}
		return orders;
	}
	public ArrayList<HashMap> getOrdersByEmail(String email) throws Exception {
		ArrayList<HashMap> orders=new ArrayList<>();
		PreparedStatement p=c.prepareStatement("select * from orders where email=? order by id desc");
		p.setString(1, email);
		ResultSet rs=p.executeQuery();
		while(rs.next()) {
			HashMap order=new HashMap();
			order.put("id", rs.getInt("id"));
			order.put("address", rs.getString("address"));
			order.put("amount", rs.getDouble("amount"));
			order.put("items", rs.getString("items"));
			order.put("odate", rs.getString("odate"));
			order.put("status", rs.getString("status"));
			orders.add(order);
		}
		return orders;
	}
	public ArrayList<HashMap> getOrders() throws Exception {
		ArrayList<HashMap> orders=new ArrayList<>();
		PreparedStatement p=c.prepareStatement("select * from orders order by id desc");
		ResultSet rs=p.executeQuery();
		while(rs.next()) {
			HashMap order=new HashMap();
			order.put("id", rs.getInt("id"));
			order.put("address", rs.getString("address"));
			order.put("amount", rs.getDouble("amount"));
			order.put("items", rs.getString("items"));
			order.put("odate", rs.getString("odate"));
			order.put("status", rs.getString("status"));
			orders.add(order);
		}
		return orders;
	}
	public ArrayList<HashMap> getPrescriptions() throws Exception {
		ArrayList<HashMap> prescriptions=new ArrayList<>();
		PreparedStatement p=c.prepareStatement("select * from prescriptions order by id desc");
		ResultSet rs=p.executeQuery();
		while(rs.next()) {
			HashMap prescription=new HashMap();
			prescription.put("id", rs.getInt("id"));
			prescription.put("email", rs.getString("email"));
			prescription.put("status", rs.getString("status"));
			prescriptions.add(prescription);
		}
		return prescriptions;
	}
	public ArrayList<HashMap> getUsers() throws Exception {
		ArrayList<HashMap> users=new ArrayList<>();
		PreparedStatement p=c.prepareStatement("select * from users order by name asc");
		ResultSet rs=p.executeQuery();
		while(rs.next()) {
			HashMap user=new HashMap();
			user.put("name", rs.getString("name"));
			user.put("phone", rs.getString("phone"));
			user.put("email", rs.getString("email"));
			user.put("status", rs.getString("status"));
			users.add(user);
		}
		return users;
	}
	public void removeFromCart(int id) throws Exception {
		PreparedStatement p=c.prepareStatement("delete from cart where id=?");
		p.setInt(1,id);
		p.executeUpdate();
	}
	public HashMap<Integer,String> getCartItemsByEmail(String email) throws Exception {
		HashMap<Integer,String> items=new HashMap<>();
		PreparedStatement p=c.prepareStatement("select * from cart where email=?");
		p.setString(1, email);
		ResultSet rs=p.executeQuery();
		while(rs.next()) {
			items.put(rs.getInt("id"),rs.getString("item_name"));
		}
		return items;
	}
	public ArrayList<HashMap> getItemsLike(String name) throws Exception {
		ArrayList<HashMap> items=new ArrayList<>();
		PreparedStatement p=c.prepareStatement("select * from items where name like ?");
		p.setString(1, "%"+name+"%");
		ResultSet rs=p.executeQuery();
		while(rs.next()) {
			HashMap item=new HashMap();
			item.put("name", rs.getString("name"));
			item.put("cname", rs.getString("cname"));
			item.put("qty", rs.getInt("qty"));
			item.put("price", rs.getDouble("price"));
			item.put("salt", rs.getString("salt"));
			items.add(item);
		}
		return items;
	}
	public HashMap getItemByName(String name) throws Exception {
		PreparedStatement p=c.prepareStatement("select * from items where name=?");
		p.setString(1, name);
		ResultSet rs=p.executeQuery();
		if(rs.next()) {
			HashMap item=new HashMap();
			item.put("name", rs.getString("name"));
			item.put("cname", rs.getString("cname"));
			item.put("qty", rs.getInt("qty"));
			item.put("price", rs.getDouble("price"));
			item.put("salt", rs.getString("salt"));
			return item;
		}else {
			return null;
		}
	}
	public HashMap getUserByEmail(String email) throws Exception {
		PreparedStatement p=c.prepareStatement("select * from users where email=?");
		p.setString(1, email);
		ResultSet rs=p.executeQuery();
		if(rs.next()) {
			HashMap user=new HashMap();
			user.put("name", rs.getString("name"));
			user.put("phone", rs.getString("phone"));
			user.put("email", rs.getString("email"));
			user.put("status", rs.getString("status"));
			return user;
		}else {
			return null;
		}
	}
	public byte[] getImage(String name) throws SQLException {
		PreparedStatement p=c.prepareStatement("select image from items where name=?");
		p.setString(1, name);
		ResultSet rs=p.executeQuery();
		if(rs.next()) {
			byte image[]=rs.getBytes("image");
			return image;
		}else {
			return null;
		}
		
	}
	public byte[] GetPrescriptionImage(int id) throws SQLException {
		PreparedStatement p=c.prepareStatement("select image from prescriptions where id=?");
		p.setInt(1, id);
		ResultSet rs=p.executeQuery();
		if(rs.next()) {
			byte image[]=rs.getBytes("image");
			return image;
		}else {
			return null;
		}
		
	}
}
