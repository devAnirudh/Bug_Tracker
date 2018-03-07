package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.db.Validation;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Login() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		if(request.getCookies() !=  null) {
			if(request.getCookies().length > 1) {
				response.sendRedirect("Welcome.jsp");
			}else {

				response.setContentType("text/html");
				doGet(request, response);

				PrintWriter out = response.getWriter();
				Validation val = new Validation();
				String uname = request.getParameter("uname").trim();
				String pword = request.getParameter("pword").trim();
				Cookie co_f_name, co_l_name = null;


				if(uname.trim().equalsIgnoreCase("") || pword.trim().equalsIgnoreCase("")) {

					out.println("Username or Password can't be blank..!!");
					RequestDispatcher dis = request.getRequestDispatcher("Login.jsp");
					dis.include(request, response);

				}else if(!val.validate(uname, pword).equalsIgnoreCase("")) {
					/**
					 * Session Tracking using Session
					 */
					HttpSession session = request.getSession();
					session.setAttribute("employee_id", val.getEmployee_id());

					/**
					 * Session Tracking using Cookies
					 * */

					String username = val.getEmployee_name();
					String name[] = username.split(" ");
					co_f_name = new Cookie("user_f_name", name[0]);
					co_f_name.setMaxAge(1800);
					session.setMaxInactiveInterval(1800);

					if(name.length > 1 ) {
						co_l_name = new Cookie("user_l_name",name[1]);
						co_l_name.setMaxAge(1800);
					}

					if(co_f_name != null) {
						response.addCookie(co_f_name);
					}
					if(co_l_name != null) {
						response.addCookie(co_l_name);
					}

					response.sendRedirect("Welcome.jsp");

				} else {
					out.println("<p id = \"message\">Username or Password incorrect..!!</p>");
					RequestDispatcher dis = request.getRequestDispatcher("Login.jsp");
					dis.include(request, response);

				}
			}
		}

	}

	public boolean checkCreds(boolean flag) {
		return flag;
	}

}
