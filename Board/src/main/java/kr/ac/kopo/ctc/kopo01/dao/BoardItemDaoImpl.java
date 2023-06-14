package kr.ac.kopo.ctc.kopo01.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import kr.ac.kopo.ctc.kopo01.domain.*;
import kr.ac.kopo.ctc.kopo01.domain.*;

public class BoardItemDaoImpl implements BoardItemDao {
	
	String jdbc = "jdbc:mysql://localhost:33060/kopo";
	//CRUD

//1)Create
	
	//테이블 신규 - makedata.jsp
	@Override
	public boolean createTable() {
		// TODO Auto-generated method stub
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); //mysql 드라이버 로드
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622"); 
			// 데이터베이스에 연결
			Statement stmt = conn.createStatement();// SQL 문을 실행하기 위한 Statement 객체를 생성	
			
			stmt.execute("create table kopo.board ("    
				    + "id INT NOT NULL PRIMARY KEY AUTO_INCREMENT," //id는 정수, 빈값X, 프라이머리키, 자동으로 값을 증가
				    + "title VARCHAR(100),"   //title은 제목 
				    + "date DATETIME,"		//date라는 DATETIME 형식
				    + "content MediumText,"  //context라는 이름의 열을 대용량 문자열(text)형식
				    + "rootid INT,"		//(원 글 번호)
				    + "relevel INT,"     //(댓글 레벨 -> 원글 :0 댓글 :1 댓댓글:2 댓댓댓글:3)
				    + "recnt INT,"		//(댓글 내 글 표시 순서)
				    + "viewcnt INT"		//(조회수)
				    + ") DEFAULT CHARSET=utf8mb4;");
			
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

	
	//테스트 데이터 신규 - makedata.jsp
	@Override
	public boolean makedata() {
		// TODO Auto-generated method stub
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); //mysql 드라이버 로드
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622"); // 데이터베이스에 연결
			Statement stmt = conn.createStatement();// SQL 문을 실행하기 위한 Statement 객체를 생성	
			String sql = "";
			
			LocalDateTime currentDateTime = LocalDateTime.now();
			Timestamp timestamp = Timestamp.valueOf(currentDateTime); 
			
			for (int i = 0; i < 10; i++) {
				sql = String.format("INSERT INTO kopo.board (id, title, date, content, rootid, relevel, recnt, viewcnt) "
						+ "values('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s');", 
						(i+1), (i+1), timestamp , "내용", (i+1), 0, 0, 0);
				stmt.execute(sql);
			}
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


	//글 쓰기 - board_insert.jsps
	@Override
	public boolean write(int insert, String title, String date, String content, int rootid) {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");//객체생성
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622");// DB 연결
			Statement stmt = conn.createStatement(); // SQL 쿼리 실행을 위한 객체 생성
			//insert into kopo.board values (58, "공지사항7", now(), "공지사항내용7", 58, 0, 0, 0);
			
			String sql = "INSERT INTO kopo.board VALUES (" + insert + ", '" + title + "', '" + date + "', '" + content + "', " + insert + " ,0 ,0, 0)";

			int rowsAffected = stmt.executeUpdate(sql); 
			
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
	

//2)Read
	
	//글 목록  - Board_list.jsp
	@Override
	public List<BoardItem> allView() {
		// TODO Auto-generated method stub
		List<BoardItem> boardItemList = new ArrayList<BoardItem>();
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");  //드라이버
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622");
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery("select * from kopo.board order by rootid desc, recnt asc, relevel asc;");
			
			while(rset.next()) {
				BoardItem boardItem = new BoardItem();
				boardItem.setId(rset.getInt(1));
				boardItem.setTitle(rset.getString(2));
				boardItem.setDate(rset.getString(3));
				boardItem.setContent(rset.getString(4));
				boardItem.setRootid(rset.getInt(5));
				boardItem.setRelevel(rset.getInt(6));
				boardItem.setRecnt(rset.getInt(7));
				boardItem.setViewcnt(rset.getInt(8));
				
				boardItemList.add(boardItem);
			}
			
			rset.close();
			stmt.close();
			conn.close();				
					
			return boardItemList;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return boardItemList;
	}
	
	//글 쓰기 신규 번호 생성 - gongji_insert.jsps
		@Override
		public Integer insertID() {
			// TODO Auto-generated method stub
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");//객체생성
				Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622");// DB 연결
				Statement stmt = conn.createStatement(); // SQL 쿼리 실행을 위한 객체 생성
				ResultSet rset = stmt.executeQuery("select Max(id) from kopo.board;"); //공지리스트 중 id찾기
				
				if(rset.next()) { //아이디 값중에 가장 큰 값을 찾아서 넣기
					int maxID = rset.getInt(1);
					if(rset.wasNull()) {
						return 1;
					} else {
						return maxID + 1;
					}
				} else {
					return -1;
				}
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return -1;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return -1;
			}
		}
		
		//댓글 쓰기 신규 번호 생성 - board_reinsert.jsp
		
		
	
		//글 보기 - gongji_view.jsp
		@Override
		public BoardItem oneView(int id) {
			// TODO Auto-generated method stub
			BoardItem boardItem = new BoardItem(); //객체생성
			
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");  //드라이버 호출
				Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622");//DB연결
				Statement stmt = conn.createStatement(); //stmt객체 생성 
				
				ResultSet rset = stmt.executeQuery("select * from kopo.board where id = " + id + ";");
				
				while(rset.next()) {
					boardItem.setId(rset.getInt(1)); //id번호
					boardItem.setTitle(rset.getString(2)); //타이틀 제목 가져오기 
					boardItem.setDate(rset.getString(3)); //일자 
					boardItem.setViewcnt(rset.getInt(8)); //조회수
					boardItem.setContent(rset.getString(4)); //내용
					boardItem.setRootid(rset.getInt(5)); //원글번호
					boardItem.setRelevel(rset.getInt(6)); //댓글 수준
					boardItem.setRecnt(rset.getInt(7)); //댓글 내 순서
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
			return boardItem;
		}
	
	//게시글 목록의 갯수 세기 
	@Override
	public int count() {
		// TODO Auto-generated method stub
		int cnt = 0;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); //드라이버 호출
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622");
			//DB연결
			Statement stmt = conn.createStatement(); //stmt객체 생성
			ResultSet rset = stmt.executeQuery("select count(*) as total from kopo.board;");
			
			if (rset.next()) {
				cnt = rset.getInt("total");
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
	
	//게시글 중복 번호 찾기
	public int checkIDExists(int id) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");//드라이버 호출
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622");
			Statement stmt = conn.createStatement();//stmt객체 생성
			ResultSet rset = stmt.executeQuery("select count(*) from kopo.board where id = ?");
			int check = rset.getInt(1);
			
			rset.close();
			stmt.close();
			conn.close();
			return check;
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		} 
	}
	
	
	//댓글 recnt 자리빼주기 
	public boolean recnt(int rootid, int recnt) {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");//드라이버 호출
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622");
			Statement stmt = conn.createStatement();//stmt객체 생성
			
			String sql = "";
			//UPDATE kopo.board set recnt = (recnt + 1) where rootid = 1 and recnt > recnt;
			sql = "UPDATE kopo.board set recnt = (recnt + 1) where rootid = " + rootid + " and recnt > " + recnt + ";";
			stmt.execute(sql);
			
			stmt.close();
			conn.close();
			return true;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	
	//댓글 쓰기 -board_reinsert.jsp
	@Override
	public boolean rewrite(String title, String date, String content, int rootid, int relevel, int recnt, int viewcnt) {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");//객체생성
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622");// DB 연결
			Statement stmt = conn.createStatement(); 
			String sql = "";
			
			//insert into kopo.board (title, date, content, rootid, relevel, recnt, viewcnt) values ("댓글", now(), "댓글내용", 38, 1, 1, 0);
			sql = "INSERT INTO kopo.board (title, date, content, rootid, relevel, recnt, viewcnt) "
					+ "VALUES ('" + title + "', now(), '" + content + "', " + rootid + ", " + (relevel + 1) + ", " + (recnt + 1) + ", 0)";
			
			stmt.execute(sql);
			
			stmt.close();
			conn.close();
			return true;
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	
	//조회수 카운트
	public int viewCnt(int id) {
		int error = 0;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");//객체생성
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622");// DB 연결
			Statement stmt = conn.createStatement(); 
			String sql = "";
			//update kopo.board set viewcnt = (viewcnt + 1) where id = 2;
			sql = "UPDATE kopo.board SET viewcnt = (viewcnt + 1 ) where id = " + id + ";";
			stmt.execute(sql);
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			error = -1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			error = -1;
		}
		return error;
	}

//3)Update
	
	//글 수정 - gongji_update.jsp?key=글번호
	@Override
	public boolean update(int updateId, String title, String date, String content, int id) {
		// TODO Auto-generated method stub
		BoardItem boardItem = new BoardItem();
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622");
			Statement stmt = conn.createStatement();
			//UPDATE kopo.board SET id = 54, title = "제목55", date = now(), content = "내용", rootid = 54 WHERE id = 2;
			LocalDateTime currentDateTime = LocalDateTime.now();
			Timestamp timestamp = Timestamp.valueOf(currentDateTime);
			
			String sql = "UPDATE kopo.board SET id = " + updateId + ", title = '" + title + "', "
					+ "date = '" + timestamp + "', content = '" + content + "', rootid = " + updateId + " WHERE id = " + id;
			int rowsAffected = stmt.executeUpdate(sql);
			
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
	
	
//4)Delete
	
	//글 삭제 - gongji_delete.jsp
	@Override
	public boolean delete(int rootid, int relevel) {
		// TODO Auto-generated method stub
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");//드라이버 호출 
			Connection conn = DriverManager.getConnection(jdbc, "root", "kopo0622");//DB연결
			String sql = ""; //삭제할 레코드를 지정하기 위한 SQL쿼리문 생성 
			if (relevel == 0) {
				sql = "DELETE FROM kopo.board WHERE rootid = ?";
			} else {
				sql = "UPDATE kopo.board SET title = '삭제된 댓글입니다', content = '삭제된 댓글입니다' WHERE id = ?";
			}
			PreparedStatement stmt = conn.prepareStatement(sql); //PreparedStatement 안전하게 쿼리를 실행
			stmt.setInt(1, rootid); //PreparedStatement의 setInt() 메소드를 사용, id = ? 부분에 id 값을 대입
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
