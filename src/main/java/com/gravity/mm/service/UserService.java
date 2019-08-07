package com.gravity.mm.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gravity.mm.bean.GetDefaultMMBean;
import com.gravity.mm.bean.GetProjectCodeBean;
import com.gravity.mm.bean.GetUserBean;
import com.gravity.mm.bean.SearchBean;
import com.gravity.mm.bean.UserBean;
import com.gravity.mm.bean.UserMMBean;
import com.gravity.mm.dao.UserHandler;

@Service
public class UserService implements IUserService{
	
	@Inject
	UserHandler dao;
	
	//���� ���� ��ȸ
	public UserBean getLoginInfo(String userID) {
		return dao.getLoginInfo(userID);
	}
	
	
	//������ ���� ���� ��ȸ
	public int getAuthCheck(String userSEQ) {
		return dao.getAuthCheck(userSEQ);
	}
	
	
	//�븮�Է� ���� ��ȸ
	public List<GetUserBean> getPeopleList(SearchBean searchBean) {
		return dao.getPeopleList(searchBean);
	}
	
	
	//������ũ �ڵ� ��� ��ȸ
	public List<GetProjectCodeBean> getProjectCode(SearchBean searchBean) {
		return dao.getProjectCode(searchBean);
	}
	
	
	//���� �⺻ M/M ��ȸ
	public List<GetDefaultMMBean> getUserDefaultMM(SearchBean searchBean) {
		return dao.getUserDefaultMM(searchBean);
	}


	//���� M/M �߰� ����
	public int getAddUserMM(UserMMBean userMMBean) {
		return dao.getAddUserMM(userMMBean);
	}
	
	
	//���� M/M �Ϸ�
	public int getCompleteUserMM(String i_default_mm) {
		return dao.getCompleteUserMM(i_default_mm);
	}
	
	
	//���� M/M �̿Ϸ�
	public int getInCompleteUserMM(String i_default_mm) {
		return dao.getInCompleteUserMM(i_default_mm);
	}
	
	
	//���� M/M �߰� ����
	public int getDeleteUserMM(String i_default_mm) {
		return dao.getDeleteUserMM(i_default_mm);
	}
		
}