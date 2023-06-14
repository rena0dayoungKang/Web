<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page
	import="java.sql.*, javax.sql.*, java.io.*, java.util.*, java.net.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>투표 시스템</title>
<script>
// 특수문자 입력 방지
function characterCheck(obj){
var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi; 
// 허용할 특수문자는 여기서 삭제하면 됨
// 지금은 띄어쓰기도 특수문자 처리됨 참고하셈
if( regExp.test(obj.value) ){
	alert("특수문자는 입력하실수 없습니다.");
	obj.value = null;
}
}
</script>
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


	<div class="table-container">
		<table>
			<%
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");//드라이버호출
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo", "root", "kopo0622");// DB 연결
				Statement stmt = conn.createStatement();// SQL 쿼리 실행을 위한 객체 생성
				ResultSet rset = stmt.executeQuery("select * from kopo.hubo;");// SQL 쿼리 실행

				List<Integer> list = new ArrayList<>();

				int kiho = 0;
				String name = "";
				while (rset.next()) {
					kiho = rset.getInt(1); //테이블에서 1열 kiho번호 가져오기 
					list.add(kiho); //kiho를 list에 추가하기 
					name = rset.getString(2); //테이블에서 2열 name가져오기 
			%>
			<tr>
				<form method="post" action="A_02.jsp">
					<td>기호 번호</td>
					<td style="background-color: #f4f4fb;"><%=kiho%></td> <!-- 기호번호 입력하기  -->
					<td>후보명</td>
					<td style="background-color: #f4f4fb;"><%=name%></td> <!-- 이름 입력하기  -->
					<td>
					<input type="hidden" name="deletekiho" value="<%=kiho%>"> <!-- 후보삭제 버튼의 value값을 kiho번호로 받기  -->
					<input type="submit" value="후보 삭제"> <!-- 후보삭제 버튼 -->
					</td>
				</form>
			</tr>
			<%
			}
			%>
			<tr>
				<form method="post" action="A_03.jsp">
				<td>기호 번호</td>
				<td><p align=center> 자동
						<input type='hidden' name='newKiho' min='0' max='100' placeholder='자동' min='1' max='100' 
						style='width: 40px;' required></input>
						<!-- 기호번호입력하는 창, 1부터 100까지의 숫자만 들어가는데, 자동으로 번호가 부여되므로 타입을 히든으로 했음   -->
					</p></td>
				<td>후보명</td>
				<td><p align=center>
						<input type='text' name='newName' value='' style='width: 100px;'
							maxlength="6" onkeyup="characterCheck(this)" onkeydown="characterCheck(this)" required></input>
							<!-- 후보 입력하는 창, 6글자 이상은 안들어가게 했고, 특수기호는 입력할 수 없게 하였다.  -->
					</p></td>
				<td><input type="submit" value="후보 등록"></td>
				</form>
			</tr>


		</table>
		<%
		rset.close();
		stmt.close();
		conn.close();
		} catch (Exception e) { //후보 등록 실패 시 알림창이 뜨고 뒤로가기 
		out.println("<Script>");
		out.println("alert('등록 실패.');");
		out.println("history.back();");
		out.println("</script>");
		return;
		}
		%>
	</div>

</body>
</html>