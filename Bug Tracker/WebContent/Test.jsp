<!DOCTYPE html>
<%
String update_query = "UPDATE ANIRUDDHA_DB.BUGS " +
		"SET STATUS = ?, " +
		"RESOLUTION = ?, " +
		"WHERE idbugs = ?";
System.out.println(update_query);
%>