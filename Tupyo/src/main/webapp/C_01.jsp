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
<title>��ǥ ��� C01</title>
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
	color : black;
	font-size : 16px;
	text-decoration : underline;
	
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

	<h1>�ĺ��� ��ǥ ���</h1>

	<%
	Class.forName("com.mysql.cj.jdbc.Driver");//��ü����
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo", "root", "kopo0622");// DB ����
	Statement stmt = conn.createStatement(); // SQL ���� ������ ���� ��ü ����
	ResultSet rset = stmt.executeQuery("SELECT hubo.kiho, hubo.name, IFNULL(count(a.kiho), 0) AS count, " +
	        "IFNULL(ROUND(count(a.kiho) / total_count * 100, 1), 0) AS vote_percentage " +
	        "FROM hubo LEFT JOIN tupyo AS a ON hubo.kiho = a.kiho " +
	        "CROSS JOIN (SELECT COUNT(kiho) AS total_count FROM tupyo) AS total_votes " +
	        "GROUP BY hubo.kiho, hubo.name, total_count;"); 
			//hubo���̺�� tupyo���̺��� �����ϴ�, kiho�� name ���� �Բ� kiho�� ������ ����, ������ �������� ������ 0���� ��ü ifnull
			//count �� total_count�� ������ �� ����� ����� ���·� ��ȯ�Ͽ� �Ҽ��� ù°�ڸ����� ǥ���Ѵ�. 
			//kiho, name, total_count�� �������� �׷�ȭ�Ѵ�. 

	%>
	<div>
		<table class="container" cellspacing=3, width=600 border=1>
			<tr>
				<td width=100><p>�̸�</p></td>
				<td><p>�α⵵</p></td>
			</tr>
			
			<form method="post" action="C_02.jsp">
			<%
			while (rset.next()) { %>
				<tr>
					<td><a href="C_02.jsp?selectOne=<%= rset.getInt(1) %>" style="width: 50px;" name="selectOne">
					<%=rset.getInt(1)%>.<%= rset.getString(2) %></a></td>
					<!-- �ĺ��� �̸��� ���� �� ���κ� ��ǥ���� �̵��� �� �ֵ��� -->
					<td>
						<% if (rset.getInt(3) != 0) { %> <!-- ��ǥ���� 0�� �ƴ϶��  -->
							<div style="display: flex; align-items: center;">
							<p style="background-color: #323287; width: <%=rset.getDouble(4)%>%; margin: 0; color: #323287;">
							<%=rset.getInt(3)%></p><!-- ��ǥ�� ��ŭ ����׷��� �������� ��Ÿ����  -->
							<span style="margin-left: 10px;"><%=rset.getInt(3)%>(<%=rset.getDouble(4)%>%)</span>
							<!-- ��ǥ�� ��ŭ ����׷��� �������� ��Ÿ����  -->
							</div>
						<% } else if (rset.getInt(3) == 0) {%>  <!-- ��ǥ���� 0�̶��  -->
							<div style="text-align:left">
							<span style="margin-left: 10px;"><%=rset.getInt(3)%>(<%=rset.getDouble(4)%>%)</span>
							</div> <!-- 0�̶�� ���ڿ� 0.0% ���ڷ� ��� -->
						<% } %>
					</td>
				</tr>
				
			</form>
			<%
			}
			%>
		</table>
	</div>
</body>
</html>