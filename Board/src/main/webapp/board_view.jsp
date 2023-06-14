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
<title>글 하나 보기</title>
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
	<h1>게시글 하나 보기</h1>
<%
try{
	int id = Integer.parseInt(request.getParameter("id")); //id값 받아오기
	BoardItemDao boardItemDao = new BoardItemDaoImpl(); //BoardItemDaoImpl() 클래스의 객체 생성
	BoardItem boardItem = boardItemDao.oneView(id);
	boardItemDao.viewCnt(id);
	
	if (boardItem != null) {
	%>
	<table>
		<tr>
			<td style="text-align:center; width:20%;">번호</td> <!-- 번호정보 가져오기  -->
			<td colspan=3><%=boardItem.getId() %></td>
		</tr>
		<tr>
			<td style="text-align:center;">제목</td> <!-- 제목 정보 가져오기  -->
			<td colspan=3><%=boardItem.getTitle() %></td>
		</tr>
		<tr>
			<td style="text-align:center;">일자</td> <!-- 등록일 가져오기  -->
			<td colspan=3><%=boardItem.getDate() %></td>
		</tr>
		<tr>
			<td style="text-align:center;">조회수</td>  <!-- 조회수 가져오기 -->
			<td colspan=3><%=boardItem.getViewcnt()+1 %></td>
		</tr>
		<tr>
			<td style="text-align:center;">내용</td> <!-- 내용 가져오기 -->
			<td colspan=3>
				<textarea readonly style="width:100%; height:200px; resize:none; border:1px solid black;"><%=boardItem.getContent() %></textarea>
			</td>
		</tr>
		<tr>
			<td style="text-align:center;">원글 번호</td><!-- 원글번호 가져오기 -->
			<td colspan=3><%=boardItem.getRootid() %></td>
		</tr>
		<tr>
			<td style="text-align:center;">댓글 수준</td><!--댓글 레벨 가져오기 -->
			<td><%=boardItem.getRelevel() %></td>
			<td>댓글 내 순서 </td><!--댓글 레벨 가져오기 -->
			<td><%=boardItem.getRecnt() %></td>
		</tr>
		<tr>
			<td colspan =4 style="text-align: right;">
				<input type=button value="목록" Onclick="location.href='board_list.jsp'">
				<input type=button value="수정" OnClick="location.href='board_update.jsp?id=<%=boardItem.getId()%>'">
				<input type=button value="삭제" OnClick="location.href='board_delete.jsp?id=<%=boardItem.getId()%>'">
				<input type=button value="댓글" OnClick="location.href='board_reinsert.jsp?id=<%=boardItem.getId()%>'">
			</td>
		</tr>
	</table>
	<%
	} else if (boardItem == null) {
		%><h3>데이터가 없습니다.</h3> <%
	}
} catch (Exception e) {
	%> <h3>오류 발생</h3> <%
}
%>
</body>
</html>