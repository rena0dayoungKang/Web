<%--examtable�� �����͸� insert�ϴ� jsp����--%>
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
	function showResult() {  //div�� result�� ����ٰ� 2�� �Ŀ� ���̵��� �ϴ� ���
		var resultDiv = document.getElementById("result");
		resultDiv.style.display = "none";
		setTimeout(function() {
			resultDiv.style.display = "block";
		}, 1000);
	} //showResult()�޼ҵ尡 ȣ�� �� �� div id ="result" �� ������ 2�ʰ� �������� �ٽ� ��Ÿ���� �ȴ�. 
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
   //StudentItemDao �������̽��� ������ StudentItemDaoImpl ��ü�� ����
   int result = studentItemDao.insert();
   //studentItemDao �ִ� ���̺� ���� �޼��� ȣ��
   %>
   <div id="result">
   <%
   if(result == 1){ %>
   		<h1>Insert Score Complete</h1> <!-- ������ ���� ���� ��  -->
   <% } else { %>
   		<h1>Insert Score Fail</h1> <!-- ������ ���� ���� �� -->
   <% } %>
   </div>
</body>
</html>