<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.net.URLDecoder" %>
<%
String name = "";
Cookie[] cookies = request.getCookies();
if (cookies != null) {
    for (Cookie cookie : cookies) {
        if (cookie.getName().equals("name")) {
        	// try {
            	name = URLDecoder.decode(cookie.getValue(), "UTF-8");
        	//} catch (Exception e) { 
        		// e.printStackTrace();
        	// }
            break;
        }
    }
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>cookie1</title>
    </head>
    <body>
        <form method="POST" action="cookie2.jsp">
            <dl>
                <dt>名前</dt>
                <dd><input type="text" name="name" size="10" value="<%= name %>"></dd>
            </dl>
            <input type="submit" value="登録">
        </form>
    </body>
</html>