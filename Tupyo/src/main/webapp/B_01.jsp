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
<title>��ǥ �ϱ� B01</title>
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
	<h1>��ǥ�ϱ�</h1>

	<%
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");//����̹� ȣ�� 
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo", "root", "kopo0622");// DB ����
		Statement stmt = conn.createStatement(); // SQL ���� ������ ���� ��ü ����
		ResultSet rset = stmt.executeQuery("select * from kopo.hubo;");
		
		int kiho = 0;
		String name = "";
		
		boolean hasData = false; //�����Ͱ� �ִ��� Ȯ���ϴ� hasData ���� false�� �⺻������ ������. 
	%>
	<div
		style="display: flex; justify-content: center; align-items: center;">
		<table>
			<tr>
				<form method="post" action="B_02.jsp">
					<td><p align=center>
							<select name="choice" style="width: 100px; text-align: center;">
						<%
							while(rset.next()) {
								kiho = rset.getInt(1); //�ĺ����̺��� kiho�� �����´�
								name = rset.getString(2);//���̺��� name�� �����´�.
								hasData = true; //�������� �����Ͱ� �ִٸ� hasData�� true�� ����. 
						%>
								<option value=<%=kiho%>><span><%=kiho %> <%=name %></span></option> 
								<!-- �ĺ� �����ϴ� �ɼ� â  -->
						<%
							}							
							if (!hasData){ //�ĺ��� �� �����ϰų� �ĺ� �����Ͱ� ������, 
								%>
								<option value="�ĺ��� �����ϴ�." selectd>�ĺ��� �����ϴ�.</option> 
								<!-- ���� �ɼ� â�� �ؽ�Ʈ ���  -->
								<%
							}
								%>
							</select> <input type="hidden" name="tupyokiho" value=""> 
						</p></td>
					<td></td>
					<td><p align=center>
							<select name="age" style="width: 100px; text-align: center;"> 
							<!-- ��ǥ���� ���ɴ� �����ϴ� �ɼ�  -->
								<option value=1><span>10��</span></option>
								<option value=2><span>20��</span></option>
								<option value=3><span>30��</span></option>
								<option value=4><span>40��</span></option>
								<option value=5><span>50��</span></option>
								<option value=6><span>60��</span></option>
								<option value=7><span>70��</span></option>
								<option value=8><span>80��</span></option>
								<option value=9><span>90��</span></option>
							</select>
						</p></td>
					<td><input type="submit" value="��ǥ�ϱ�" <%if (!hasData) { %> disabled <%} %>></td> 
					<!-- �ĺ� �����Ͱ� ������ �����ϴ� ��ư�� ��Ȱ��ȭ��Ų�� -->
					<td></td>
				</form>
			</tr>
		</table>
	</div>
	<%
	} catch (Exception e) { //��ǥ �� ������ �߻���, �˸�â, �ڷΰ��� 
		e.printStackTrace();
		out.println("<Script>");
		out.println("alert('��ǥ �� ������ �߻��Ͽ����ϴ�.');");
		out.println("history.back();");
		out.println("</script>");
		return;
	}
	%>
</body>
</html>