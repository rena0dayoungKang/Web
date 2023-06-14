<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*, java.net.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="kr.ac.kopo.ctc.kopo01.dao.*" %>
<%@ page import="kr.ac.kopo.ctc.kopo01.domain.*" %>
<%@ page import="kr.ac.kopo.ctc.kopo01.dto.*" %>
<%@ page import="kr.ac.kopo.ctc.kopo01.service.*" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>재고 수정</title>
<style>
   table {
       width: 100%;
       border-collapse: collapse;
       background-color: #f8f8f8;
       border: 1px solid #ddd;
       font-family: Arial, sans-serif;
   }

   th, td {
       padding: 10px;
       text-align: center;
       border: 1px solid #ddd;
   }

   th {
       background-color: #f2f2f2;
       color: #333;
   }

   h1 {
       text-align: center;
       font-family: "Arial Black", sans-serif;
       color: #333;
       margin-top: 20px;
   }
</style>
<%
	//날짜 표시를 위해 java.util date가져오기 
	java.util.Date currentDate = new java.util.Date();
	java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
</head>
<body>
	<h1>(주)트와이스 재고 현황 - 재고 수정</h1>
<%
	long id = Long.parseLong(request.getParameter("id")); //list에서 id 받아오기 
	InventoryDao inventoryDao = new InventoryDaoImpl();  //객체 생성
	InventoryItem inventoryItem = inventoryDao.showOne(id);  //showOne 메소드 호출
	
	if (inventoryItem != null) {
%>
	<!-- 상품 상세 정보 테이블 생성 -->
	<form method='post'>
	<table>
		<tr>
			<td style="width:20%;">상품번호</td>
			<td><%=inventoryItem.getId() %></td>
		</tr>
		<tr>
			<td>상품명</td>
			<td><%=inventoryItem.getName() %></td>
		</tr>
		<tr>
			<td>재고 수량</td>
			<td><input type="number" name="stock" min="0" max="10000" value="<%=inventoryItem.getStock() %>" required></td>
		</tr>
		<tr>
			<td>상품 등록일</td>
			<td><%=inventoryItem.getRegiDate() %></td>
		</tr>
		<tr>
			<td>재고 조사</td>
			<td><input type="text" name="regiDateQ" value="<%=sdf2.format(new java.util.Date())%>" readonly></td>
		</tr>
		<tr>
			<td>상품 설명</td>
			<td><%=inventoryItem.getContext() %></td>
		</tr>
		<tr>
			<td>상품 사진</td>
			<td style="width: 100px; text-align: center; vertical-align: middle;">
			<img src=./image/<%=inventoryItem.getLink() %> onError="this.style.visibility='hidden'" style="max-width: 100%; max-height: 100%;">
			</td>
		</tr>
		<tr>
			<td>등록직원번호</td>
			<td><%=inventoryItem.getUserId()%></td>
		</tr>
		<tr>
			<td colspan=2 style="text-align: right;">
			<input type="button" value="목록" onclick="location.href='inven_list.jsp'" > <!-- 목록으로 돌아가기 -->
			<input type="submit" value="저장" formaction="inven_writeQ.jsp?id=<%=inventoryItem.getId()%>"> <!-- 작성한 글 저장하기 -->
			</td>
		</tr>
	</table>
	</form>
	<%
	} else {
	%> 
	
	<%
	}
%>	
</body>
</html>