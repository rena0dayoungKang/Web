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
<title>투표 하기 B01</title>
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
	<h1>투표하기</h1>

	<%
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");//드라이버 호출 
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo", "root", "kopo0622");// DB 연결
		Statement stmt = conn.createStatement(); // SQL 쿼리 실행을 위한 객체 생성
		ResultSet rset = stmt.executeQuery("select * from kopo.hubo;");
		
		int kiho = 0;
		String name = "";
		
		boolean hasData = false; //데이터가 있는지 확인하는 hasData 선언 false를 기본값으로 설정함. 
	%>
	<div
		style="display: flex; justify-content: center; align-items: center;">
		<table>
			<tr>
				<form method="post" action="B_02.jsp">
					<td><p align=center>
							<select name="choice" style="width: 100px; text-align: center;">
						<%
							while(rset.next()) {
								kiho = rset.getInt(1); //후보테이블에서 kiho를 가져온다
								name = rset.getString(2);//테이블에서 name을 가져온다.
								hasData = true; //가져오는 데이터가 있다면 hasData를 true로 변경. 
						%>
								<option value=<%=kiho%>><span><%=kiho %> <%=name %></span></option> 
								<!-- 후보 선택하는 옵션 창  -->
						<%
							}							
							if (!hasData){ //후보를 다 삭제하거나 후보 데이터가 없을때, 
								%>
								<option value="후보가 없습니다." selectd>후보가 없습니다.</option> 
								<!-- 선택 옵션 창에 텍스트 출력  -->
								<%
							}
								%>
							</select> <input type="hidden" name="tupyokiho" value=""> 
						</p></td>
					<td></td>
					<td><p align=center>
							<select name="age" style="width: 100px; text-align: center;"> 
							<!-- 투표자의 연령대 선택하는 옵션  -->
								<option value=1><span>10대</span></option>
								<option value=2><span>20대</span></option>
								<option value=3><span>30대</span></option>
								<option value=4><span>40대</span></option>
								<option value=5><span>50대</span></option>
								<option value=6><span>60대</span></option>
								<option value=7><span>70대</span></option>
								<option value=8><span>80대</span></option>
								<option value=9><span>90대</span></option>
							</select>
						</p></td>
					<td><input type="submit" value="투표하기" <%if (!hasData) { %> disabled <%} %>></td> 
					<!-- 후보 데이터가 없으면 선택하는 버튼을 비활성화시킨다 -->
					<td></td>
				</form>
			</tr>
		</table>
	</div>
	<%
	} catch (Exception e) { //투표 중 오류가 발생시, 알림창, 뒤로가기 
		e.printStackTrace();
		out.println("<Script>");
		out.println("alert('투표 중 오류가 발생하였습니다.');");
		out.println("history.back();");
		out.println("</script>");
		return;
	}
	%>
</body>
</html>