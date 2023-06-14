<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*, java.net.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="kr.ac.kopo.ctc.kopo01.dao.*" %>
<%@ page import="kr.ac.kopo.ctc.kopo01.domain.*" %>
<%@ page import="kr.ac.kopo.ctc.kopo01.dto.*" %>
<%@ page import="kr.ac.kopo.ctc.kopo01.service.*" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>재고 수정</title>
<style>
    h1, p {
        text-align: center;
        font-family: "Arial Black", sans-serif;
        color: #333;
        margin-top: 20px;
    }
</style>
</head>
<body>
	<h1>(주)트와이스 재고 현황 - 재고 수정</h1>
<%
	long id = Long.parseLong(request.getParameter("id")); //id 작성
	int stock = Integer.parseInt(request.getParameter("stock")); //재고
	
	InventoryDao inventoryDao = new InventoryDaoImpl();  //객체생성
	inventoryDao.updateQuantitiy(id, stock);   //재고수정하는 메소드 호출
%>

	<p>페이지로 돌아가는 중입니다...</p>
	<script>
		function goBack() {
			location.href = "inven_list.jsp"; //gongji_list.jsp페이지로 돌아간다.
		}
		// 페이지 로드 후 자동으로 goBack() 함수 호출
		window.onload = function() {
			setTimeout(goBack, 1000); //페이지 로드 후 1초의 시간을 두고 뒤로 돌아간다. 
		};
	</script>
	
	
</body>
</html>