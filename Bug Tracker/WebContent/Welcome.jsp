<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome to RPA bug tracker</title>
</head>
<body>

	<%
		String username = null;
		String last_name = null;
		Cookie co[] = request.getCookies();
		if(co.length > 1) {

			for (Cookie co_temp : co) {
				
					if(co_temp.getName().equalsIgnoreCase("user_f_name"))
						username = co_temp.getValue();
					else if(co_temp.getName().equalsIgnoreCase("user_l_name"))
						last_name = co_temp.getValue();
				}
			}
		else {
				System.out.println("Inside expired");	
				response.sendRedirect("SessionExpired.html");
			}
	%>
	<div>
		<p>
			Welcome
			<%=username + " " + last_name + ","%></p>
		<a href="Logout.jsp">Logout</a>
	</div>
	<div>
		<table>
			<tr>
				<td><font size="5px">Bugs assigned to you:</font></td>
			</tr>
		</table>
	</div>

</body>

<script type="text/javascript">

function HandleBackFunctionality() {
	
	if(window.event) {
		if(window.clientX < 40 && window.clientY < 0) {
			alert("back button was clicked")
		}else {
			alert("refresh button was clicked")
		}
		
	}else {
		
		if(event.currentTarget.performance.navigation.type == 1) {
			alert("refresh button was clicked")
		}else if(event.currentTarget.performance.navigation.type == 2){
			alert("back button was clicked")
		}
	}
	
}
</script>

</html>