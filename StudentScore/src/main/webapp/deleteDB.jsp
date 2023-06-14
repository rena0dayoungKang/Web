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
<%
String name = request.getParameter("name");  //name이라는 파라미터 값 가져오기 
Integer stu_id = null; 
try {
	String stu_idParam = request.getParameter("stu_id"); //stu_id 파라미터 가져오기 
	if (stu_idParam != null && !stu_idParam.isEmpty()) { //stu_idParam 변수가 null이 아니고 비어있지 않은 경우에 
		stu_id = Integer.parseInt(stu_idParam);		//stu_idParam을 정수변환하여 stu_id값으로 저장
	}
} catch (NumberFormatException e) {  
	e.printStackTrace();
}
Integer kor = Integer.parseInt(request.getParameter("kor")); //kor파라미터 가져오기
Integer eng = Integer.parseInt(request.getParameter("eng")); //eng파라미터 가져오기
Integer mat = Integer.parseInt(request.getParameter("mat")); //matm파라미터 가져오기 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Delete Score</title>
</head>
<body>
	<%
try{
	StudentItemDao studentItemDao = new StudentItemDaoImpl(); //객체 생성 
	int error = studentItemDao.deleteData(stu_id); //deleteData()메소드 호출하여 return값을 error로 가져오기
	List<StudentItem> studentItemList = studentItemDao.selectAll(); //selectAll()메소드 호출하여 리스트 변수에 저장 
	if (error == 1) { //정상인경우 출력  
	%>
	<h1>Delete score</h1>
	<table cellspacing=1 width=600 border=1> <!-- 테이블시작 -->
		<tr>
			<td width=50><p align=center>Name</p></td> <!-- 학생이름 -->
			<td width=50><p align=center>Student ID</p></td> <!-- 학생 학번 -->
			<td width=50><p align=center>Korean Score</p></td> <!-- 국어점수 -->
			<td width=50><p align=center>English Score</p></td> <!-- 영어점수 -->
			<td width=50><p align=center>Math Score</p></td> <!-- 수학점수 -->
			<td width=50><p align=center>Sum</p></td> <!-- 합계 -->
			<td width=50><p align=center>Avg</p></td> <!-- 평균 -->
			<td width=50><p align=center>Rank</p></td> <!-- 등수 -->	
		</tr>
		<%
		for (StudentItem st : studentItemList) { //학생 정보 리스트를 반복적으로 처리 하기
			int rank = studentItemDao.rank(st.getStu_id()); //rank메소드를 호출하여 stu_id에 해당하는 성적등수가져오기
			int sum = st.getKor() + st.getEng() + st.getMat(); //과목 합산 점수를 sum에 저장
			double avg = ((int) ((sum / 3.0) * 100)) / 100.0 ; //평균 점수를 계산하여 저장 
	%>
		<tr>
			<td><a href="oneview.jsp?stu_id=<%=st.getStu_id()%>"
				target="main"><%=st.getName()%></a></td>  <!-- 학생 이름을 링크로 처리  -->
			<td><%=st.getStu_id()%></td> 
			<td><%=st.getKor() %></td>
			<td><%=st.getEng() %></td>
			<td><%=st.getMat() %></td>
			<td><%=sum %></td>
			<td><%=avg %></td>
			<td><%=rank %></td>
		</tr>
		<%		
		}
	} else { //오류인경우 출력 
	%>
		<h1>error occurred</h1>
		<%
	}
	%>
		<%
} catch (Exception e) { //삭제가 실패했을 시 출력 
%>
		<h1>delete fail</h1>
		<%
}
%>
</body>
</html>