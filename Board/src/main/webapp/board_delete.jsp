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
<title>글 삭제</title>
<style>
table {
	width: 800px;
	border-collapse: collapse;
}

th, td {
	padding: 8px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

tr:hover {
	background-color: #f5f5f5;
}

span > a {
	text-decoration : none;
}
</style>
</head>
<body>
<%
try{
	int id = Integer.parseInt(request.getParameter("id"));  //id값을 파라미터로 받아온다
	BoardItemDao boardItemDao = new BoardItemDaoImpl(); //객체 생성
	BoardItem boardItem = boardItemDao.oneView(id); //oneview()메소드 호출
	
	boolean success = boardItemDao.delete(id, boardItem.getRelevel()); //delete()메소드 호출
	
	if (success) {  //글 삭제 성공 시 
		out.println("글 삭제 성공");
	} else {  		//글 삭제 실패 시 
		out.println("글 삭제 실패");
	}
%>

	<p>페이지로 돌아가는 중입니다...</p>
	<script>
	function goBack() {
		location.href = "board_list.jsp"; //gongji_list.jsp페이지로 돌아간다.
	}
	// 페이지 로드 후 자동으로 goBack() 함수 호출
	window.onload = function() {
		setTimeout(goBack, 500); //페이지 로드 후 1초의 시간을 두고 뒤로 돌아간다. 
	};
	</script>
	<%
	} catch (Exception e) {
		e.printStackTrace();
	} 
	%>
</body>
</html>