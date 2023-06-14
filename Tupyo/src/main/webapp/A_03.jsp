<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
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
<title>�ĺ� ��� A03</title>
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
		<!-- ����� �޴� Ŭ�� -->
		<table>
			<tr>
				<td><a href="./A_01.jsp"><span>�ĺ����</span></a></td>
				<td><a href="./B_01.jsp"><span>��ǥ</span></a></td>
				<td><a href="./C_01.jsp"><span>��ǥ���</span></a></td>
			</tr>
		</table>
	</div>

	<%
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");//����̹� ȣ�� 
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo", "root", "kopo0622");// DB ����
		Statement stmt = conn.createStatement(); // SQL ���� ������ ���� ��ü ����
		ResultSet rset = stmt.executeQuery("select * from hubo"); //�ĺ� ���̺� �ҷ�����
		
		int startKiho = 0;
		int newKiho = 1;
		while(rset.next()) { //��ȣ��ȣ�� �ϳ��� ������Ű�鼭 �����ִ� ��ȣ�� ���Ͽ�, ���� ��ȣ �ڵ����� ��ȣ�� ��ϵ� 
			startKiho++;
			if (newKiho != rset.getInt(1)) {
				newKiho = startKiho;
				break;
			} else {
				newKiho = startKiho + 1;
			}
		}
	%>

	<form method='post' action='A_01.jsp' name='addCandidateForm'>
		<!-- post������� A_01.jsp ���� ��ȣ��ȣ�� �̸� �޾ƿ���  -->

		<%
		//String newKiho = request.getParameter("newKiho"); //���ο� ��ȣ��ȣ 
		String newName = request.getParameter("newName"); //���ο� �ĺ� �̸� 
		
		if (request.getParameter("newKiho") != null && request.getParameter("newName") != null) { //�ΰ��� �׸� �Ѵ� ������ �ƴ϶�� 
			stmt.execute("insert into kopo.hubo (kiho, name) values (" + newKiho + ", '" + newName + "')"); //DB�� hubo���̺� �Է��ϱ� 
		} 
		%>
	</form>

	<h1>�ĺ� ��� �߰�</h1>
	<br>
	<h2>�ĺ� ��� �߰� �Ϸ�</h2>
	<p>�������� ���ư��� ���Դϴ�...</p>

	<script>
		// �ĺ� ����� �Ϸ�Ǹ� ���� �������� ���ư��� �Լ�
		function goBack() {
			document.addCandidateForm.action = "./A_01.jsp"; //A_01.jsp�������� ���ư���.
			document.addCandidateForm.submit();
		}
		// ������ �ε� �� �ڵ����� goBack() �Լ� ȣ��
		window.onload = function() {
			setTimeout(goBack, 1000); //������ �ε� �� 2���� �ð��� �ΰ� �ڷ� ���ư���. 
		};
	<%} catch (Exception e) { //��ȣ��ȣ�� primary key�� �Ǿ��־ �ִ� ��ȣ��ȣ�� ����� �� ���� 
			out.println("<Script>");
			out.println("alert('�̹� �ִ� ��ȣ��ȣ�� ����� �� �����ϴ�');");
			out.println("history.back();");
			out.println("</script>");
			return;
	}%>
		
	</script>
</body>
</html>