package kr.ac.kopo.ctc.kopo01.service;

import kr.ac.kopo.ctc.kopo01.dao.InventoryDao;
import kr.ac.kopo.ctc.kopo01.dto.Pagination;

public interface InventoryService {
	
	InventoryDao getInventoryDaoImpl();
	void setInventoryDao(InventoryDao inventoryDao);
	Pagination getPagination(int page, int countPerPage);
		
	
		
}
