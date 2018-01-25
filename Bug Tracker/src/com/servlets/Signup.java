package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Signup
 */
@WebServlet("/Signup")
public class Signup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Signup() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		RequestDispatcher reqDis = request.getRequestDispatcher("Login.html");
		HttpSession session = request.getSession();
		session.setAttribute("sample", "test");
		String emp_id = request.getParameter("emp_id");
		String mob = request.getParameter("mobile");
		String mail = request.getParameter("email_id");
		String password = request.getParameter("pword_signup");
		String f_name = request.getParameter("emp_f_name");
		String l_name = request.getParameter("emp_l_name");
		
		System.out.println("Employee ID: " + emp_id);
		System.out.println("Mail: " + mail);
		System.out.println("Password: " + password);
		System.out.println("mobile: " + mob);
		System.out.println("First name: " + f_name);
		System.out.println("Last name: " + l_name);

		try {
			String insertQuery = "INSERT INTO DEVELOPER_DETAILS (EMP_ID, EMP_F_NAME, EMP_L_NAME, MOBILE, MAIL, PASSWORD) VALUES (?,?,?,?,?,?)";
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aniruddha_db?autoReconnect=true&useSSL=false", "root","root");
			PreparedStatement stmt = con.prepareStatement(insertQuery);
			stmt.setString(1, emp_id);
			stmt.setString(2, f_name);
			stmt.setString(3, l_name);
			stmt.setString(4, mob);
			stmt.setString(5, mail);
			stmt.setString(6, password);
			stmt.executeUpdate();
			
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		out.print("Signup successful..! Kindly login with your credentials.");
		
		reqDis.include(request, response);
		
	}

}
