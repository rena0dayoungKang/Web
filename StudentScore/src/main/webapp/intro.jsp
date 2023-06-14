<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page
	import="java.sql.*, javax.sql.*, java.io.*, java.util.*, java.net.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="kr.ac.kopo.ctc.kopo01.dao. *"%>
<%@ page import="kr.ac.kopo.ctc.kopo01.domain. * "%>
<%@ page import="kr.ac.kopo.ctc.kopo01.dto. * "%>
<%@ page import="kr.ac.kopo.ctc.kopo01.service. * "%>

<!DOCTYPE html>
<html>
<head>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f5f5f5;
	margin: 0;
	padding: 20px;
}

h1 {
	color: #333;
	text-align: center;
	margin-top: 50px;
}

a {
	display: block;
	padding: 10px;
	background-color: #4caf50;
	color: #fff;
	text-decoration: none;
	border-radius: 4px;
	text-align: center;
	width: 200px;
	margin: 20px auto;
}

a:hover {
	background-color: #45a049;
}

.visit {
	font-size: 24px;
	font-weight: bold;
	margin-top: 20px;
	text-align: center;
}
</style>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Student Score</title>
</head>
<body>

	<h1>Student Score</h1><br>
	<a href="index.html">Shortcut</a>

	<%
	StudentItemDao studentItemDao = new StudentItemDaoImpl(); //객체 생성 
	int visitCount = studentItemDao.countVisit();//countVisit()메소드호출
	%>
	 
	<div class="visit">  <!-- 방문자수 count  -->
		Visit Count [<span><%=visitCount%></span>]
	</div>
</body>
</html>
