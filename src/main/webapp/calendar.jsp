<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.ZoneId" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="ja_JP" />

<%!
	private static Map eventMap = new HashMap();
	static {
		eventMap.put("20240101", "お正月");
		eventMap.put("20241225", "クリスマス");
		eventMap.put("20241231", "大晦日");
	}
%>
<%
	// リクエストのパラメーターから日付を取り出す
	String year = (String)request.getParameter("year");
	String month = (String)request.getParameter("month");
	String day = (String)request.getParameter("day");
	LocalDate localDate = null;
	// 年、月、日いずれかの値が設定されていない場合
	if (year == null || month == null || day == null) {
		// 日付が送信されていないので、現在時刻を元に日付の設定を行う
		localDate = LocalDate.now();
		// localDateから年月日の値を取得し、それを文字列に変換(of)してyear変数に保存する
		year = String.valueOf(localDate.getYear());
		month = String.valueOf(localDate.getMonthValue());
		day = String.valueOf(localDate.getDayOfMonth());
	} else {
		// 送信された日付を元に、LocalDate.ofでインスタンスを生成する
		// Integer.parseInt1で、文字列であるyearを整数（int）型に変換する
		localDate = LocalDate.of(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(day));
	}
	String[] dates = {year, month, day};
	pageContext.setAttribute("dates", dates);  
	pageContext.setAttribute("date", Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));

	String event = (String)eventMap.get(year + month + day);
	pageContext.setAttribute("event", event);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>calendar</title>
<style>
ul {
  list-style: none;
}
</style>
</head>
<body>
  <form method="POST" action="/jsp/calendar.jsp">
    <ul>
      <li><input type="text" name="year" value="${param['year']}" /><label for="year">年</label><input type="text" name="month" value="${param['month']}" /><label for="month">月</label><input type="text" name="day" value="${param['day']}" /><label for="day">日</label></li>
      <li><input type="submit" value="送信" />
      <li><c:out value="${fn:join(dates, '/')}" /> (<fmt:formatDate value="${date}" pattern="E" />)</li>
      <li><c:out value="${event}" /></li>
    </ul>
  </form>
</body>
</html>
