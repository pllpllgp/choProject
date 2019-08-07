package com.gravity.mm.service;

import java.util.List;

import com.gravity.mm.bean.GetDefaultMMBean;
import com.gravity.mm.bean.GetTeamBean;
import com.gravity.mm.bean.SearchBean;


public interface ITeamService {
	
	
	//Ȯ���� ���� üũ
	public List<GetTeamBean> getConfirmorDept(SearchBean searchBean);
	
	
	//�� ���� M/M ��ȸ
	public List<GetDefaultMMBean> getUserProjectGroup(SearchBean searchBean);
	
	
	//��  M/M �� �Ϸ�
	public int getCompleteTeamMM(String i_default_mm);
	
	
	//�� ���� seq�� ã��
	public String getTeamUserSeq(String team_user_MM_seq);

}
