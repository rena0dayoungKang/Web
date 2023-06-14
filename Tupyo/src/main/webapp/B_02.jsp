<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page
	import="java.sql.*, javax.sql.*, java.io.*, java.util.*, java.net.*"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>투표 하기 B02</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f5f5f5;
	margin: 0;
	padding: 20px;
	text-align: center;
}

.container {
	max-width: 800px;
	margin: 0 auto;
}

.table-container {
	margin-bottom: 20px;
}

.table-container table {
	border-collapse: collapse;
	width: 100%;
	text-align: center;
}

.table-container th, .table-container td {
	border: 1px solid #ddd;
	padding: 8px;
}

.table-container tr:nth-child(even) {
	background-color: #f2f2f2;
}

.table-container tr:hover {
	background-color: #ddd;
}

a {
	display: inline-block;
	padding: 10px;
	background-color: #9595de;
	color: #fff;
	text-decoration: none;
	border-radius: 4px;
	text-align: center;
	width: 200px;
	margin: 20px auto;
}

a:hover {
	background-color: #dfdff5;
}
</style>
</head>
<body>
	<div class="container">
		<table>
			<tr>
				<td><a href="./A_01.jsp"><span>후보등록</span></a></td>
				<td><a href="./B_01.jsp"><span>투표</span></a></td>
				<td><a href="./C_01.jsp"><span>개표결과</span></a></td>
			</tr>
		</table>
	</div>

	<%
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");//객체생성
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo", "root", "kopo0622");// DB 연결
		Statement stmt = conn.createStatement(); // SQL 쿼리 실행을 위한 객체 생성
		ResultSet rset = stmt.executeQuery("select * from hubo"); //후보 테이블 불러오기
	%>

	<form method='post' action='B_01.jsp' name='TupyoForm'>
		<!-- post방식으로 B_01.jsp 에서 기호번호와 연령대 받아오기  -->

		<%
		String tupyokiho = request.getParameter("choice"); //새로운 기호번호 
		String age = request.getParameter("age"); //새로운 후보 이름 
		if (tupyokiho != null && age != null) { //두가지 항목 둘다 공백이 아니라면 
			stmt.execute("insert into kopo.tupyo (kiho, age) values ('" + tupyokiho + "', '" + age + "')"); 
			//DB의 hubo테이블에 입력하기 
		}
		
		%>
	</form>

	<h1>투표 하기</h1>
	<br>
	<h2>투표를 완료하였습니다.</h2>
	<p>페이지로 돌아가는 중입니다...</p>
	<script>
		// 후보 등록이 완료되면 이전 페이지로 돌아가는 함수
		function goBack() {
			document.TupyoForm.action = "./B_01.jsp"; //A_01.jsp페이지로 돌아간다.
			document.TupyoForm.submit();
		}
		// 페이지 로드 후 자동으로 goBack() 함수 호출
		window.onload = function() {
			setTimeout(goBack, 1000); //페이지 로드 후 2초의 시간을 두고 뒤로 돌아간다. 
		};
	<%} catch (Exception e) {
			out.println("<Script>");
			out.println("alert('투표 중 오류가 발생하였습니다');");
			out.println("history.back();");
			out.println("</script>");
			return;
	}%>
		
	</script>
</body>
</html>