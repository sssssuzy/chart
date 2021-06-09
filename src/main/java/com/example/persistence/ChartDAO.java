package com.example.persistence;

import java.util.HashMap;
import java.util.List;

public interface ChartDAO {
	//학생별 평균점수 //여러개 결과값이 출력되므로, 리스트<해쉬맵>
   public List<HashMap<String, Object>> students_avg(String dept);
   //강좌별 평균점수
   public List<HashMap<String, Object>> courses_avg();
   //학과목록
   public List<String> list_dept();
   
}