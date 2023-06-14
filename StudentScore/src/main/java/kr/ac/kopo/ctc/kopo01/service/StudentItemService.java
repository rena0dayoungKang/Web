package kr.ac.kopo.ctc.kopo01.service;

import kr.ac.kopo.ctc.kopo01.dao.StudentItemDao;
import kr.ac.kopo.ctc.kopo01.dto.Pagination;

public interface StudentItemService {
	
	StudentItemDao getStudentItemDao();
	void setStudentItemDao(StudentItemDao studentItemDao);
	
	Pagination getPagination(int page, int countPerPage);
	
	
}
