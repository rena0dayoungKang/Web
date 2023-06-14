package kr.ac.kopo.ctc.kopo01.dao;

import java.sql.*;
import java.util.*;
import kr.ac.kopo.ctc.kopo01.domain.*;

public class InventoryDaoImpl implements InventoryDao {

	String jdbc = "jdbc:mysql://192.168.23.50:33060/kopo";
	
//1)Create
	
	//테이블 생성 
	@Override
	public boolean createTable() {
		// TODO Auto-generated method stub
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); //mysql 드라이버 로드
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622"); 
			// 데이터베이스에 연결
			Statement stmt = conn.createStatement();// SQL 문을 실행하기 위한 Statement 객체를 생성	
			
			stmt.execute("create table kopo.inven("
					+ "id bigint not null primary key auto_increment, " 
					//상품번호 13자리까지 입력을 위해 bigint처리 -> 추후 varchar형식으로 문자형 상품번호도 넣을 수 있게 처리할 예정
					+ "name varchar(100), "  //상품이름
					+ "stock int, "			//재고
					+ "regiDate date, "		//상품등록일
					+ "regiDateQ datetime, "	//재고 조사 시간 datetime 형식
					+ "context text,"		//설명은 긴 내용으로 들어갈 수 있어서 text
					+ "link text, "			//사진이름을 link로 표시 
					+ "userId int) default charset=utf8mb4;"); //등록직원의 id
			
			stmt.close();
			conn.close();
			return true;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}

	
	//상품 신규 등록   - inven_new.jsp
	@Override
	public boolean writeData(long id, String name, int stock, String context, String link, int userId) {
		// TODO Auto-generated method stub
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");//객체생성
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622");// DB 연결
			Statement stmt = conn.createStatement(); // SQL 쿼리 실행을 위한 객체 생성
			
			//insert into kopo.inven (id, name, stock, regiDate, regiDateQ, context, userId)
			//values(1, "바나나", 2, now(), now(), "알래스카산 바나나 알프스의 아침식사", "A0001");
			String sql = "INSERT INTO kopo.inven (id, name, stock, regiDate, regiDateQ, context, link, userId) "
			           + "VALUES (" + id + ",'" + name + "'," + stock + ", CURDATE(), NOW(), '" + context + "', '" + link + "', " + userId + ");";
			//curdate()함수는 'YYYY-MM-DD' 형, 시간은 포함하지 않음
			//now()함수는  현재 날짜와 시간을 datetime 형식('YYYY-MM-DD HH:MM:SS')으로 반환

			stmt.execute(sql);			
			stmt.close();
			conn.close();
			
			return true;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}

	
//2)Read
	
	//상품 전체 목록 보기   - inven_list.jsp
	@Override
	public List<InventoryItem> showAll() {
		// TODO Auto-generated method stub
		List<InventoryItem> inventoryItemList = new ArrayList<>();
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); //mysql 드라이버 로드
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622"); // 데이터베이스에 연결
			Statement stmt = conn.createStatement();// SQL 문을 실행하기 위한 Statement 객체를 생성	
			ResultSet rset = stmt.executeQuery("select * from kopo.inven order by regiDateQ desc;");
			//재고조사시간을 기준으로 최신순으로 정렬하기 
			
			while(rset.next()) {
				InventoryItem inventoryItem = new InventoryItem();
				inventoryItem.setId(rset.getLong(1));  //상품번호
				inventoryItem.setName(rset.getString(2));//상품명
				inventoryItem.setStock(rset.getInt(3));//재고
				inventoryItem.setRegiDate(rset.getString(4));//상품등록일
				inventoryItem.setRegiDateQ(rset.getString(5));//재고조사일
				inventoryItem.setContext(rset.getString(6));//상품설명
				inventoryItem.setUserId(rset.getString(7));//등록직원
				
				inventoryItemList.add(inventoryItem);//리스트에 저장
			}
			rset.close();
			stmt.close();
			conn.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return inventoryItemList;
		
	}

	//상품 하나의 상세 정보 보기   - inven_one.jsp
	@Override
	public InventoryItem showOne(long id) {
		// TODO Auto-generated method stub
		InventoryItem inventoryItem = new InventoryItem(); //객체생성
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");  //드라이버 호출
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622");//DB연결
			Statement stmt = conn.createStatement(); //stmt객체 생성 
			
			ResultSet rset = stmt.executeQuery("select * from kopo.inven where id = " + id + ";");
			//id중에서 하나의 상세정보 보기 
			while(rset.next()) {
				inventoryItem.setId(rset.getLong(1)); //상품번호
				inventoryItem.setName(rset.getString(2)); //상품명
				inventoryItem.setStock(rset.getInt(3)); //재고수량
				inventoryItem.setRegiDate(rset.getString(4)); //상품등록일
				inventoryItem.setRegiDateQ(rset.getString(5));//재고조사일
				inventoryItem.setContext(rset.getString(6));//상품설명
				inventoryItem.setLink(rset.getString(7));//상품사진
				inventoryItem.setUserId(rset.getString(8));//등록직원
			}
			rset.close();
			stmt.close();
			conn.close();
			return inventoryItem;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		

	}
	
	//전체 상품 목록을 count하기
	public int count() {
		int cnt = 0;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); //드라이버 호출
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622");//DB연결
			Statement stmt = conn.createStatement();//stmt객체 생성 
			ResultSet rset = stmt.executeQuery("select count(*) as total from inven;");//총 상품목록count
			if(rset.next()) {
				cnt = rset.getInt("total"); //total을 cnt로 리턴하기 
			}
			rset.close();
			stmt.close();
			conn.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return cnt;
	}
	
	//중복 아이디 체크하기 
	public boolean idExist(long id) {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");//드라이버 호출
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622");//DB연결
			PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM kopo.inven WHERE id = ?");
			//preparedSatement 객체 생성, 상품번호가 동일한 번호가 있는지 체크하기 
			stmt.setInt(1, (int) id); // 첫 번째 매개변수에 id 값을 설정. setInt() 메서드는 정수 값을 설정하는 데 사용
			ResultSet rs = stmt.executeQuery();
			// stmt.executeQuery() 메서드를 호출하여 쿼리를 실행하고 결과를 ResultSet 객체에 저장.
			
			if(rs.next()) { // ResultSet 객체에 다음 결과가 있는지 확인
				int count = rs.getInt(1);
				// getInt() 메서드를 사용하여 ResultSet에서 첫 번째 열의 값을 정수로 가져온다
				return count > 0; //0보다 큰 경우 true를 반환
			}
			rs.close();
			stmt.close();
			conn.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}


//3)Update
	//상품 정보 수정  - inven_update.jsp
	@Override
	public boolean updateData(long id, String name, String context, String userId) {
		// TODO Auto-generated method stub
		InventoryItem inventoryItem = new InventoryItem();
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");//드라이버 호출
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622");//DB연결
			Statement stmt = conn.createStatement(); //stmt객체생성
			//UPDATE kopo.inven SET id = 2, name = "배내내" , 
			//context = "아침에 굿모닝 위한 바나나 하나" , userId = "A0002" WHERE id=1;
			String sql = "UPDATE kopo.inven SET id = " + id + ", name = '" + name + "' , context = '" + context + "',"
					+ "userId = '" + userId + "' where id = " + id + ";";
			int rowsAffected = stmt.executeUpdate(sql); //sql affect된 갯수 구하기 
			stmt.close();
			conn.close();
			
			return rowsAffected > 0;  //0보다 크다면 true return 
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}

	//상품 재고 수량 수정  -  inven_updateQ.jsp
	@Override
	public boolean updateQuantitiy(long id, int stock) {
		// TODO Auto-generated method stub
		InventoryItem inventoryItem = new InventoryItem();
		
		try {
			//update kopo.inven set stock = 1 where id = 2;
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622");
			Statement stmt = conn.createStatement();
			//UPDATE kopo.inven SET stock=3, regiDateQ=now() where id =1;
			String sql = "UPDATE kopo.inven SET stock=" + stock + ", regiDateQ= now() where id =" + id + ";";
			stmt.executeUpdate(sql);
			
			stmt.close();
			conn.close();
			
			return true;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}

	
//4)Delete
	
	//상품 삭제   - inven_delete.jsp
	@Override
	public boolean delete(long id) {
		// TODO Auto-generated method stub
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");//드라이버 호출 
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622");//DB연결
			String sql = "delete from kopo.inven where id = ?"; //삭제할 레코드를 지정하기 위한 SQL쿼리문 생성 
			PreparedStatement stmt = conn.prepareStatement(sql); //PreparedStatement 안전하게 쿼리를 실행
			stmt.setLong(1, id);
			int rowsAffected = stmt.executeUpdate(); // 삭제된 레코드의 수를 반환
			
			stmt.close();
			conn.close();
			return rowsAffected > 0;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}

	}

}
