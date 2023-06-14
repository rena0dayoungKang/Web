package kr.ac.kopo.ctc.kopo01.dao;

import java.util.List;

import kr.ac.kopo.ctc.kopo01.domain.*;

public interface BoardItemDao {
	
//CRUD
	
//1) Create
		//테이블 신규 - makedata.jsp
		public boolean createTable();
		public boolean makedata();
		
		//글 신규 - gongji_insert.jsp
		public Integer insertID();
		public boolean write(int insert, String title, String date, String content, int rootid);
		
		//댓글 신규   -board_reinsert.jsp
		public boolean recnt(int rootid, int recnt);
		public boolean rewrite(String title, String date, String content, int rootid, int relevel, int recnt, int viewcnt);
		

		
//2) Read
		//글 목록  - gongji_list.jsp
		public List<BoardItem> allView();
		
		//글 보기 - gongji_view.jsp
		public BoardItem oneView(int id);
		
		//글 갯수 
		public int count();
		
		//번호 체크 
		public int checkIDExists(int id);
		
		//조회수 체크 
		public int viewCnt(int id);
		
//3) Update
		//글 수정 - gongji_update.jsp?key=글번호
		public boolean update(int updateId, String title, String date, String content, int id);
		
		
		
//4) Delete
		//글 삭제 - gongji_delete.jsp
		public boolean delete(int rootid, int relevel);
		
		
		
		
		
		
		
		
		
		
		
		
		
		
}
