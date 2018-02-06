<%@page import="java.util.ArrayList"%>
<%@page import="com.db.Bugs"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String type = request.getParameter("bug");
	String user_id = session.getAttribute("employee_id").toString();
	System.out.println(user_id);
	Bugs b1 = new Bugs();
	b1.initialize_db();
	ArrayList<Bugs> bugs = b1.getBugs(type, user_id);
	boolean isFirst = true;
	
	if (bugs.size() > 0) {
		out.append("[");
		for (Bugs b : bugs) {
			if(!isFirst) {
				out.append(",{");
			}else {
				out.append("{");
				isFirst = false;
			}
			
			out.append("\"id\":" + b.getBug_id() + ", ");
			out.append("\"desc\":\"" + b.getBug_desc() + "\", ");
			out.append("\"type\":\"" + b.getBug_type() + "\", ");
			out.append("\"status\":\"" + b.getStatus()+ "\"");
			out.append("}");
		}
		
		out.append("]");
	} else {
		out.append("NO DATA");
	}
%>