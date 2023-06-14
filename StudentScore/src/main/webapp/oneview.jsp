<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="kr.ac.kopo.ctc.kopo01.dao.*"%>
<%@ page import="kr.ac.kopo.ctc.kopo01.domain.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>score view - select one</title>
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
</style>
</head>
<body>

	<h2>Student Information - select One</h2>
	<hr>
	<%
		int selectedStuId = Integer.parseInt(request.getParameter("stu_id"));
		// stu_id 파라미터 값을 변수에 저장
		StudentItemDao studentItemDao = new StudentItemDaoImpl();
		// StudentItemDaoImpl 클래스의 객체를 생성
		StudentItem studentItem = studentItemDao.selectOne(selectedStuId);
		// selectOne() 메소드로 selectedStuID를 매개변수로 호출
	
	if (studentItem != null) {
	%>
	<!-- 학생 정보 테이블 생성 -->
	<table>
		<tr>
			<td>Name</td>
			<td>Student id</td>
			<td>Korean</td>
			<td>English</td>
			<td>Math</td>
			<td>Sum</td>
			<td>Avg</td>
			<td>Rank</td>
		</tr>
		<%
		int sum = studentItem.getKor() + studentItem.getEng() + studentItem.getMat(); //합계출력
		double avg = (int)((double) sum / 3 * 100) / 100; //평균출력
		int rank = studentItemDao.rank(studentItem.getStu_id()); //등수출력. rank 메소드 사용 
		
		%>
		<!-- 학생 정보 출력 -->
		<tr>
			<td><%=studentItem.getName() %></td>
			<td><%=studentItem.getStu_id() %></td>
			<td><%=studentItem.getKor() %></td>
			<td><%=studentItem.getEng() %></td>
			<td><%=studentItem.getMat() %></td>
			<td><%=sum %></td>		
			<td><%=avg %></td>
			<td><%=rank %></td>
		</tr>

	<%	
	} else {
	%> <!-- 학생 정보가 없을 경우 메시지 출력 -->
	<p>
		No student found with Student ID
		<%= selectedStuId %></p>
	<%
	}
	%>
</body>
</html>
