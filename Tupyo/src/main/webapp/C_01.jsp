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
<title>개표 결과 C01</title>
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

.none {
	text-align: center;
	background-color: #eee;
	padding: 10px;
	margin: 0;
}

.none p {
	color : black;
	font-size : 16px;
	text-decoration : underline;
	
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

	<h1>후보별 득표 결과</h1>

	<%
	Class.forName("com.mysql.cj.jdbc.Driver");//객체생성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo", "root", "kopo0622");// DB 연결
	Statement stmt = conn.createStatement(); // SQL 쿼리 실행을 위한 객체 생성
	ResultSet rset = stmt.executeQuery("SELECT hubo.kiho, hubo.name, IFNULL(count(a.kiho), 0) AS count, " +
	        "IFNULL(ROUND(count(a.kiho) / total_count * 100, 1), 0) AS vote_percentage " +
	        "FROM hubo LEFT JOIN tupyo AS a ON hubo.kiho = a.kiho " +
	        "CROSS JOIN (SELECT COUNT(kiho) AS total_count FROM tupyo) AS total_votes " +
	        "GROUP BY hubo.kiho, hubo.name, total_count;"); 
			//hubo테이블과 tupyo테이블을 조인하다, kiho와 name 열과 함께 kiho의 갯수를 세고, 갯수가 존재하지 않으면 0으로 대체 ifnull
			//count 를 total_count로 나누고 그 결과를 백분율 형태로 변환하여 소숫점 첫째자리까지 표현한다. 
			//kiho, name, total_count를 기준으로 그룹화한다. 

	%>
	<div>
		<table class="container" cellspacing=3, width=600 border=1>
			<tr>
				<td width=100><p>이름</p></td>
				<td><p>인기도</p></td>
			</tr>
			
			<form method="post" action="C_02.jsp">
			<%
			while (rset.next()) { %>
				<tr>
					<td><a href="C_02.jsp?selectOne=<%= rset.getInt(1) %>" style="width: 50px;" name="selectOne">
					<%=rset.getInt(1)%>.<%= rset.getString(2) %></a></td>
					<!-- 후보의 이름을 선택 시 개인별 득표율로 이동할 수 있도록 -->
					<td>
						<% if (rset.getInt(3) != 0) { %> <!-- 득표수가 0이 아니라면  -->
							<div style="display: flex; align-items: center;">
							<p style="background-color: #323287; width: <%=rset.getDouble(4)%>%; margin: 0; color: #323287;">
							<%=rset.getInt(3)%></p><!-- 득표율 만큼 막대그래프 형식으로 나타내기  -->
							<span style="margin-left: 10px;"><%=rset.getInt(3)%>(<%=rset.getDouble(4)%>%)</span>
							<!-- 득표율 만큼 막대그래프 형식으로 나타내기  -->
							</div>
						<% } else if (rset.getInt(3) == 0) {%>  <!-- 득표수가 0이라면  -->
							<div style="text-align:left">
							<span style="margin-left: 10px;"><%=rset.getInt(3)%>(<%=rset.getDouble(4)%>%)</span>
							</div> <!-- 0이라는 숫자와 0.0% 글자로 출력 -->
						<% } %>
					</td>
				</tr>
				
			</form>
			<%
			}
			%>
		</table>
	</div>
</body>
</html>