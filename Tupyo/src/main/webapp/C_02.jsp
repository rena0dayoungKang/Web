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
<meta charset="EUC-KR">
<title>��ǥ ��� C02</title>
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

.none {
	text-align: center;
	background-color: #eee;
	padding: 10px;
	margin: 0;
}

.none p {
	color: black;
	font-size: 16px;
	text-decoration: underline;
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
	

	<form method='post' action='C_01.jsp'>
		<%
		String selectOne = request.getParameter("selectOne"); //��ȣ��ȣ
		//out.print(selectOne);
		
		Class.forName("com.mysql.cj.jdbc.Driver");//��ü����
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo", "root", "kopo0622");// DB ����
		Statement stmt = conn.createStatement(); // SQL ���� ������ ���� ��ü ����
		ResultSet rset2 = stmt.executeQuery("select * from kopo.hubo where kiho = " + selectOne + ";"); 
		rset2.next();
		
		//�ĺ��� �̸� ����ϱ� 
		%>
		<h1><%=rset2.getString(2) %> �ĺ��� ���ɴ뺰 ��ǥ��</h1>
		<table class="container" cellspacing=3, width=600 border=1>
		<tr>
			<td colspan=2><%=selectOne %>�� �ĺ�</td>
		</tr>
		<%
		for (int i = 1; i < 10; i++) {
			int age = i * 10; // i�� 10�� ���ؼ� 10����� 90����� ǥ���ϱ� 
			//select round(count(*) / (select count(*) from tupyo where kiho = 5) * 100 , 1) , count(*) from tupyo where kiho = 5 and age= 1;
			ResultSet rset = stmt.executeQuery("select round(count(*) / (select count(*) from tupyo where kiho = " + selectOne + " ) * 100 , 1) , " +
					"count(*) from tupyo where kiho = " + selectOne + " and age= " + i + ";"); //���������� ��ȣ��ȣ�� �ش��ϴ� age �� count �� ��Ÿ���� 
			
			if (rset.next()) {
				%>
				<tr>
					<td><%=age %>��</td>
					<td>
						<% if (rset.getInt(2) != 0) { %> <!-- count�� 0�� �ƴѰ��  -->
							<div style="display: flex; align-items: center;">
							<p style="background-color: #323287; width: <%=rset.getDouble(1)%>%; margin: 0; color: #323287;">
							<%=rset.getInt(2)%></p>
							<span style="margin-left: 10px;"><%=rset.getInt(2)%>(<%=rset.getDouble(1)%>%)</span>
							<!-- count������ŭ �׷����� ǥ���ϱ�  -->
							</div>
						<% } else if (rset.getInt(2) == 0) {%> <!-- count�� 0�� ���  -->
							<div style="text-align:left"><span style="margin-left: 10px;"><%=rset.getInt(2)%>
							(<%=rset.getDouble(1)%>%)</span></div> <!-- 0�̶�� ���ڸ� ����ϱ�  -->
						<% } %>
					</td>
				</tr>
				<%
			}
		}		
		%>
		</table>
	</form>
</body>
</html>