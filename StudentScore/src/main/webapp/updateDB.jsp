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
<title>Update Score</title>
<style>
body {
    display: flex;
    align-items: baseline;
    justify-content: center;
}
</style>
</head>
<body>
	<h1>Update / Delete Student Score</h1>
	<hr>
	<%	
try {
	Class.forName("com.mysql.cj.jdbc.Driver");//드라이버호출
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo", "root", "kopo0622");// DB 연결
	Statement stmt = conn.createStatement();// SQL 쿼리 실행을 위한 객체 생성
	
	String cTmp =  request.getParameter("name"); //name이라는 파라미터를 cTmp변수에 저장 
	
	//examtable의 db에 새로운 정보를 업데이트하기 
	String sql = " update examtable set " +   
			"name = '" + cTmp + "', " +
			"kor = " + request.getParameter("kor") + ", " +
			"eng = " + request.getParameter("eng") + ", " +
			"mat = " + request.getParameter("mat") + 
			" where stu_id = "+ request.getParameter("stu_id");
		stmt.executeUpdate(sql);
		ResultSet rset = stmt.executeQuery("select * from examtable;");
%>
	<table cellspacing=1 width=600 border=1>
		<tr>
			<td width=50><p align=center>Name</p></td> <!-- 이름  -->
			<td width=50><p align=center>Student ID</p></td> <!-- 학번 -->
			<td width=50><p align=center>Korean Score</p></td> <!-- 국어점수 -->
			<td width=50><p align=center>English Score</p></td> <!-- 영어점수 -->
			<td width=50><p align=center>Math Score</p></td> <!-- 수학점수 -->
		</tr>
		<%
	while (rset.next()) { 
		if (request.getParameter("stu_id").equals(Integer.toString(rset.getInt(2)))) {//학번으로 받아오는 아이디가 새로 업데이트 된 학생이면 
			out.println("<tr bgcolor = #ffff00' >"); //배경색을 노란색으로 변경하여서 구분할 수 있게 한다. 
			out.println("<td width=50><p align=center><a href='oneview.jsp?stu_id="+rset.getInt(2)+"'> "+rset.getString(1)+"</a></p></td>");
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(2))+"</p></td>"); //학번
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(3))+"</p></td>"); //국어
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(4))+"</p></td>"); //영어
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(5))+"</p></td>"); //수학
			out.println("</tr>");
		} else {  
			out.println("<tr>");  //업데이트 된 학생이 아닌 경우는 일반적인 테이블로 출력하게 한다. 
			out.println("<td width=50><p align=center><a href='oneview.jsp?stu_id="+rset.getInt(2)+"'> "+rset.getString(1)+"</a></p></td>");
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(2))+"</p></td>"); //학번
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(3))+"</p></td>"); //국어
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(4))+"</p></td>"); //영어
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(5))+"</p></td>"); //수학
			out.println("</tr>");
		}
	}
	rset.close();
	stmt.close();
	conn.close();
} catch (Exception e) { //테이블 업데이트 실패 시 뜨는 알림, 뒤로가기 
	out.println("<Script>");
	out.println("alert('테이블 값 수정 실패.');");
	out.println("history.back();");
	out.println("</script>");
	return;
}
%>
	</table>
</body>
</html>