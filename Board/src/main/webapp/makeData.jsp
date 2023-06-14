<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page
	import="java.sql.*, javax.sql.*, java.io.*, java.util.*, java.net.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="kr.ac.kopo.ctc.kopo01.dao.*" %>
<%@ page import="kr.ac.kopo.ctc.kopo01.domain.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>make data</title>
<style>
body {
	background-color: #f5f5f5;
	text-align : center;
}
</style>
</head>
<body>
<%
	BoardItemDao boardItemDao = new BoardItemDaoImpl(); //객체 생성
	boolean tableCreated = boardItemDao.createTable();  //테이블 만들기
	if (tableCreated) {
		%>
		<div><h1>테이블 생성 성공</h1></div>
		<%
	} else {
		%>
		<div><h1>테이블이 이미 존재 합니다.</h1></div>
		<%
	}
	
	boolean testData = boardItemDao.makedata(); //테스트 데이터 테이블에 넣기
	if (testData) {
		%>
		<div><h1>테스트 데이터 입력 성공 </h1></div>
		<%
	}

%>
</body>
</html>