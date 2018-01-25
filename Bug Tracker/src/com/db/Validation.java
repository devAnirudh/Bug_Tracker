package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Validation {

	public static String validate(String username, String password) {
		String employeeName = null;
		try {
			String query = "SELECT * FROM DEVELOPER_DETAILS WHERE EMP_ID = ? AND PASSWORD = ?";
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aniruddha_db?autoReconnect=true&useSSL=false", "root","root");
			PreparedStatement usersmt = con.prepareStatement(query);
			usersmt.setString(1, username);
			usersmt.setString(2, password);
			
			ResultSet rs = usersmt.executeQuery();
			
			if(rs.next()) {
				employeeName = rs.getString("emp_f_name") + " "+ rs.getString("emp_l_name");
			}else {
				employeeName = "";
			}
			
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return employeeName;
	}

}
