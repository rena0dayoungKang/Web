<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page
	import="java.sql.*, javax.sql.*, java.io.*, java.util.*, java.net.*"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%@ page import="kr.ac.kopo.ctc.kopo01.dao.*"%>
<%@ page import="kr.ac.kopo.ctc.kopo01.domain.*"%>
<%@ page import="kr.ac.kopo.ctc.kopo01.dto.*"%>
<%@ page import="kr.ac.kopo.ctc.kopo01.service.*"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%!
	private String escapeHtml(String unsafeInput) {
		return String.valueOf(unsafeInput)
		.replace("&", "&amp;")
		.replace("<", "&lt;")
		.replace(">", "&gt;")
		.replace("'", "&#039;");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>댓글 입력, 추가</title>
<style>
table {
	width: 100%;
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

a, span {
	text-decoration: none;
}

a:link {
	color: black;
}

h1 {
	text-align: center;
	font-family: "Arial Black", sans-serif;
	color: #333;
	margin-top: 20px;
}

.pagination-container .pagination-numbers {
	display: inline-block;
	margin: 0 5px;
	text-align: center;
}

.pagination-container {
	text-align:center;
	display: flex;
	justify-content: center;
	align-items: center;
}

</style>
</head>
<body>
<%
	BoardItemDao boardItemDao = new BoardItemDaoImpl(); //객체생성
	
	int recnt = Integer.parseInt(request.getParameter("recnt"));
	int relevel = Integer.parseInt(request.getParameter("relevel"));
	String title = escapeHtml(request.getParameter("title"));
	String content = escapeHtml(request.getParameter("content"));
	String date = request.getParameter("date");
	int rootid = Integer.parseInt(request.getParameter("rootid"));
	int viewcnt = 0;
	
	
	boardItemDao.recnt(rootid, recnt); //recnt 1씩 밀어내기
	boardItemDao.rewrite(title, date, content, rootid, relevel, recnt, viewcnt); //새댓글
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
	
	
</body>
</html>