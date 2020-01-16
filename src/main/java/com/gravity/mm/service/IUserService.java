package com.gravity.mm.service;

import java.util.List;

import com.gravity.mm.bean.GetDefaultMMBean;
import com.gravity.mm.bean.GetProjectCodeBean;
import com.gravity.mm.bean.GetUserBean;
import com.gravity.mm.bean.SearchBean;
import com.gravity.mm.bean.UserMMBean;
import com.gravity.mm.bean.UserBean;

public interface IUserService {
	
	//���� ���� ��ȸ
	public UserBean getLoginInfo(String userID);
	
	
	//���� ���� ���� ������ ���� ���� Ȯ��
	public int getConfirmorDeptAuth(SearchBean searchBean);
	
		
	//������ ���� ���� ��ȸ
	public int getAuthCheck(String userSEQ);
	
	
	//�븮�Է� ���� ��ȸ
	public List<GetUserBean> getPeopleList(SearchBean searchBean);
	
	
	//������ũ �ڵ� ��� ��ȸ
	public List<GetProjectCodeBean> getProjectCode(SearchBean searchBean);
	
	
	//���� �⺻ M/M ��ȸ
	public List<GetDefaultMMBean> getUserDefaultMM(SearchBean searchBean);
	
	
	//���� M/M �߰� ����
	public int getAddUserMM(UserMMBean userMMBean);
	
	
	//���� M/M �Ϸ�
	public int getCompleteUserMM(String i_default_mm);
	
	
	//���� M/M �̿Ϸ�
	public int getInCompleteUserMM(String i_default_mm);
	
	
	//���� M/M ����
	public int getDeleteUserMM(String i_default_mm);
	
	
}

