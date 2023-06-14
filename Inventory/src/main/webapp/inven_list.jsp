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
<title>상품 목록 리스트</title>
<%
int currentPage = 1;//현재페이지를 1페이지로 초기화
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
<style>
table {
	width: 100%;
	border-collapse: collapse;
	background-color: #f8f8f8;
	border: 1px solid #ddd;
	font-family: Arial, sans-serif;
}

th, td {
	padding: 10px;
	text-align: center;
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

.pagination-container .pagination-numbers {
	display: inline-block;
	margin: 0 5px;
	text-align: center;
}

.pagination-container {
	text-align: center;
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 10px;
}

.current-page {
	color: red;
	font-weight: bold;
}

.registration-container {
	text-align: right;
	margin-top: 10px;
	margin-bottom: 10px;
}

a {
	text-decoration : none;
}

a:hover{
	color: red;
	font-weight: bold;
}
</style>
</head>
<body>
	<%
	InventoryDao inventoryDao = new InventoryDaoImpl(); //Dao 인터페이스를 구현한 DaoImpl클래스 객체 생성
	List<InventoryItem> inventoryItemList = new ArrayList<InventoryItem>(); //어레이 리스트 객체 생성
	inventoryItemList = inventoryDao.showAll(); //showAll() 메소드 호출 
	
	InventoryService inventoryService = new InventoryServiceImpl();//페이지 서비스 객체 생성
	Pagination pagination = inventoryService.getPagination(currentPage, countPerPage);//페이지네이션을 위한 객체생성
	
%>
	<h1>(주)트와이스 재고 현황 - 전체 현황</h1>
	<table>
		<tr style="text-align: center">
			<td>상품 번호</td>
			<td>상품명</td>
			<td>현재 재고 수</td>
			<td>상품 등록일</td>
			<td>재고 조사</td>
		</tr>
		<%
		for (int i = 0; i < inventoryItemList.size(); i++){
			long id = inventoryItemList.get(i).getId(); 				//상품번호
			String name = inventoryItemList.get(i).getName();			//상품명
			int stock = inventoryItemList.get(i).getStock();			//상품재고
			String regiDate = inventoryItemList.get(i).getRegiDate();   //상품등록일
			String regiDateQ = inventoryItemList.get(i).getRegiDateQ(); //상품 재고 조사일
		%>
		<tr>
			<td><a href="inven_one.jsp?id=<%=id %>"><%=id %></a></td>
			<!-- id값을 누르면 개별조회 페이지로 이동 -->
			<td><a href="inven_one.jsp?id=<%=id %>"><%=name %></a></td>
			<!--name을 누르면 해당id 페이지로 이동 -->
			<td><%=stock %></td>
			<td><%=regiDate %></td>
			<td><%=regiDateQ %></td>
		</tr>
		<%
		}
		%>
	</table>

	<%
	//페이지 설정 
	InventoryDaoImpl inventoryDaoImpl = new InventoryDaoImpl(); //객체 생성
	
	int cPage = pagination.getC(); //현재 페이지 설정
	int startNumber = (cPage - 1) * countPerPage; //시작번호 설정
	
	int totalCount = inventoryDao.count(); //총 데이터 갯수 설정
	if (totalCount == 0) {
		%>
	<h3 style="text-align: center">테이블에 데이터가 없습니다.</h3>
	<%
	}
	
	int endPage = 0;  //최종 페이지 
	if (totalCount % countPerPage == 0) {  //나머지가 없다면 
		endPage = totalCount / countPerPage;
	} else {
		endPage = (totalCount / countPerPage) + 1;
	}
	
	int startPage = ((currentPage - 1) / 10) * 10 + 1; //시작페이지 	
	%>

	<!--  하단 페이지네이션 과 상품등록 버튼 출력  -->
	<div class="pagination-container">
		<%
			// << 버튼과 < 버튼 클릭 시,
			if (pagination.getPp() == -1) {
				//Pp가 -1이라면 (1부터 10까지는 앞의 페이지가 없어서 <<을 출력하지 않음)
			} else {
			%>
		<a
			href="inven_list.jsp?from=<%=pagination.getPp()%>&cnt=<%=countPerPage%>">&lt;%lt;</a>
		<a
			href="inven_list.jsp?from=<%=startPage - 1%> &cnt=<%=countPerPage%>">&lt;</a>
		<%
			}
			
			// 숫자 페이지 출력 
			for (int i = pagination.getS(); i < pagination.getS() + 10; i++) {
				if (((i - 1) * countPerPage) > totalCount) {
					break;
				}
				%>
		<!-- 현재 페이지를 강조하여 표시  -->
		<div class="pagination-numbers">
			<span> <a
				href="inven_list.jsp?from=<%=i %>&cnt=<%=countPerPage %>"
				<% if (i == currentPage) { %> class="current-page" <% } %>><%=i %>
			</a>
			</span>
		</div>
		<%
			}
			
			// >> 버튼과 > 버튼 클릭 시,
			if (pagination.getNn() == -1) {
				
			} else {
			%>
		<a
			href="inven_list.jsp?from=<%=pagination.getN() %>&cnt=<%=countPerPage %>">&gt;</a>
		<a href="inven_list.jsp?from=<%=endPage%>&cnt=<%=countPerPage%>"
			<% if (pagination.getNn() == currentPage) { %> class="current-page"
			<% } %>>&gt;&gt;</a>
		<%
			}
			%>
	</div>

	<div>
		<form method='post' action='inven_new.jsp' style="text-align: right;">
			<input type="submit" value="상품등록">
		</form>
	</div>

</body>
</html>