<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logged out successfully</title>
</head>
<body>
	<%
		Cookie c = new Cookie("user_f_name",""); 
		c.setMaxAge(0);
		response.addCookie(c);
		c = new Cookie("user_l_name",""); 
		c.setMaxAge(0);
		response.addCookie(c);
	%>

	<p>You are successfully logged out. You will be redirected to login within 10 seconds.
		page</p>

	<%
		response.setHeader("Refresh", "10; URL=Login.html");
	%>
</body>
</html>