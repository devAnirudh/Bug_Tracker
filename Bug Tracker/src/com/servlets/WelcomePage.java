package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class WelcomePage extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		resp.setContentType("text/html");
		PrintWriter out = resp.getWriter();
		/**HttpSession session = req.getSession(false);
		session.setMaxInactiveInterval(60);*/
		Cookie co[] = req.getCookies();
		
		String username = (String) URLDecoder.decode(co[0].getValue(), "UTF-8");
		String last_name = (String) URLDecoder.decode(co[1].getValue(),"UTF-8");
		//out.print("Welcome " + username +" "+last_name + co[0].getDomain());
	}
	

}
