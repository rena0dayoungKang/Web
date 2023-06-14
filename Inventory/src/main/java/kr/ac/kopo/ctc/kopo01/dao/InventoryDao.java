package kr.ac.kopo.ctc.kopo01.dao;

import java.util.List;

import kr.ac.kopo.ctc.kopo01.domain.InventoryItem;

public interface InventoryDao {
	
//CRUD
	
//1)Create
	//테이블 생성   
	public boolean createTable();
	
	//상품 신규 등록   - inven_new.jsp
	public boolean writeData(long id, String name, int stock, String context, String link, int userId);
	

//2)Read
	//상품 전체 목록 보기   - inven_list.jsp
	public List<InventoryItem> showAll();
	
	//상품 하나의 상세 정보 보기   - inven_one.jsp
	public InventoryItem showOne(long id);
	
	//상품 전체의 갯수 세기 
	public int count();
	
	//상품 아이디 중복 체크 하기 
	public boolean idExist(long id);
	

//3)Update
	//상품 정보 수정  - inven_update.jsp
	public boolean updateData(long id, String name, String context, String userId);
	
	
	//상품 재고 수량 수정  -  inven_updateQ.jsp
	public boolean updateQuantitiy(long id, int stock);
	
	
	
//4)Delete
	//상품 삭제   - inven_delete.jsp
	public boolean delete(long id);

	

	

	

	

	

	

	

	


	
	

	



	

	


	
	
	
}
