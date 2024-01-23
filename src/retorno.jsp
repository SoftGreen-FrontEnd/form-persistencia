<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%@ page session="true" %>
<%
if (request.getParameter("term")!=null)
{
	if (request.getParameter("term").equals("1"))
	{
		out.print("{\"label\": \"Campo\", \"value\": \"10\", \"field\": \"total\", \"status\": \"true\"}");
	}
	else if (request.getParameter("term").equals("2")) 
	{
		out.print("{\"label\": \"Campo\", \"value\": \"20\", \"field\": \"total\", \"status\": \"true\"}");
	}
	else
	{
		out.print("[{\"label\": \"NAO ENCONTRADO\", \"status\": \"false\"}]");
	}
}
%>