<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import = "kr.ac.kopo.ctc.kopo01.dao.*" %>
<%@ page import = "kr.ac.kopo.ctc.kopo01.domain.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
	InventoryDao inventoryDao = new InventoryDaoImpl();  //객체 생성
	boolean tableCreated = inventoryDao.createTable();   //테이블이 생성되었는지
	
	if (tableCreated) {
		%>
		<div>
			<h1>Table created successfully</h1>
		</div>
		<%
	}
%>
</body>
</html>