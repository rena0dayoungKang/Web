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
<%@ page import="java.io.File"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%!
	//사용자가 입력한 특수 기호 중, 주석 처리가 가능한 기호들을 대체하기 
	private String escapeHtml(String unsafeInput) {
		return String.valueOf(unsafeInput)
		.replace("&", "&amp;")
		.replace("<", "&lt;")
		.replace(">", "&gt;")
		.replace("'", "&#039;");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>상품 등록 상세페이지 </title>
<style>
    table {
        width: 600ㅔpx;
        border-collapse: collapse;
        background-color: #f8f8f8;
        border: 1px solid #ddd;
        font-family: Arial, sans-serif;
    }

    th, td {
        padding: 10px;
        text-align: left;
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
<%
	long id = 0;
	String name = "";
	int stock = 0;
	String regiDate = "";
	String regiDateQ = "";
	String context = "";
	String link = "";
	int userId = 0;
	
	String path = "/image";  //저장하는 폴더 위치 
	String savePath = request.getServletContext().getRealPath(path); //컴퓨터 저장 위치 
	int maxSize = 1024 * 1024 * 1024; //maxSize가 초과하면 예외가 발생 
	String encodingType = "utf-8"; //utf-8로 인코딩 
	MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, encodingType, new DefaultFileRenamePolicy());
	
	id = Long.parseLong(multi.getParameter("id")); //id 작성
	name = escapeHtml(multi.getParameter("name")); //상품명작성
	stock = Integer.parseInt(multi.getParameter("stock")); //재고
	regiDate = multi.getParameter("regiDate"); //상품등록일
	regiDateQ = multi.getParameter("regiDateQ"); //재고조사일
	context = escapeHtml(multi.getParameter("context")); //상품설명
	link = multi.getFilesystemName("link"); //상품이미지 이름을 저장 
	userId = Integer.parseInt(multi.getParameter("userId")); //등록자	

%>
<body>
	<h1>(주)트와이스 재고 현황 - 상품 등록 상세페이지</h1>
<%	

	InventoryDao inventoryDao = new InventoryDaoImpl();  //객체생성
	boolean idExist = inventoryDao.idExist(id);         //이미 있는 상품번호를 체크하기 
	if (idExist) {
		out.println("동일한 상품번호의 상품이 존재합니다");
	} else {
		inventoryDao.writeData(id, name, stock, context, link, userId); //동일한 상품번호가 없다면 write하기 
	}
	%>
	
	<p style="text-align:center;">페이지로 돌아가는 중입니다...</p>
	<script>
		function goBack() {
			location.href = "inven_list.jsp"; //inven_list.jsp페이지로 돌아간다.
		}
		// 페이지 로드 후 자동으로 goBack() 함수 호출
		window.onload = function() {
			setTimeout(goBack, 1000); //페이지 로드 후 1초의 시간을 두고 뒤로 돌아간다. 
		};
	</script>
</body>
</html>