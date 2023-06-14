<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.ctc.kopo01.dao.*"%>
<%@ page import="kr.ac.kopo.ctc.kopo01.domain.*"%>
<%@ page import="kr.ac.kopo.ctc.kopo01.service.*"%>
<%@ page import="kr.ac.kopo.ctc.kopo01.dto.*"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<html>
<head>
<meta charset="UTF-8">
<title>score view - All View</title>
<%
int currentPage = 1; //현재페이지를 1페이지로 초기화
int countPerPage = 20; //한 페이지당 나오는 숫자를 30으로 초기화

try {
	currentPage = Integer.parseInt(request.getParameter("from"));
	// request에서 'from' 파라미터 값을 가져와 현재 페이지로 설정
	countPerPage = Integer.parseInt(request.getParameter("cnt"));
} catch (Exception e) {
	currentPage = 1;
	countPerPage = 20;
}
%>
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

span > a {
	text-decoration : none;
}

.current-page {
    color: red;
    font-weight: bold;
}

</style>
</head>
<body>

	<%
	try {
		StudentItemDao studentItemDao = new StudentItemDaoImpl(); //Dao 인터페이스를 구현한 DaoImpl 클래스 객체 생성
		StudentItemService studentItemService = new StudentItemServiceImpl(); //객체생성
		List<StudentItem> studentItemList = new ArrayList<StudentItem>();  //객체의 리스트생성, 학생 항목을 담기
		Pagination pagination = studentItemService.getPagination(currentPage, countPerPage); //페이지네이션을 위한 객체생성
		studentItemList = studentItemDao.selectAll(); //모든 학생 항목을 조회하는 selectAll메소드 호출
	%>
	<table>
	<!-- 테이블 생성 -->
		<tr style="text-align: ceneter">
			<!-- 테이블 헤더 생성 -->
			<th width="20%">Name</th>
			<th width="20%">Student ID</th>
			<th>Korean</th>
			<th>English</th>
			<th>Math</th>
			<th>Total</th>
			<th>Avg</th>
			<th>Rank</th>
		</tr>


		<%
		//페이지 설정
		int cPage = pagination.getC(); //현재페이지 설정
		int startNumber  = (cPage - 1) * countPerPage; //시작을 설정
		int total_cnt = studentItemDao.count(); //총 데이터 갯수를 가져옴
		if (total_cnt == 0) { //총 데이터 갯수가 0이라면
		%>
		<h1>No data in table</h1>
		<%
		return;
		} 
		
		StudentItemDaoImpl studentItemDaoImpl = new StudentItemDaoImpl();
		int totalCount = studentItemDaoImpl.count(); //총 데이터 개수
		int endPage = 0; //최종페이지

		if (totalCount % countPerPage == 0) { //나머지가 없다면 
			endPage = totalCount / countPerPage;
		} else {
			endPage = (totalCount / countPerPage) + 1;  //나머지 출력이 있으면 페이지 +1
		}
		
		int startPage = ((currentPage - 1) / 10) * 10 + 1;

		//합계, 등수, 평균 계산
		for (int i = startNumber; i < startNumber + countPerPage; i++) {
		if (i > total_cnt - 1) //
			break;
		int rank = studentItemDao.rank(studentItemList.get(i).getStu_id());  //등수 출력
		int sum = studentItemList.get(i).getKor() + studentItemList.get(i).getEng() + studentItemList.get(i).getMat();
		//합계출력
		double avg = ((int) ((sum / 3.0) * 100)) / 100.0; //평균점수 출력 
		%>

		<tr>
			<td><a
				href="oneview.jsp?stu_id=<%=studentItemList.get(i).getStu_id()%>"
				target="main"><%=studentItemList.get(i).getName()%></a></td>
			<td><%=studentItemList.get(i).getStu_id()%></td>
			<td><%=studentItemList.get(i).getKor()%></td>
			<td><%=studentItemList.get(i).getEng()%></td>
			<td><%=studentItemList.get(i).getMat()%></td>
			<td><%=sum%></td>
			<td><%=avg%></td>
			<td><%=rank%></td>
		</tr>
		<%
		}
		%>
	</table>
	<!-- 테이블 끝 -->

	<!-- 페이지 네비게이션 시작  -->
	<div style="text-align: center; margin-top: 10px;">
		<%
		// << 버튼 과  < 버튼 클릭시 
		if (pagination.getPp() == -1) { //Pp가 -1이라면 (1부터 10까지는 앞의 페이지가 없어서 <<을 출력하지 않음)

		} else {
		%>
		<a
			href="AllviewDB2.jsp?from=<%=pagination.getPp()%>&cnt=<%=countPerPage%>">&lt;&lt;</a>
		<!-- 제일 처음으로 이동하는 링크 -->
		<a
			href="AllviewDB2.jsp?from=<%=startPage -1%>&cnt=<%=countPerPage%>">&lt;</a>
		<!-- 이전 그룹으로 이동하는 링크 -->
		<%
		}

		//페이지 출력
		for (int i = pagination.getS(); i < pagination.getS() + 10; i++) {
		if (((i - 1) * countPerPage) > total_cnt) {
			break;
		}
		%>
		<span>
			<a href="AllviewDB2.jsp?from=<%=i%>&cnt=<%=countPerPage%>" 
				<% if ( i == currentPage) { %>
					class="current-page" <% } %> > <%=i%> </a>
		</span>
		<!-- 현재 페이지를 강조하여 표시 -->
		<%
		}

		// >> 버튼과 >버튼 클릭시 
		if (pagination.getNn() == -1) {
		
		} else {
		%>
		<a href="AllviewDB2.jsp?from=<%=pagination.getN()%>&cnt=<%=countPerPage%>">&gt;</a>
		<!-- 다음 그룹으로 이동하는 링크 -->
		<a href="AllviewDB2.jsp?from=<%=endPage%>&cnt=<%=countPerPage%>" <% if (pagination.getNn() == currentPage) { %>
				class="current-page" <% } %> > &gt;&gt; </a>
		<!-- 제일 마지막 페이지로 가는 링크 -->
		<%
		}
		%>
	</div>
	<%
		
	} catch (Exception e) {
	%>
	<h1>error occurred</h1>
	}
	<%
	}
	%>
</body>
</html>