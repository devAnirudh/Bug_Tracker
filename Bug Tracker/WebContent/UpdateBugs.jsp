<%@page import="com.db.Bugs"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% 

	String id = request.getParameter("id").toString();
	String desc = request.getParameter("bug_desc").toString();
	String status = request.getParameter("status").toString();
	String bug_type = request.getParameter("bug_type").toString();
	
	Bugs b1 = new Bugs();
	int result = b1.updateStatus(id, desc, status);
	out.append(Integer.toString((result)));
	out.append("Success");
	
	response.sendRedirect("FilteredBugs.jsp?bug=" + bug_type);

%>