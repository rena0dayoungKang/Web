<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
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
<title>후보 등록 A02</title>
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

	<form method='post' action='A_01.jsp' name='deleteCandidateForm'>
		<!-- post방식으로 A_01.jsp 에서 기호번호와 이름 받아오기  -->
		<%
		String deletekiho = request.getParameter("deletekiho"); //기호번호
		if (request.getParameter("deletekiho") != null) { //공백이 아니라면 
			stmt.execute("DELETE FROM kopo.hubo where kiho = '" + deletekiho + "'");
		}
		%>
	</form>


	<h1 style="text-align: center">후보 삭제</h1>
	<br>
	<h2 style="text-align: center">후보 삭제 완료</h2>
	<p>페이지로 돌아가는 중입니다...</p>
	<script>
		// 후보 등록이 완료되면 이전 페이지로 돌아가는 함수
		function goBack() {
			document.deleteCandidateForm.action = "./A_01.jsp"; //A_01.jsp페이지로 돌아간다.
			document.deleteCandidateForm.submit();
		}
		// 페이지 로드 후 자동으로 goBack() 함수 호출
		window.onload = function() {
			setTimeout(goBack, 1000); //페이지 로드 후 2초의 시간을 두고 뒤로 돌아간다. 
		};
	<%} catch (Exception e) {  //삭제에 실패했을 때 뜨는 알림창, 뒤로가기 
		out.println("<Script>");
		out.println("alert('삭제되지 않았습니다.');");
		out.println("history.back();");
		out.println("</script>");
		return;
}%>
		
	</script>
</body>
</html>