<%@page import="com.db.Bugs"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% 

	String id = request.getParameter("id").toString();
	String desc = request.getParameter("bug_desc").toString();
	String status = request.getParameter("status").toString();
	System.out.println("Bug Id" + id);
	System.out.println("Bug desc" + desc);
	System.out.println("Bug Status" + status);
	
	Bugs b1 = new Bugs();
	int result = b1.updateStatus(id, desc, status);
	out.append(Integer.toString((result)));
	out.append("Success");
	

%>