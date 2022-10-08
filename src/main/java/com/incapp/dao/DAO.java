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
}
