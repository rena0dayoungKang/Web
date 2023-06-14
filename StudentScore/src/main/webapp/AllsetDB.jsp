<%--examtable에 데이터를 insert하는 jsp파일--%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="kr.ac.kopo.ctc.kopo01.dao.*"%>
<%@ page import="kr.ac.kopo.ctc.kopo01.domain.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.io.*"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>insertTable</title>
<script>
	function showResult() {  //div의 result를 숨겼다가 2초 후에 보이도록 하는 기능
		var resultDiv = document.getElementById("result");
		resultDiv.style.display = "none";
		setTimeout(function() {
			resultDiv.style.display = "block";
		}, 1000);
	} //showResult()메소드가 호출 될 때 div id ="result" 의 내용이 2초간 숨겨지고 다시 나타나게 된다. 
</script>
<style>
body {
	display: flex;  
	align-items: center;
	justify-content: center;
	height: 100vh;
	margin: 0;
}

.center-element {
	margin: 0 auto;
	text-align: center;

</style>
</head>
<body onload="showResult()">
   <h1>please wait...</h1><br>  
   
   
   <%
   StudentItemDao studentItemDao = new StudentItemDaoImpl(); 
   //StudentItemDao 인터페이스를 구현한 StudentItemDaoImpl 객체를 생성
   int result = studentItemDao.insert();
   //studentItemDao 있는 테이블 생성 메서드 호출
   %>
   <div id="result">
   <%
   if(result == 1){ %>
   		<h1>Insert Score Complete</h1> <!-- 데이터 삽입 성공 시  -->
   <% } else { %>
   		<h1>Insert Score Fail</h1> <!-- 데이터 삽입 실패 시 -->
   <% } %>
   </div>
</body>
</html>