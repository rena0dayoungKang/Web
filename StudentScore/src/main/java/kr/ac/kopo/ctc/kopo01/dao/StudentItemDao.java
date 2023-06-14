package kr.ac.kopo.ctc.kopo01.dao;

import java.sql.SQLException;
import java.util.List;
import kr.ac.kopo.ctc.kopo01.domain.StudentItem;

public interface StudentItemDao {
	// CRUD	

	//1)Create
	public boolean createTable();
	public int insert();

	//2)Read
	public StudentItem selectOne(int id);
	public StudentItem selectAll_View();
	public List<StudentItem> selectAll(int page, int countPerPage);
	public StudentItem selectByName(String selectedName);
	
	public int rank(int stu_id) throws ClassNotFoundException, SQLException;
	public int count();
	public int countVisit();

	//3)Update


	//4)Delete
	public boolean dropTable();
	public int deleteData(int stu_id);
	List<StudentItem> selectAll();



	
}
