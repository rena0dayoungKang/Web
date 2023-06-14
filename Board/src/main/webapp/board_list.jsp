<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page
	import="java.sql.*, javax.sql.*, java.io.*, java.util.*, java.net.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="kr.ac.kopo.ctc.kopo01.dao.*"%>
<%@ page import="kr.ac.kopo.ctc.kopo01.domain.*"%>
<%@ page import="kr.ac.kopo.ctc.kopo01.dto.*"%>
<%@ page import="kr.ac.kopo.ctc.kopo01.service.*"%>
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
<title>게시판 리스트</title>
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

a {
	text-decoration: none;
}

a:link {
	color: black;
	text-decoration: none;
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
	int currentPage = 1; //현재페이지를 1페이지로 초기화
	int countPerPage = 20;//한 페이지당 나오는 숫자를 20으로 초기화
	
try {
	currentPage = Integer.parseInt(request.getParameter("from"));
	// request에서 'from' 파라미터 값을 가져와 현재 페이지로 설정
	countPerPage = Integer.parseInt(request.getParameter("cnt"));
	// request에서 'cnt' 파라미터 값을 가져와 현재 페이지로 설정
} catch (Exception e) {
	currentPage = 1;
	countPerPage = 20;
}
%>
</head>
<body>

<%

	BoardItemDao boardItemDao = new BoardItemDaoImpl(); //객체 생성
	List<BoardItem> boardItemList = new ArrayList<BoardItem>(); //어레이 리스트 객체 생성
	
	BoardItemService boardItemService = new BoardItemServiceImpl(); //객체 생성
	Pagination pagination = boardItemService.getPagination(currentPage, countPerPage); //페이지네이션 객체생성
	boardItemList = boardItemDao.allView(); //allView()메소드 호출 
	
	 java.util.Date currentDate = new java.util.Date();	//날짜 객체 생성 
	 java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd"); //날짜 포맷생성
	 
	
%>
	<h1>게시판 목록</h1>
	<table>
		<tr style="text-align: center">
			<!-- 테이블 제목 생성 -->
			<td>번호</td>
			<td>제목</td>
			<td>조회수</td>
			<td>등록일</td>
		</tr>
		
		<%
		//페이지 설정
		int cPage = pagination.getC(); //현재 페이지 설정
		if(cPage <= 0) {
			cPage = 1;
		}
		int startNumber = (cPage - 1) * countPerPage; //시작번호 설정 
		int total_cnt = boardItemDao.count(); //총 데이터 갯수 설정 
		
		if (total_cnt == 0) {
			%>
			<h3 style="text-align: center">테이블에 데이터가 없습니다.</h3>
			<%
		}
				
		for (int i = startNumber; i < startNumber + countPerPage; i++) {
			if (i > total_cnt - 1) {
				break;
			}		
		%>
		
		<tr>
			<td><%=boardItemList.get(i).getId() %></td>
			<td><%
				if(boardItemList.get(i).getRelevel() > 0) {
					for (int j = 0; j < boardItemList.get(i).getRelevel(); j++) {
						%>&#45;<%
					} %>&gt;<%
				}
				%>
				<a href="board_view.jsp?id=<%=boardItemList.get(i).getId() %>">
					<%=boardItemList.get(i).getTitle() %>
					<% java.util.Date itemDate = dateFormat.parse(boardItemList.get(i).getDate());
					   String itemDateFormatted = dateFormat.format(itemDate);
					   String currentDateFormatted = dateFormat.format(currentDate);
					   if (currentDateFormatted.equals(itemDateFormatted)) { %>
					<span style="color: red;">[NEW]</span> <% } %>
				</a>
			</td>
			<td><%=boardItemList.get(i).getViewcnt() %></td>
			<td><%=boardItemList.get(i).getDate() %></td>
		</tr>
		<%
		}
		%>	
	</table>			
	<table>
		<tr>
			<td colspan=4 style="text-align:center;">
				<% // << 버튼과  < 버튼 생성으로 페이지 이동 
				if (pagination.getPp() != -1) {  
					%>
					<a href="board_list.jsp?from=<%=pagination.getPp()%>&cnt=<%=countPerPage%>">&lt;&lt;</a>
					<a href="board_list.jsp?from=<%=pagination.getP()%>&cnt=<%=countPerPage%>">&lt;</a>	
					<%
				}
				%>
				<% // 숫자 페이지 출력
				for (int i = pagination.getS(); i < pagination.getS() + 10; i++) {
					if (((i - 1) * countPerPage) >= total_cnt) {
						break;
					}
				%>
				<span><a href="board_list.jsp?from=<%=i%>&cnt=<%=countPerPage%>" 
						<% if ( i == currentPage) { %> class="current-page" <% } %> > <%=i%> </a>
				</span>
				<%
				}
				// >> 버튼과 > 버튼 생성으로 페이지 이동
				if (pagination.getNn() != -1) {
				%>
					<a href="board_list.jsp?from=<%=pagination.getN()%>&cnt=<%=countPerPage%>">&gt;</a>
					<a href="board_list.jsp?from=<%=pagination.getNn()%>&cnt=<%=countPerPage%>" 
						<% if (pagination.getNn() == currentPage) { %> class="current-page" <% } %> > &gt;&gt; </a>
				<%
				}
				%>
		</tr>
		<tr>
			<td colspan=4>
				<div>
					<form method='post' action='board_insert.jsp' style="text-align:right;">
						<input type="submit" value="글쓰기">
					</form>
				</div>
			</td>
		</tr>
	</table>	
</body>
</html>
