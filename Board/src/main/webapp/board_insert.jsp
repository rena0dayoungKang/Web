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
<title>새 글 입력</title>
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
		if(element.value !== "") {
			element.classList.remove("input-field");
		} else {
			element.classList.add("input-field");
		}
	}	
	
	//제목에 공백을 없애기
	function validateInput() {
		const inputField = document.getElementById("title");
		const contentField = document.querySelector('textarea[name="content"]');
		const titleValue = inputField.value.trim();
		
		if (value === ""){
			alert("제목을 입력해 주세요");
			return false;
		} 
		if (!checkContentSize(contentField)){
			return false;
		}
		return true;
	}
	
	
	//텍스트에리어 크기 검사
	function checkContentSize(element) {
		const maxSize = 15 * 1024 * 1024; //15MB
		const currentSize = new Blob([element.value]).size;
		
		if(currentSize > maxSize) {
			alert("내용이 15MB를 초과하였습니다. 내용을 줄여주세요");
			return false;
		}
		return true;
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
	<h1>게시글 입력</h1>
<%

	BoardItemDao boardItemDao = new BoardItemDaoImpl(); //객체 생성 
	Integer INSERT = boardItemDao.insertID(); //INSERT 정수형으로 입력 

%>
	<form method='post' onsubmit="return validateInput()"> <!-- 테이블생성  -->
		<table width=650 border=1 cellspacing=0 cellpadding=5>
			<tr>
				<td><b>번호</b></td> <!-- 번호 입력  -->
				<td>신규(<%=INSERT %><input type="hidden" name="INSERT" value=<%=INSERT %>>)</td> <!-- insert값 -->
			</tr>
			<tr>
				<td><b>제목</b></td> <!-- title값 받아오기  -->
				<td>
				<input type="text" id="title" style="width:500px; height:20px" name=title maxlength=70 
				placeholder="제목을 입력해주세요" required  pattern="^(?!.*\s$)\s*\S+.*$"	class="input-field">
				</td>
			</tr>
			<tr>
				<td><b>일자</b></td> <!-- 시스템 지정 날짜로 설정  -->
				<td><input type="hidden" name="date" value=<%=sdf2.format(currentDate)%>><%=sdf.format(currentDate)%></td>
			</tr>
			<tr>
				<td><b>내용</b></td> <!-- content 값 -->
				<td><textarea style="width:500px; height:250px;" name=content cols=70 row=600 
				placeholder="내용을 입력해주세요" class="input-field" required></textarea> </td>
			</tr>
		</table>
		<table>
			<tr>
				<td width=90%></td>
				<td><input type=button value="취소" Onclick="location.href='board_list.jsp'"></td> <!-- 취소버튼 -->
				<td><input type=submit value="쓰기" formaction="board_write.jsp"></td> <!-- 쓰기 버튼 -->
			</tr>
		</table>
	</form>
</body>
</html>