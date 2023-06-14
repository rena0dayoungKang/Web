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
<title>상품 상세</title>
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
</head>
<body>
<%
	long id = Long.parseLong(request.getParameter("id")); //list에서 id 받아오기 
	InventoryDao inventoryDao = new InventoryDaoImpl();  //객체 생성
	InventoryItem inventoryItem = inventoryDao.showOne(id);  //showOne 메소드 호출
	
	%>
	<!-- 상품 상세 정보 테이블 생성 -->
	<form method='post'>
	<h1>(주)트와이스 재고 현황 - 상품 상세</h1>
	<table>
		<tr>
			<td  style="width:20%;">상품번호</td>
			<td><%=inventoryItem.getId() %></td>
		</tr>
		<tr>
			<td>상품명</td>
			<td><%=inventoryItem.getName() %></td>
		</tr>
		<tr>
			<td>재고 수량</td>
			<td><%=inventoryItem.getStock() %></td>
		</tr>
		<tr>
			<td>상품 등록일</td>
			<td><%=inventoryItem.getRegiDate() %></td>
		</tr>
		<tr>
			<td>재고 조사일</td>
			<td><%=inventoryItem.getRegiDateQ() %></td>
		</tr>
		<tr>
			<td>상품 설명</td>
			<td><textarea readonly style="width:100%; height:200px; resize:none; border:1px solid black;"><%=inventoryItem.getContext() %></textarea></td>
		</tr>
		<tr>
			<td>상품 사진</td>
			<td style="width: 100px; text-align: center; vertical-align: middle;"> <!-- 상품사진 이미지 td태그 안에 밖으로 나가지 않게 넣기  -->
			<img src=./image/<%=inventoryItem.getLink() %> onError="this.style.visibility='hidden'" style="max-width: 100%; max-height: 100%;"> 
			<!-- 이미지가 없을 시 보이지 않도록 히든 처리-->
			</td>
		</tr>
		<tr>
			<td>등록직원번호</td>
			<td><%=inventoryItem.getUserId() %></td>
		</tr>
	</table>
	<table>
		<tr>
			<td colspan =2 style="text-align: right;">
				<input type="button" value="목록" OnClick="location.href='inven_list.jsp'"> <!-- 목록버튼은 list로 다시 돌아간다 -->
				<input type="submit" value="재고수정" formaction="inven_updateQ.jsp?id=<%=inventoryItem.getId() %>"> <!-- 재고수정 버튼은 updateQ.jsp로 이동한다. -->
				<input type="submit" value="삭제" formaction="inven_delete.jsp?id=<%=inventoryItem.getId()%>"> <!-- 삭제 버튼은 delete.jsp로 이동한다. -->
			</td>
		</tr>
	</table>
	</form>
	<%
%>
	

</body>
</html>