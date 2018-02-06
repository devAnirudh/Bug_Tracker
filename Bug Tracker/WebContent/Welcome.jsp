<%@page import="com.db.Bugs"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Welcome to RPA bug tracker</title>
<style type="text/css">
#assigned {
	 margin-bottom: 50px;
	 margin-top: 50px
}
</style>
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
			response.sendRedirect("SessionExpired.html");
		}

		ArrayList<String> bug_list = new ArrayList<String>();
		Bugs b = new Bugs();
		b.initialize_db();
		bug_list = b.getDistinctBugs();
	%>
	
		<p>
			Welcome
			<%=username + " " + last_name + ","%></p>
			
	<div class = "dropdown">
	
	<button class = "btn btn-primary dropdown-toggle" type = "button" data-toggle = "dropdown">More<span = class = "caret"> </span></button>
	 <ul class="dropdown-menu">
      <li><a href="#">About</a></li>
      <li><a href="#">Help</a></li>
      <li><a href="Logout.jsp">Logout</a></li>
    </ul>
	</div>
	<div id = "assigned">
		<table>
			<tr>
				<td><font size="5px">Bugs assigned to you</font></td>
			</tr>
			<tr >
				<td>Select type of bug:</td>
				<td><select id="bug_list" onchange="sendSelected()">
						<%
							for (String bug_type : bug_list) {
						%>
						<option>
							<%=bug_type%>
						</option>
						<%
							}
						%>
				</select></td>
			</tr>
		</table>
	</div>

	<div id = "div1">

		<table  id="bug_table" class = "table">
			<tr>
				<th>Bug Id</th>
				<th>Bug Description</th>
				<th>Bug Type</th>
				<th>Status</th>
				<th> </th>
			</tr>
			<%
				if (session.getAttribute("employee_id") != null) {
					String emp_id = session.getAttribute("employee_id").toString();
					ArrayList<Bugs> bugs = b.getBugs(emp_id);
					for (int i = 0; i < bugs.size(); i++) {
			%>
			<tr>
				<td><%=bugs.get(i).getBug_id()%></td>
				<td><%=bugs.get(i).getBug_desc()%></td>
				<td><%=bugs.get(i).getBug_type()%></td>
				<td><%=bugs.get(i).getStatus()%></td>
				<td data-toggle = "modal" data-target = "#myModal"><a onclick="updateDesc()">Update</a></td>
			</tr>
			<%
				}
			}
			%>
		</table>
	</div>
	
	<div class = "container">
		<h2>Bug Resolution</h2>
		<button type = "button" class = "btn btn-info btn-lg" data-toggle = "modal" data-target = "#myModal">Test </button>
		<div class = "modal fade" id = "myModal" role = "dialog">
			<div class = "modal-dialog">
			 	<div class="modal-content">
					<div class = "modal-header">
						 <button type="button" class="close" data-dismiss="modal">&times;</button>
						 <h4 class = "modal-title">Enter description</h4>
					</div>
					<div class = "modal-body">
					 	  <p>Description</p>
				          <input id = "desc" type = "text" >
				           <p>Status</p>
				          <select id = "status">
				          <option>Select</option>
				          <option>Unresolved</option>
				          <option>Resolved</option>
				          <option>WIP</option>
				          </select>
					</div>
					<div class = "modal-footer">
						 <button type="button" onclick = "getDescription();" class="btn btn-default" data-dismiss="modal" >Submit</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div style = "width: 50%; margin: auto;">
	<button class = "btn-success">Update</button>
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

	function sendSelected() {
		var d = document.getElementById("bug_list");
		var bug_table = document.getElementById("bug_table");
		var selectedBug = d.options[d.selectedIndex].value;
		var url = "FilteredBugs.jsp?bug=" + selectedBug;
		 
		request = new XMLHttpRequest();
		request.open("GET", url, true);
		request.send();

		request.onreadystatechange = function getInfo() {
			if (request.readyState == 4) {
			    
				for(i = 1; i < bug_table.rows.length; i++) {
			    	
			    	for(j = 0; j < bug_table.rows[i].cells.length; j++) {
			    		bug_table.rows[i].cells[j].innerHTML = "";
			        }
			    }
				var obj = JSON.parse(this.responseText);
				
				
				for(i = 0; i < obj.length; i++) {
					if(obj[i].status == "Unresolved") {
						bug_table.rows[i+1].className = "danger";
					}else {
						bug_table.rows[i+1].className = "success";
					}
					bug_table.rows[i+1].cells[0].innerHTML = obj[i].id;
					bug_table.rows[i+1].cells[1].innerHTML = obj[i].desc;
					bug_table.rows[i+1].cells[2].innerHTML = obj[i].type;
					bug_table.rows[i+1].cells[3].innerHTML = obj[i].status;
					
				}
			}
		}
	}
	
	function getDescription() {
		var desc = document.getElementById("desc");
		var option_status = document.getElementById("status");
		
		
		
		desc.value = "";
		option_status.value = "Select";
		
		
		
	}
</script>

</html>