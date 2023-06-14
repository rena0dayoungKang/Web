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
<title>글 수정하기</title>
<script>

	//제목에 공백을 없애기
	function validateInput() {
		const inputField = document.getElementById("title");
		const contentField = document.querySelector('textarea[name="content"]');
		const titleValue = inputField.value.trim();
		
		if (titleValue === ""){
			alert("제목을 입력해 주세요");
			return false;
		} 
		if (!checkContentSize(contentField)){
			return false;
		}
		return true;
	}

</script>
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
<%
	//날짜 표시를 위해 java.util date가져오기 
	java.util.Date currentDate = new java.util.Date();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:SS");
	java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat("yyyy-MM-dd,HH:mm:SS");
%>
</head>
<body>
	<h1>게시글 수정</h1>
<%
	int id = Integer.parseInt(request.getParameter("id"));  // id 값 받아오기
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	BoardItemDao boardItemDao = new BoardItemDaoImpl(); //BoardItemDaoImpl() 클래스의 객체 생성
	BoardItem boardItem = boardItemDao.oneView(id); //oneView()메소드로 selectedID를 매개변수로 호출
%>
<form method='post' onsubmit="return validateInput()">
	<table>
		<%
		try {
		%>
		<tr>
			<td>번호</td>  <!-- 번호 id -->
			<td> 
			<% if (boardItem.getRelevel() == 0) {
				%> <input type="number" name="updateId" size=70 maxlength=70 value=<%=boardItem.getId() %> max="999999"> <%
			} else {
				%> <%=boardItem.getId() %>번글의 댓글 수정<% 
			}
			%>
			</td>
		</tr>
		<tr>
			<td>제목</td> <!-- 제목 타이틀은 보여지는 거은 원래의 값이고 수정하면 title 값으로 넘겨진다 -->
			<td><input type="text" name="title" id="title" size=70 maxlength=70 value="<%=boardItem.getTitle() %>" required></td>
		</tr>
		<tr>
			<td>일자</td> <!-- 날짜는 시스템 설정 날짜 -->
			<td><input type="hidden" name="date" value="<%=sdf2.format(new java.util.Date())%>"><%=sdf.format(new java.util.Date())%></td>
		</tr>
		<tr>
			<td>내용</td> <!-- 내용이 보여지는 것은 원래 값이고 수정하면 content값으로 넘겨진다.  -->
			<td><textarea style='width:500px; height:250px;' name="content" cols=70 row=600 required><%=boardItem.getContent() %></textarea></td>
		</tr>
		<tr>
			<td>원글 번호</td>
			<td><input type="text" readonly name="rootid" value=<%=boardItem.getRootid() %>></td>
		</tr>
		<tr>
			<td>댓글 수준</td>
			<td>
				<% if (boardItem.getRelevel() == 0) {
					%> 0 <%	} else {
						%><input type="number" name="Relevel" min=1 value=<%=boardItem.getRelevel()%> readonly><%
					}%>
			</td>
		</tr>
	</table>
	<table>
		<tr>
			<td colspan =2 style="text-align: right;">
				<input type="hidden" name="id" value="<%=id %>">
				<input type="button" value="목록" OnClick="location.href='board_list.jsp'"> <!-- 취소버튼은 list로 다시 돌아간다 -->
				<input type="submit" value="저장" formaction="./board_write.jsp"> <!-- 쓰기 버튼은 write.jsp로 이동한다 -->
				<input type="submit" value="삭제" formaction="./board_delete.jsp"> <!-- 삭제 버튼은 delete.jsp로 이동한다ㅣ -->
			</td>
		</tr>
		<%
		} catch (Exception e) {
			e.printStackTrace();
		}
		%>
	</table>
</form>
</body>
</html>