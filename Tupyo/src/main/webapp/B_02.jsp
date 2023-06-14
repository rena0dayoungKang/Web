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
<title>��ǥ �ϱ� B02</title>
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
		Class.forName("com.mysql.cj.jdbc.Driver");//��ü����
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo", "root", "kopo0622");// DB ����
		Statement stmt = conn.createStatement(); // SQL ���� ������ ���� ��ü ����
		ResultSet rset = stmt.executeQuery("select * from hubo"); //�ĺ� ���̺� �ҷ�����
	%>

	<form method='post' action='B_01.jsp' name='TupyoForm'>
		<!-- post������� B_01.jsp ���� ��ȣ��ȣ�� ���ɴ� �޾ƿ���  -->

		<%
		String tupyokiho = request.getParameter("choice"); //���ο� ��ȣ��ȣ 
		String age = request.getParameter("age"); //���ο� �ĺ� �̸� 
		if (tupyokiho != null && age != null) { //�ΰ��� �׸� �Ѵ� ������ �ƴ϶�� 
			stmt.execute("insert into kopo.tupyo (kiho, age) values ('" + tupyokiho + "', '" + age + "')"); 
			//DB�� hubo���̺� �Է��ϱ� 
		}
		
		%>
	</form>

	<h1>��ǥ �ϱ�</h1>
	<br>
	<h2>��ǥ�� �Ϸ��Ͽ����ϴ�.</h2>
	<p>�������� ���ư��� ���Դϴ�...</p>
	<script>
		// �ĺ� ����� �Ϸ�Ǹ� ���� �������� ���ư��� �Լ�
		function goBack() {
			document.TupyoForm.action = "./B_01.jsp"; //A_01.jsp�������� ���ư���.
			document.TupyoForm.submit();
		}
		// ������ �ε� �� �ڵ����� goBack() �Լ� ȣ��
		window.onload = function() {
			setTimeout(goBack, 1000); //������ �ε� �� 2���� �ð��� �ΰ� �ڷ� ���ư���. 
		};
	<%} catch (Exception e) {
			out.println("<Script>");
			out.println("alert('��ǥ �� ������ �߻��Ͽ����ϴ�');");
			out.println("history.back();");
			out.println("</script>");
			return;
	}%>
		
	</script>
</body>
</html>