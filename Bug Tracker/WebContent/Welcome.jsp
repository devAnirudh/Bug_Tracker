<%@page import="com.db.Bugs"%>
<%@page import="java.util.ArrayList"%>
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
		if (co.length > 1) {

			for (Cookie co_temp : co) {

				if (co_temp.getName().equalsIgnoreCase("user_f_name"))
					username = co_temp.getValue();
				else if (co_temp.getName().equalsIgnoreCase("user_l_name"))
					last_name = co_temp.getValue();
			}
		} else {
			System.out.println("Inside expired");
			response.sendRedirect("SessionExpired.html");
		}

		ArrayList<String> bug_list = new ArrayList<String>();
		Bugs b = new Bugs();
		b.initialize_db();
		bug_list = b.getDistinctBugs();
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
			<tr>
				<td>Select type of bug:</td>
				<td><select>
						<%
							for (String bug_type : bug_list) {
						%>
						<option value=<%=bug_type%>>
							<%=bug_type%>
						</option>
						<%
							}
						%>
				</select></td>
			</tr>
		</table>
	</div>

	<div>
		<table>
			<tr>
				<th>Bug Id</th>
				<th>Bug Description</th>
				<th>Bug Type</th>
			</tr>
			<%
				String emp_id = request.getSession().getAttribute("employee_id").toString();
				ArrayList<Bugs> bugs = b.getBugs(emp_id);
				for(int i = 0; i < bugs.size(); i++) {
				%>
			<tr>
				<td><%= bugs.get(i).getBug_id()%></td>
				<td><%= bugs.get(i).getBug_desc()%></td>
				<td><%= bugs.get(i).getBug_type()%></td>
			</tr>
			<%
				}
			
			%>
		</table>
	</div>

</body>

<script type="text/javascript">
	function HandleBackFunctionality() {

		if (window.event) {
			if (window.clientX < 40 && window.clientY < 0) {
				alert("back button was clicked")
			} else {
				alert("refresh button was clicked")
			}

		} else {

			if (event.currentTarget.performance.navigation.type == 1) {
				alert("refresh button was clicked")
			} else if (event.currentTarget.performance.navigation.type == 2) {
				alert("back button was clicked")
			}
		}

	}
</script>

</html>