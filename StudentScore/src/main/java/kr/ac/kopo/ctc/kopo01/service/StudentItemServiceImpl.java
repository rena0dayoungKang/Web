package kr.ac.kopo.ctc.kopo01.service;
import kr.ac.kopo.ctc.kopo01.dto.Pagination;
import kr.ac.kopo.ctc.kopo01.dao.StudentItemDao;
import kr.ac.kopo.ctc.kopo01.dao.StudentItemDaoImpl;

public class StudentItemServiceImpl implements StudentItemService {

	@Override
	public Pagination getPagination(int page, int countPerPage) {
		Pagination pagination = new Pagination(); //객체 생성은 최대한 윗부분에서 해야 정보 저장 가능
		StudentItemDaoImpl studentItemDaoImpl = new StudentItemDaoImpl();
		int totalCount = studentItemDaoImpl.count(); //총 데이터 개수

		int endPage = 0; //최종페이지

		if (totalCount % countPerPage == 0) { //총 데이터의 갯수를 countPerPage 로 나눈 나머지가 0이라면  
			endPage = totalCount / countPerPage; //마지막 페이지는 전체 카운트를 countPerPage로 나눈값이 된다. 
		} else {
			endPage = (totalCount / countPerPage) + 1;  //나머지 출력이 있으면 페이지 +1
		}
		
		//현재페이지 설정
		if(page < 1) {
			pagination.setC(1);   //페이지가 1보다 작으면 현재페이지를 1로 지정
		} else if (endPage < page) {
			pagination.setC(endPage);	//마지막페이지가 보려는 페이지보다 작을때는 마지막페이지를 현재페이지로 지정
		} else {
			pagination.setC(page);	//그외라면 보려는 페이지를 현재페이지로 설정한다.
		}


		// << 페이지 설정
		if(page < 11) {
			pagination.setPp(-1);	//보려는 페이지가 11보다 작은경우 Pp를 -1로 지정 Pp는 제일처음으로간다
		} else {
			pagination.setPp(1);	//그외라면 Pp를 1로 지정
		}

		// < 페이지 설정
		if (page < 11) {
			pagination.setP(-1);	//보려는 페이지가 11보다 작은경우 p를 -1로 지정 P는 한페이지 앞으로 간다
		} else if (endPage < page) { //마지막페이지가 보려는 페이지보다 작은경우 
			pagination.setP(((endPage - 1) / 10 -1) * 10 + 1); 
		} else {
			pagination.setP((((page - 1) / 10) - 1) * 10 + 1); 
		}

		//시작페이지 설정
		if (page < 1) {
			pagination.setS(1);	// 보려는 페이지가 1보다 작다면 시작페이지를 1로 지정
		} else if (endPage < page) { //마짐가페이지가 보려는페이지보다 작은경우 
			pagination.setS(((endPage -1) / 10 * 10) + 1);
		} else {
			pagination.setS(((page -1) / 10) * 10 + 1);
		}

		//마지막 페이지 설정
		if(page < 11) {
			pagination.setE(10); //보려는 페이지가 11보다 작은 경우 마지막 페이지를 10으로 지정 
		} else if (((page - 1) / 10) >= endPage / 10) {
			pagination.setE(endPage);				
		} else {
			pagination.setE(((page - 1) / 10) * 10 + 10);
		}

		//> 페이지 설정
		if (page < 11) {
			pagination.setN(11); //보려는 페이지가 11보다 작은경우 > 누르면 11로 간다
		} else if (page < (endPage / 10 * 10)) {
			pagination.setN((((page - 1) / 10) + 1) * 10 + 1);
		} else if ((endPage / 10 * 10) < page) {
			pagination.setN(-1);
		}


		// >> 페이지 설정 
		if((endPage / 10 * 10) < page) { 
			pagination.setNn(-1);	
		} else {
			pagination.setNn(endPage * countPerPage);
		} 

		return pagination; //객체 값 반환
	}

	@Override
	public StudentItemDao getStudentItemDao() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void setStudentItemDao(StudentItemDao studentItemDao) {
		// TODO Auto-generated method stub
	}
}