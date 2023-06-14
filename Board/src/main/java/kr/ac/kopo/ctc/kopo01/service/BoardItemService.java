package kr.ac.kopo.ctc.kopo01.service;

import kr.ac.kopo.ctc.kopo01.dao.BoardItemDao;
import kr.ac.kopo.ctc.kopo01.dto.Pagination;

public interface BoardItemService {

	
	public Pagination getPagination(int page, int countPerPage);

}
