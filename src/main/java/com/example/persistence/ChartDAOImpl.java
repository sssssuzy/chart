package com.example.persistence;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChartDAOImpl implements ChartDAO{
   @Autowired
   SqlSession session;   
   String namespace="com.example.mapper.ChartMapper";

   @Override
   public List<HashMap<String, Object>> students_avg(String dept) {
      return session.selectList(namespace+".students_avg",dept);
   }
	@Override
	public List<HashMap<String, Object>> courses_avg() {
		return session.selectList(namespace+".courses_avg");
	}
	@Override
	public List<String> list_dept() {
		return session.selectList(namespace+".list_dept");
	}
}