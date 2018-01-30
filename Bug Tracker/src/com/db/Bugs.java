package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Bugs {

	private Connection con;

	public static void main(String[] args) {

		ArrayList<String> temp = new ArrayList<>();
		Bugs b = new Bugs();
		if(b.initialize_db()) {
			temp = b.getDistinctBugs();
		}
		for(String temp_str: temp) {
			System.out.println(temp_str);
		}
	}

	public boolean initialize_db() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aniruddha_db?autoReconnect=true&useSSL=false", "root","root");
			return true;
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	public ArrayList<String> getDistinctBugs() {
		String getBugType = "SELECT DISTINCT(BUG_TYPE) FROM ANIRUDDHA_DB.BUGS";
		ArrayList<String> bugList = new ArrayList<String>();
		if(con!= null) {
			try {

				PreparedStatement smt = con.prepareStatement(getBugType);
				ResultSet rs = smt.executeQuery();

				while(rs.next()) {
					bugList.add(rs.getString(1));
				}
				return bugList;

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return null;
			}
		}else {
			System.out.println("Problem in connection");
			return null;
		}
	}

	public Connection getCon() {
		return con;
	}
	public void setCon(Connection con) {
		this.con = con;
	}



}
