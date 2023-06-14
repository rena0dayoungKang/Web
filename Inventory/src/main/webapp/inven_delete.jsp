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
<title>상품 삭제</title>
<style>
    table {
        width: 600ㅔpx;
        border-collapse: collapse;
        background-color: #f8f8f8;
        border: 1px solid #ddd;
        font-family: Arial, sans-serif;
    }

    th, td {
        padding: 10px;
        text-align: left;
        border: 1px solid #ddd;
    }

    th {
        background-color: #f2f2f2;
        color: #333;
    }

    h1 {
        text-align: center;
        font-family: "Arial Black", sans-serif;
        color: #333;
        margin-top: 20px;
    }
</style>
</head>
<body>
	<h1>(주)트와이스 재고 현황 - 상품 삭제</h1>
<%
	long id = Long.parseLong(request.getParameter("id"));   //inven_one.jsp에서 id받아오기 
	InventoryDao inventoryDao = new InventoryDaoImpl();    //객체 생성 
	InventoryItem inventoryItem = inventoryDao.showOne(id);  //showOne() 메서드 불러오기 
	boolean success = inventoryDao.delete(id);  //delete() 메서드 불러오기 
	
	
	if(success) {
		out.println("[" + inventoryItem.getName() + "]");
		out.println("상품 삭제 성공");
	} else {
		out.println("상품 삭제 실패");
	}
	

%>

	<p>페이지로 돌아가는 중입니다...</p>
	<script>
	function goBack() {
		location.href = "inven_list.jsp"; //gongji_list.jsp페이지로 돌아간다.
	}
	// 페이지 로드 후 자동으로 goBack() 함수 호출
	window.onload = function() {
		setTimeout(goBack, 500); //페이지 로드 후 1초의 시간을 두고 뒤로 돌아간다. 
	};
	</script>

</body>
</html>