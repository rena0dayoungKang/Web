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
<title>댓글입력</title>
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
	//내용 적는 textarea 디폴트 글자를 반투명하게 하고, 사용자가 글을 바로 적을 수 있도록 함
	function checkInput(element) {
		if(elemet.value !== "") {
			element.classList.remove("input-field");
		} else {
			element.classList.add("input-field");
		}
	}
</script>
<%	
	//날짜 표시를 위해 java.util date가져오기 
	java.util.Date currentDate = new java.util.Date();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat("yyyy-MM-dd,HH:mm:ss");
%>
</head>
<body>
	<h1>댓글 입력</h1>
<%

	int id = Integer.parseInt(request.getParameter("id"));
	BoardItemDao boardItemDao = new BoardItemDaoImpl(); //객체 생성
	BoardItem boardItem = boardItemDao.oneView(id);
	
	int recnt = boardItem.getRecnt();
	int relevel = boardItem.getRelevel();
	

%>
	<form method='post'>
		<h3 style="text-align:center;">[<%=id %>]에 대한 댓글을 새로 입력합니다.</h3>
		<table>
			<tr>
				<td>번호</td>
				<td colspan=3>댓글(INSERT)</td>
			</tr>
			<tr>
				<td>제목</td>
				<td colspan=3><input type="text" name="title" size=70 maxlength=70 value="" required
				placeholder="제목을 입력해주세요" required pattern="^(?!.*\s$)\s*\S+.*$"	 class="input-field"></td>
			</tr>
			<tr>
				<td>일자</td>
				<td colspan=3>
					<input type="hidden" name="date" value="<%=sdf2.format(new java.util.Date())%>">
						<%=sdf.format(new java.util.Date())%>
				</td>
			</tr>
			<tr>
				<td>댓글 내용</td>
				<td colspan=3><textarea style="width:530px; height:250px;" name="content" cols=70 row=600
					placeholder="내용을 입력해주세요" class="input-field" required></textarea></td>
			</tr>
			<tr>
				<td>원글 번호</td>
				<td colspan=3><%=boardItem.getRootid() %><input type="hidden" name="rootid" value=<%=boardItem.getRootid() %>></td>
			</tr>
			<tr>
				<td>댓글 수준</td>
				<td><input type="hidden" name="relevel" value="<%=relevel%>"><%=relevel + 1 %></td>
				<td style="text-align: right;">댓글 내 순서</td>
				<td><input type="hidden" name="recnt" min=1 value="<%=recnt%>">[자동]</td>
				
			</tr>
			<tr>
				<td colspan =4 style="text-align: right;">
				<input type="button" value="목록" OnClick="location.href='board_list.jsp'">
				<input type="submit" value="저장" formaction="./board_rewrite.jsp">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>