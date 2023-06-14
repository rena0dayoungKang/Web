<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page
	import="java.sql.*, javax.sql.*, java.io.*, java.util.*, java.net.*"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="kr.ac.kopo.ctc.kopo01.dao.*"%>
<%@page import="kr.ac.kopo.ctc.kopo01.domain.*"%>
<%@page import="kr.ac.kopo.ctc.kopo01.dto.*"%>
<%@page import="kr.ac.kopo.ctc.kopo01.service.*"%>
<%
String name = request.getParameter("name"); // name 파라미터 값을 가져옴
Integer kor = null;
Integer eng = null;
Integer mat = null;

try {
	kor = Integer.parseInt(request.getParameter("kor"));// "kor" 파라미터 값을 정수로 변환
	eng = Integer.parseInt(request.getParameter("eng"));// "eng" 파라미터 값을 정수로 변환
	mat = Integer.parseInt(request.getParameter("mat"));// "mat" 파라미터 값을 정수로 변환
} catch (NumberFormatException e) {
	out.println("<Script>");
	out.println("alert('빈칸이 있습니다.');");// 잘못된 입력 경고 메시지 출력
	out.println("history.back();");// 이전 페이지로 이동
	out.println("</script>");
	return;
}

if (name == null || name.trim().isEmpty()) {
	out.println("<script>");
	out.println("alert('빈칸이 있습니다.');"); // 잘못된 입력 경고 메시지 출력
	out.println("history.back();");// 이전 페이지로 이동
	out.println("</script>");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Add Student Score</title>
<script>
	function removeString(input) {
		input.value = input.value.replace(/[^\d]/g , '');
	}
	//add score할때 이름이나, 점수가 하나라도 안들어가면 추가가 안되게 막기
	//input.value에서 [^\d] 정규 표현식을 사용하여 숫자가 아닌 모든 문자를 찾아서 빈 문자열로 대체하여 제거
</script>
</head>
<body>
	<%		
		StudentItemDao studentItemDao = new StudentItemDaoImpl();
		Class.forName("com.mysql.cj.jdbc.Driver");//객체생성
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo", "root", "kopo0622");// DB 연결
		Statement stmt = conn.createStatement(); // SQL 쿼리 실행을 위한 객체 생성
		ResultSet rset = stmt.executeQuery("select stu_id from examtable"); //학번 중 번호 찾기 
		
		//209900부터 1씩 증가하면서 새로운 학생의 학번을 부여할 수 있다. 
		int StartID = 209900;
		int NewStu_id = 209901;

		while (rset.next()) {
			StartID++;
			if (NewStu_id != rset.getInt(1)) {
		NewStu_id = StartID;
		break;
			} else {
		NewStu_id = StartID + 1;
			}
		}

		String cTmp = request.getParameter("name");// 요청 파라미터에서 'name' 값을 가져와 문자열 변수 cTmp에 저장
		stmt.execute("insert into examtable (name, stu_id, kor, eng, mat) values ('" + cTmp + "',"
		+ Integer.toString(NewStu_id) + "," + request.getParameter("kor") + "," + request.getParameter("eng") + ","
		+ request.getParameter("mat") + ");");// examtable에 새로운 레코드를 삽입하는 SQL 쿼리 실행
	%>
	<h1>ADD Student Score Complete!</h1><br>
	<form method='post' action='inputForm1.html'>
		<!-- POST 메소드로 inputForm1.html로 데이터 전송하는 폼 생성 -->
		<table cellspacing=1 width=400 border=0>
			<!-- 테이블 생성 -->
			<tr>
				<td width=300></td>
				<td width=100><input type="submit" value="BACK"></input></td>
				<!-- "BACK"이라는 값의 제출 버튼 생성 -->
			</tr>
		</table>

		<table cellspacing=1 width=400 border=1>
			<!-- 테이블 생성 -->
			<tr>
				<td width=100><p align=center>Name</p></td>
				<!-- "Name"이라는 값의 가운데 정렬된 셀 -->
				<td width=300><p align=center>
						<input type='text' name='name' value='<%=cTmp%>' readonly>
						<!-- "name"이라는 이름의 읽기 전용 텍스트 필드, 값은 cTmp 변수의 값 -->
					</p></td>
			</tr>

			<tr>
				<td width=100><p align=center>Student ID</p></td>
				<!-- "Student ID"라는 값의 가운데 정렬된 셀 -->
				<td width=300><p align=center>
						<input type='text' name='stu_id'
							value='<%=Integer.toString(NewStu_id)%>' readonly>
						<!-- "stu_id"라는 이름의 읽기 전용 텍스트 필드, 값은 NewStu_id 변수의 값 -->
					</p></td>
			</tr>
			<tr>
				<td width=100><p align=center>Korean Score</p></td>
				<!-- "Korean Score"라는 값의 가운데 정렬된 셀 -->
				<td width=300><p align=center>
						<input type='number' name='kor'
							value='<%=request.getParameter("kor")%>'
							oninput="removeString(this)" readonly>
						<!-- "kor"이라는 이름의 읽기 전용 숫자 입력 필드, 값은 request.getParameter("kor")의 값 -->
					</p></td>
			</tr>
			<tr>
				<td width=100><p align=center>English Score</p></td>
				<td width=300><p align=center>
						<input type='number' name='eng'
							value='<%=request.getParameter("eng")%>'
							oninput="removeString(this)" readonly>
						<!-- "eng"이라는 이름의 읽기 전용 숫자 입력 필드, 값은 request.getParameter("eng")의 값 -->
					</p></td>
			</tr>
			<tr>
				<td width=100><p align=center>Math Score</p></td>
				<td width=300><p align=center>
						<input type='number' name='mat'
							value='<%=request.getParameter("mat")%>'
							oninput="removeString(this)" readonly>
						<!-- "mat"이라는 이름의 읽기 전용 숫자 입력 필드, 값은 request.getParameter("mat")의 값 -->
					</p></td>
			</tr>
		</table>
	</form>


</body>
</html>


