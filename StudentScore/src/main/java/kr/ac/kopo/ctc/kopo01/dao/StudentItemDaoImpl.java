package kr.ac.kopo.ctc.kopo01.dao;

import java.sql.*;
import java.util.*;

import kr.ac.kopo.ctc.kopo01.domain.*;
import kr.ac.kopo.ctc.kopo01.dto.*;
import kr.ac.kopo.ctc.kopo01.service.*;

public class StudentItemDaoImpl implements StudentItemDao {
	
	private String sql = "jdbc:mysql://localhost:3306/kopo";

//1)create
	//examtable 만들기 
	@Override
	public boolean createTable() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); //mysql 드라이버 로드
			Connection conn = DriverManager.getConnection(sql, "root", "kopo0622"); // 데이터베이스에 연결
			Statement stmt = conn.createStatement();// SQL 문을 실행하기 위한 Statement 객체를 생성			
			//테이블 생성
			stmt.execute("create table kopo.examtable(" +    	// examtable 테이블을 생성
					"name varchar(20)," + 					// 이름 컬럼
					"stu_id int not null primary key," +	// 학번
					"kor int," +							// 국어 점수
					"eng int," +							// 영어 점수 컬럼
					"mat int) DEFAULT CHARSET=UTF8;"); 		// 수학 점수 컬럼
			stmt.close();									// Statement 객체를 닫기
			conn.close();									// 데이터베이스 연결을 종료
			return true;										// 테이블 생성 성공 시 1을 반환
		} catch (ClassNotFoundException e) {				
			return false;										// ClassNotFoundException이 발생할 경우 2를 반환
		} catch (SQLException e) {    
			e.printStackTrace();  							// SQLException이 발생한 경우 스택 트레이스를 출력
			return false;										// SQLException이 발생할 경우 2를 반환
		}
	}

	//테이블에 500명의 학생 점수 만드는 프로시져 불러오기 
	@Override
	public int insert()  {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");//mysql 드라이버 로드
			Connection conn = DriverManager.getConnection(sql, "root", "kopo0622");
			 // 데이터베이스에 연결
			Statement stmt = conn.createStatement();// SQL 문을 실행하기 위한 Statement 객체를 생성

			stmt.execute("call insert_examtable(500)"); //insert_examtable(1000)프로시져 호출하기
			stmt.close();
			conn.close();
			return 1;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return 2;   
		} catch (SQLException e) {
			e.printStackTrace();
			return 2;
		}
	}


	//2)read
	//id를 입력하면 한명의 정보만 불러오기 
	@Override
	public StudentItem selectOne(int stu_id) {
		StudentItem studentItem = new StudentItem();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(sql, "root", "kopo0622");
			Statement stmt = conn.createStatement();

			ResultSet rset = stmt.executeQuery("select * from kopo.examtable where stu_id = "+ stu_id + ";");

			while(rset.next()) {
				studentItem.setName(rset.getString(1));
				studentItem.setStu_id(rset.getInt(2));
				studentItem.setKor(rset.getInt(3));
				studentItem.setEng(rset.getInt(4));
				studentItem.setMat(rset.getInt(5));
			}

			rset.close();
			stmt.close();
			conn.close();
		} catch (ClassNotFoundException e) {

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return studentItem;
	}


	//전체 학생의 점수를 조회하기 
	@Override
	public List<StudentItem> selectAll() {
		
		List<StudentItem> studentItemList = new ArrayList<>();
	
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(sql, "root", "kopo0622");
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery("select * from examtable;");
				while(rset.next()) {
					StudentItem studentItem = new StudentItem();
					studentItem.setName(rset.getString(1));
					studentItem.setStu_id(rset.getInt(2));
					studentItem.setKor(rset.getInt(3));
					studentItem.setEng(rset.getInt(4));
					studentItem.setMat(rset.getInt(5));

					studentItemList.add(studentItem);
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
		return studentItemList;
		} 

	//전체 total 학생을 count 하기x
	@Override
	public int count() {
		int cnt = 0;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(sql, "root", "kopo0622");
			Statement stmt = conn.createStatement();

			ResultSet rset = stmt.executeQuery("select count(*) as total from examtable;");
			if (rset.next()) {
				cnt = rset.getInt("total");
			}

			rset.close();
			stmt.close();
			conn.close();
		} catch (ClassNotFoundException e) {

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}
	
	//학생의 rank 조회하기 
	public int rank(int stu_id) throws SQLException, ClassNotFoundException {
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection(sql, "root", "kopo0622");
		Statement stmt = conn.createStatement();
		ResultSet rset = stmt.executeQuery("select (select count(*) + 1 from examtable where (a.kor + a.eng + a.mat) "
				+ "< (kor + eng + mat)) from examtable as a where stu_id= " + stu_id);
		
		rset.next();
		int rank = rset.getInt(1);
		stmt.close();
		conn.close();
		return rank;
	}

	//3)update
	


	//4)delete
	@Override
	public boolean dropTable() { 
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");  //mysql 드라이버 로드
			Connection conn = DriverManager.getConnection(sql,"root", "kopo0622"); 
			// 데이터베이스에 연결
			Statement stmt = conn.createStatement();// SQL 문을 실행하기 위한 Statement 객체를 생성
			stmt.execute("drop table kopo.examtable;"); //테이블 삭제하는 쿼리문
			stmt.close();
			conn.close();
			return true;									//삭제가 되었으면 1 반환
		} catch (ClassNotFoundException e) {
			return false;									//오류생겼을 시 2 반환
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public int deleteData(int stu_id) {
		int error = 1;
		try {
			List<StudentItem> studentItemList = new ArrayList<>();
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(sql,"root", "kopo0622");
			Statement stmt = conn.createStatement();
			stmt.execute("delete from kopo.examtable where stu_id = '" + stu_id + "';");
			stmt.close();
			conn.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			error = 2;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			error = 2;
		}
		return error;
	}

	//홈페이지 방문자수 세기
	   @Override
	   public int countVisit() {
	      int cnt2 = 0;
	      int cnt = 0;
	      try {
	         Class.forName("com.mysql.cj.jdbc.Driver"); 
	         Connection conn = DriverManager.getConnection(sql, "root", "kopo0622"); 
	         Statement stmt = conn.createStatement();
	         ResultSet rset = stmt.executeQuery("select * from kopo.counter"); 
	         
	         while(rset.next()) {
	            cnt = rset.getInt(1);
	            
	         }
	         cnt2 = cnt + 1;
	         stmt.execute("update counter set count = " + cnt2 + ";");
	         rset.close();
	         stmt.close();
	         conn.close();
	         
	      }catch(Exception e) {
	         e.printStackTrace();
	         System.out.println("error");
	      }
	      return cnt2;
	   }

	@Override
	public StudentItem selectAll_View() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public StudentItem selectByName(String selectedName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<StudentItem> selectAll(int page, int countPerPage) {
		// TODO Auto-generated method stub
		return null;
	}
	
	



}
