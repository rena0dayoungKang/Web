<%--examtable을 생성하는 jsp파일--%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import = "kr.ac.kopo.ctc.kopo01.dao.*" %>
<%@ page import = "kr.ac.kopo.ctc.kopo01.domain.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>createTable</title>
<style>
	body {
		display:flex;
		align-items:center;
		justify-content:center;
		height:100vh;
		margin:0;
	}
	
	.center-element {
		margin:0 auto;
		text-align:center;
	}
</style>
</head>
<body>

<%
	StudentItemDao studentItemDao = new StudentItemDaoImpl(); //객체 생성	
	boolean tableCreated = studentItemDao.createTable(); //createTable()메소드 호출
	
	if (tableCreated) {  //tableCreate가 true일때 
		%>
				<div class="center-element">
					<h1>Table created successfully</h1>
				</div>
		<%
			} else {  //tableCreate가 false일때
		%>
				<div class="center-element">
					<h1>Table already exists</h1>
				</div>
		<%
			}
%>
</body>
</html>