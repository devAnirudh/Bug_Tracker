package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Bugs {

	private Connection con;
	private String bug_type;
	private String bug_desc;
	private String bug_id;
	private String status;
	private ArrayList<Bugs> bugs = new ArrayList<Bugs>();

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

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return bug_id + bug_type + bug_desc ;
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

	public ArrayList<Bugs> getBugs(String user_id) {
		String getBugs = "";
		getBugs = "SELECT * FROM ANIRUDDHA_DB.BUGS WHERE EMP_ID = ?";
		if(con != null) {
			try {
				PreparedStatement smt = con.prepareStatement(getBugs);
				smt.setString(1, user_id);
				ResultSet rs = smt.executeQuery();

				while(rs.next()) {
					Bugs b = new Bugs();
					b.bug_id = rs.getString(1);
					b.bug_desc = rs.getString(2);
					b.bug_type = rs.getString(3);
					b.status = rs.getString(5);
					bugs.add(b);
				}
				return bugs;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return null;
			}
		}
		return null;
	}

	public ArrayList<Bugs> getBugs(String type, String user_id) {
		
		initialize_db();
		String getBugs = "SELECT * FROM ANIRUDDHA_DB.BUGS WHERE EMP_ID = ? AND BUG_TYPE = ?";
		
		if(con != null) {
			try {
				PreparedStatement smt = con.prepareStatement(getBugs);
				smt.setString(1, user_id);
				smt.setString(2, type);
				
				ResultSet rs = smt.executeQuery();

				while(rs.next()) {
					Bugs b = new Bugs();
					b.bug_id = rs.getString(1);
					b.bug_desc = rs.getString(2);
					b.bug_type = rs.getString(3);
					b.status = rs.getString(5);
					bugs.add(b);
				}
				return bugs;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return null;
			}
		}
		return null;
	}




	public Connection getCon() {
		return con;
	}
	public void setCon(Connection con) {
		this.con = con;
	}
	public ArrayList<Bugs> getBugs() {
		return bugs;
	}
	public void setBugs(ArrayList<Bugs> bugs) {
		this.bugs = bugs;
	}

	public String getBug_type() {
		return bug_type;
	}

	public void setBug_type(String bug_type) {
		this.bug_type = bug_type;
	}

	public String getBug_desc() {
		return bug_desc;
	}

	public void setBug_desc(String bug_desc) {
		this.bug_desc = bug_desc;
	}

	public String getBug_id() {
		return bug_id;
	}

	public void setBug_id(String bug_id) {
		this.bug_id = bug_id;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	


}
