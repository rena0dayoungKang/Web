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
		.replace("'", "&#039;")
		.replace("#", "&#35;")
		.replace("\"", "&quot;")
		.replace("!", "&#33;")
		.replace("%", "&#37;");		
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>실제 글 추가, 수정</title>
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
<script>
</script>
</head>
<body>
	<%
	BoardItemDao boardItemDao = new BoardItemDaoImpl(); //객체생성
	boolean success;
	String INSERT = request.getParameter("INSERT"); //inesrt.jsp에서 INSERT값 받아오기 
	if (INSERT != null) {
		int insert = Integer.parseInt(INSERT);
		String title = escapeHtml(request.getParameter("title")); //타이틀 제목 값 받아오기 
		String content = escapeHtml(request.getParameter("content")); //content내용 작성값 받아오기 
		String date = request.getParameter("date");
		success = boardItemDao.write(insert, title, date, content, insert);
		if(success) {
			out.println("글 등록 성공");
		} else {
			out.println("글 등록 실패");
		}
	} else if (INSERT == null) {
		int id = Integer.parseInt(request.getParameter("id"));
		int updateId = Integer.parseInt(request.getParameter("updateId"));  // id 값 받아오기
		String title = escapeHtml(request.getParameter("title"));
		String content = request.getParameter("content");
		String date = request.getParameter("date");
		success = boardItemDao.update(updateId, title, date, content, id);
		if (success) {
			out.println("글 수정 성공");
		} else {
			out.println("이미 있는 번호 입니다.");
		}
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
	
</body>
</html>