<%--examtable�� �����ϴ� jsp����--%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import = "kr.ac.kopo.ctc.kopo01.dao.*" %>
<%@ page import = "kr.ac.kopo.ctc.kopo01.domain.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Delete Table</title>
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
	StudentItemDao studentItemDao = new StudentItemDaoImpl();//��ü ����
	boolean tableDeleted = studentItemDao.dropTable();//dropTable()�޼ҵ� ȣ��
	
	if (tableDeleted) {  //tableDelete�� true�϶� 
		%>
				<div class="center-element"> 
					<h1>Table delete successfully</h1>
				</div>
		<%
			} else { //tableDelete�� false�϶�
		%>
				<div class="center-element">
					<h1>Table already delete</h1>
				</div>
		<%
			}
		%>

</body>
</html>