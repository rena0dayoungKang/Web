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
<meta charset="EUC-KR">
<title>개표 결과 C02</title>
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
	color: black;
	font-size: 16px;
	text-decoration: underline;
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
	

	<form method='post' action='C_01.jsp'>
		<%
		String selectOne = request.getParameter("selectOne"); //기호번호
		//out.print(selectOne);
		
		Class.forName("com.mysql.cj.jdbc.Driver");//객체생성
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo", "root", "kopo0622");// DB 연결
		Statement stmt = conn.createStatement(); // SQL 쿼리 실행을 위한 객체 생성
		ResultSet rset2 = stmt.executeQuery("select * from kopo.hubo where kiho = " + selectOne + ";"); 
		rset2.next();
		
		//후보별 이름 출력하기 
		%>
		<h1><%=rset2.getString(2) %> 후보의 연령대별 득표율</h1>
		<table class="container" cellspacing=3, width=600 border=1>
		<tr>
			<td colspan=2><%=selectOne %>번 후보</td>
		</tr>
		<%
		for (int i = 1; i < 10; i++) {
			int age = i * 10; // i에 10을 곱해서 10대부터 90대까지 표기하기 
			//select round(count(*) / (select count(*) from tupyo where kiho = 5) * 100 , 1) , count(*) from tupyo where kiho = 5 and age= 1;
			ResultSet rset = stmt.executeQuery("select round(count(*) / (select count(*) from tupyo where kiho = " + selectOne + " ) * 100 , 1) , " +
					"count(*) from tupyo where kiho = " + selectOne + " and age= " + i + ";"); //쿼리문에서 기호번호에 해당하는 age 의 count 을 나타내기 
			
			if (rset.next()) {
				%>
				<tr>
					<td><%=age %>대</td>
					<td>
						<% if (rset.getInt(2) != 0) { %> <!-- count가 0이 아닌경우  -->
							<div style="display: flex; align-items: center;">
							<p style="background-color: #323287; width: <%=rset.getDouble(1)%>%; margin: 0; color: #323287;">
							<%=rset.getInt(2)%></p>
							<span style="margin-left: 10px;"><%=rset.getInt(2)%>(<%=rset.getDouble(1)%>%)</span>
							<!-- count비율만큼 그래프로 표시하기  -->
							</div>
						<% } else if (rset.getInt(2) == 0) {%> <!-- count가 0인 경우  -->
							<div style="text-align:left"><span style="margin-left: 10px;"><%=rset.getInt(2)%>
							(<%=rset.getDouble(1)%>%)</span></div> <!-- 0이라는 글자를 출력하기  -->
						<% } %>
					</td>
				</tr>
				<%
			}
		}		
		%>
		</table>
	</form>
</body>
</html>