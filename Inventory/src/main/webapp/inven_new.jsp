<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page
	import="java.sql.*, javax.sql.*, java.io.*, java.util.*, java.net.*"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%@ page import="kr.ac.kopo.ctc.kopo01.dao.*"%>
<%@ page import="kr.ac.kopo.ctc.kopo01.domain.*"%>
<%@ page import="kr.ac.kopo.ctc.kopo01.dto.*"%>
<%@ page import="kr.ac.kopo.ctc.kopo01.service.*"%>
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
<title>상품 등록</title>
<script>

	//상품 번호를 입력하는 곳을 13자리로 제한하는 함수
	function checkProductNumber(event) {
		const inputNumber = event.target;
		if (inputNumber.value.length > 13) { // 입력된 값의 길이가 13을 초과하는지 확인
			alert("상품 번호 입력이 13자리를 넘을 수 없습니다.");
			inputNumber.value = inputNumber.value.slice(0, 13);
			// 입력된 값을 13자리까지 잘라서 설정
		}
	}

	//내용 적는 textarea 디폴트 글자를 반투명하게 하고, 사용자가 글을 바로 적을 수 있도록 함
	function checkInput(element) {
		if (element.value !== "") {// 만약 element의 값이 비어있지 않다면(값이 존재한다면),
			element.classList.remove("input-field");
			// element의 class 목록에서 "input-field" 클래스를 제거
		} else {
			element.classList.add("input-field");
			// element의 class 목록에 "input-field" 클래스를 추가
		}
	}
	
	//제목에 공백을 없애기, 공백만 입력되는 경우에는 alert창을 띄움
	function validateInput() {
		const inputField = document.getElementById("title"); 
		// id가 "title"인 요소를 가져와 inputField 변수에 할당
		const contentField = document.querySelector('textarea[name="content"]');
		// name 속성이 "content"인 textarea 요소를 가져와 contentField 변수에 할당
		const titleValue = inputField.value.trim();
		// inputField의 값에서 양쪽 공백을 제거한 후 titleValue 변수에 할당
		
		if (titleValue === ""){  // 만약 titleValue가 비어있다면
			alert("제목을 입력해 주세요"); //경고창을 표시
			return false;
		} 
		return true;
	}

	// 사진 두번 클릭하여 사진 없애기 
	function deleteimg() {
	  var imgs = document.getElementById("image");
	  if (imgs != null) {
	    var thisisImage = document.getElementById("thisisImage");
	    thisisImage.remove();
	  }
	}

	//이미지 미리보기 & 확장자 지정하기 
	function setThumbnail(event) {
		const fileInput = event.target;
		// 이벤트에서 파일 입력 요소를 가져온다
		const file = event.target.files[0];
		// 이벤트에서 선택된 파일을 가져온다
		
		if(!file.type.match('image/jpeg') && !file.type.match('image/png')) {
			// 파일 타입이 JPEG 또는 PNG인지 확인
			alert("JPEG 또는 PNG 이미만 업로드해주세요.");
			fileInput.value = "";	// 파일 입력을 초기화
			var imageContainer = document.getElementById("image_container");
			while(imageContainer.firstChild) {
				imageContainer.removeChild(imageContainer.firstChild);
				// 이미지 컨테이너의 자식 요소를 모두 제거
			}
			return;
		}		
		
		var reader = new FileReader();// FileReader 객체를 생성
		reader.onload = function(event) {
			var img = document.createElement("img");// img 요소를 생성
			img.setAttribute("src", event.target.result);
			img.setAttribute("width", "400");
			img.setAttribute("height", "400");
			// img 요소의 속성을 설정합니다. (이미지 경로, 너비, 높이)
			var imageContainer = document.getElementById("image_container");
			var prevImage = imageContainer.querySelector("img");
			if (prevImage) {
				imageContainer.removeChild(prevImage);
			}
			imageContainer.appendChild(img);
			// 이미지 컨테이너에 img 요소를 추가
		};
		reader.readAsDataURL(file);
		// 선택된 파일을 데이터 URL로 읽어오기
	}
	
</script>
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
<%
//날짜 표시를 위해 java.util date가져오기 
java.util.Date currentDate = new java.util.Date();
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd"); //년도월일
java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm"); //년도월일 시간분
%>
</head>
<body>
	<h1>(주)트와이스 재고 현황 - 상품 등록</h1>
	<form action="inven_write.jsp" method='post' enctype="multipart/form-data" onsubmit="return validateInput()">
	<!-- 데이터에 첨부 파일이 포함되어 있을 때 사용되는 인코딩 유형을 지정, multipart/form-data를 사용하여 파일 업로드를 지원 -->
		<!-- 테이블 시작  -->
		<table width=650 border=1 cellsapcing=0 cellpadding=5>
			<tr>
				<td style="width:20%;">상품 번호</td>
				<!-- 상품 번호 입력  -->
				<td><input type="number" name="id" min="1" value="상품 번호"
					maxlength="13" oninput="checkProductNumber(event);"></td>
			</tr>
			<tr>
				<td>상품명</td>
				<!-- 상품명 필수 등록  -->
				<td><input type="text" id="title" name="name" required></td>
			</tr>
			<tr>
				<td>현재 재고 수량</td>
				<!-- 재고수량 입력 -->
				<td><input type="number" name="stock" min="0" max="1000000" value="" required></td>
			</tr>
			<tr>
				<td>상품 등록일</td>
				<!-- 시스템 상의 시간을 가져오기  -->
				<td><input type="text" name="regiDate"
					value="<%=sdf.format(new java.util.Date())%>" readonly></td>
			</tr>
			<tr>
				<td>재고 조사</td>
				<!-- 시스템 상의 시간을 가져오기  -->
				<td><input type="text" name="regiDateQ"
					value="<%=sdf2.format(new java.util.Date())%>" readonly></td>
			</tr>
			<tr>
				<td>상품 설명</td>
				<!-- 상품 설명 칸  textarea  -->
				<td><textarea name="context"
						style="width: 500px; height: 250px;" placeholder="상품설명을 입력해주세요"
						class="input-field"></textarea></td>
			</tr>
			<tr>
				<td>상품 사진</td>
				<td style="position: relative; overflow: hidden; width: 100px; height: 100px;"> <!-- 상품 사진 이미지를 td태그 안에 넣고, 테이블 밖으로 나가지 않도록 -->
					<input type="file" name="link" id="image" onError="this.style.visibility='hidden'"
					accept="image/png, image/jpeg" onchange="setThumbnail(event)" style="position: absolute; width: 100%; height: 100%;">
					<div id="image_container"></div>
				</td>
			</tr>
			<tr>
				<td>등록직원번호</td> 
				<td><input type="number" min=0 name="userId"
					onkeyup="characterCheck(this)" onkeydown="characterCheck(this)"	min="0" max="99999" required></td> 
			</tr>
			<tr>
				<td colspan=2 style="text-align: right;"><input type="button"
					value="목록" onclick="location.href='inven_list.jsp'"> <!-- 목록으로 돌아가기 -->
					<input type="submit" value="저장" >
					<!-- 작성한 글 저장하기 --></td>
			</tr>
		</table>
	</form>
</body>
</html>