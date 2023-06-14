package kr.ac.kopo.ctc.kopo01.dao;

import java.sql.SQLException;

import kr.ac.kopo.ctc.kopo01.domain.AgeRate;
import kr.ac.kopo.ctc.kopo01.domain.hubo;

public interface  Dao {

	AgeRate tupyorate(int number);

	AgeRate selectOneRate(int number) throws ClassNotFoundException, SQLException;

	hubo selectOne(int number) throws ClassNotFoundException, SQLException;
	
	//CRUD
	
	//1.Create

	
	
	//2.Read
	
	
	//3.Update
	
	
	//4.Delete

}
