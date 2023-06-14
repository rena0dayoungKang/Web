<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page
	import="java.sql.*, javax.sql.*, java.io.*, java.util.*, java.net.*"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<%
try {
	int searchid = Integer.parseInt(request.getParameter("searchid"));// searchid 파라미터 값을 가져옴
} catch (NumberFormatException e) {
	out.println("<Script>");
	out.println("alert('잘못된 입력입니다.');");// 잘못된 입력 경고 메시지 출력
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

<title>show REC</title>
<script>
// 특수문자 입력 방지
function characterCheck(obj){
var regExp = /[ \{\} \[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi; 
// 허용할 특수문자는 여기서 삭제하면 됨
// 띄어쓰기도 특수문자 처리됨
if( regExp.test(obj.value) ){
	alert("특수문자는 입력하실수 없습니다.");
	obj.value = null;
}
}
</script>
</head>
<body>
	<%
try {
	Class.forName("com.mysql.cj.jdbc.Driver");//드라이버호출
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo", "root", "kopo0622");// DB 연결
	Statement stmt = conn.createStatement(); // SQL 쿼리 실행을 위한 객체 생성

	String name = "", stu_id = "", kor = "", eng = "", mat = "";

	String ctmp = request.getParameter("searchid");// searchid 매개변수의 값 가져옴
	if (ctmp == null || ctmp.trim().isEmpty()) { // searchid 값이 null이거나 공백일 경우
		ctmp = "0";// ctmp 값을 "0"으로 설정
		return;
	}
	if (ctmp.length() == 0)// searchid 길이가 0이라면 ctmp 값을 "0"으로 설정
		ctmp = "0"; 
	ResultSet rset = stmt.executeQuery("select * from examtable where stu_id = " + ctmp);
	// examtable에서 stu_id가 ctmp인 데이터를 조회하는 쿼리를 실행하고 결과를 ResultSet에 저장
	
	

	stu_id = "No student id exists"; // 학생 ID가 존재하지 않을 경우
	while (rset.next()) {
		name = rset.getString(1);
		stu_id = Integer.toString(rset.getInt(2));
		kor = Integer.toString(rset.getInt(3));
		eng = Integer.toString(rset.getInt(4));
		mat = Integer.toString(rset.getInt(5));
	}

	stmt.close(); //statement객체 닫기
	conn.close(); //데이터베이스 연결 닫기 
	%>
	<h1>Update / Delete Score</h1>
	<hr>

	<form method='post' action='showREC.jsp'><!-- 데이터 조회를 위한 폼 생성 -->
		<table cellspacing=1 width=400 border=0><!-- 테이블 생성 -->
			<tr>
				<td width=100><p align=center>Student ID</p></td><!-- 학생 ID 입력란 -->
				<td width=200><p align=center><input type='text' name='searchid' value=''></input></p></td>
				<td width=100><input type="submit" value = 'SEARCH'></input></td><!-- 조회 버튼 -->
			</tr>
		</table>
	</form>
	<form method='post' name='myform'><!-- 학생 정보 수정/삭제를 위한 폼 생성 -->
		<table><!-- 테이블 생성 -->
			<tr>
				<td width=100><p align=center>Name</p></td><!-- 이름 입력란 -->
				<td width=300><p align=center>
						<input type='text' name='name' value='<%=name%>' maxlength="6" 
						onkeyup="characterCheck(this)" onkeydown="characterCheck(this)" required></input>
					</p></td>
			</tr>
			<tr>
				<td width=100><p align=center>Student ID</p></td>
				<td width=300><p align=center>
						<input type='stu_id' name='stu_id' value='<%=stu_id%>' readonly></input>
						<!-- 학생 ID (읽기 전용) -->
					</p></td>
			</tr>
			<tr>
				<td width=100><p align=center>Korean Score</p></td>
				<td><input type="text" pattern="^(?:100|[1-9][0-9]?|0)$"
					name="kor" value='<%=kor%>' title="0에서 100사이 숫자를 입력하세요." required></td>
					<!-- 국어 점수 입력란 패턴 : 입력 값이 0에서 100 사이의 숫자인지 확인하는 역할-->
			</tr>
			<tr>
				<td width=100><p align=center>English Score</p></td>
				<td><input type="text" pattern="^(?:100|[1-9][0-9]?|0)$"
					name="eng" value='<%=eng%>' title="0에서 100사이 숫자를 입력하세요." required></td>
					<!-- 영어 점수 입력란 패턴 : 입력 값이 0에서 100 사이의 숫자인지 확인하는 역할-->
			</tr>
			<tr>
				<td width=100><p align=center>Math Score</p></td>
				<td><input type="text" pattern="^(?:100|[1-9][0-9]?|0)$"
					name="mat" value='<%=mat%>' title="0에서 100사이 숫자를 입력하세요." required></td>
					<!-- 수학 점수 입력란, 패턴 : 입력 값이 0에서 100 사이의 숫자인지 확인하는 역할, required는 빈 값이 제출될 수 없게만든다-->
			</tr>
		</table>
		<%
   if (stu_id.length() != 0) { 
%>
		<table><!-- 수정/삭제 버튼을 위한 테이블 생성 -->
			<tr>
				<td colspan="2" style="width: 80%"></td>
				<td style="text-align: left;"><input type="submit" value="수정"
					onclick="javascript: form.action='updateDB.jsp';" /></td><!-- 수정 버튼 -->
				<td style="text-align: left;"><input type="submit" value="삭제"
					onclick="javascript: form.action='deleteDB.jsp';" /></td><!-- 삭제 버튼 -->
			</tr>
		</table>
		<%
   }
%>
	</form>
<%
	} catch(Exception e) { //테이블 값 조회 실패 시 알림창, 뒤로가기 
	out.println("<Script>");
	out.println("alert('테이블 값 조회 실패.');");
	out.println("history.back();");
	out.println("</script>");
	return;
	}
%>
</body>
</html>

