package com.example.persistence;

import java.util.HashMap;
import java.util.List;

public interface ChartDAO {
	//�л��� ������� //������ ������� ��µǹǷ�, ����Ʈ<�ؽ���>
   public List<HashMap<String, Object>> students_avg(String dept);
   //���º� �������
   public List<HashMap<String, Object>> courses_avg();
   //�а����
   public List<String> list_dept();
   
}