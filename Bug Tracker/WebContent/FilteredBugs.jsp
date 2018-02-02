<%@page import="java.util.ArrayList"%>
<%@page import="com.db.Bugs"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String val = request.getParameter("bug");
	System.out.println("Value:   " + val);
	
	if(val.equalsIgnoreCase("INVALID")) {
		out.append("<p> AAAAA </p>");
	}else {
		out.append("<p> BBBB </p>");
	}
	
	Bugs b1 = new Bugs();
	b1.initialize_db();
	ArrayList<Bugs> bugs =  b1.getBugs(val, "TYPE");
	
	for(Bugs b: bugs) {
		out.append(b.getBug_id());
		out.append(b.getBug_desc());
		out.append(b.getBug_type());
	}
	
%>