package com.example.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.persistence.ChartDAO;

@Controller
public class ChartController {
	@Autowired
	ChartDAO dao;	
	
	@RequestMapping("students.json")
	@ResponseBody
	public List<List<Object>> studentAvg(String dept){
		List<List<Object>> data = new ArrayList<>();
		List<Object> student = new ArrayList<>();
		student.add("학생명");
		student.add("점수");
		data.add(student);
		
		for(HashMap<String,Object> map : dao.students_avg(dept)){
			student = new ArrayList<>();
			student.add(map.get("sname"));
			student.add(map.get("jumsu"));
			data.add(student);
		}			
		return data;
	}	
	@RequestMapping("courses.json")
	@ResponseBody
	public List<List<Object>> coursesAvg(){
		List<List<Object>> data = new ArrayList<>();
		List<Object> course = new ArrayList<>();
		course.add("강좌명");
		course.add("평균점수");
		data.add(course);
		
		for(HashMap<String,Object> map : dao.courses_avg()){
			course = new ArrayList<>();
			course.add(map.get("lname"));
			course.add(map.get("jumsu"));
			data.add(course);
		}			
		return data;
	}		
	@RequestMapping("chart1")
	public String chart1(Model model){
		model.addAttribute("dept",dao.list_dept());
		return "chart1";
	}	
}
