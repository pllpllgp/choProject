package com.gravity.mm.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gravity.mm.bean.GetDefaultMMBean;
import com.gravity.mm.bean.GetProjectCodeBean;
import com.gravity.mm.bean.GetUserBean;
import com.gravity.mm.bean.SearchBean;
import com.gravity.mm.bean.UserMMBean;
import com.gravity.mm.bean.UserBean;
import com.gravity.mm.dao.UserHandler;

@Service
public class UserService implements IUserService{
	
	
	@Inject
	UserHandler dao;
	
	//유저 정보 조회
	public UserBean getLoginInfo(String userID) {
		return dao.getLoginInfo(userID);
	}
	
	
	//유저 팀별 관리 페이지 권한 유무 확인
	public int getConfirmorDeptAuth(SearchBean searchBean) {
		return dao.getConfirmorDeptAuth(searchBean);
	}
	
	
	//관리자 권한 유무 조회
	public int getAuthCheck(String userSEQ) {
		return dao.getAuthCheck(userSEQ);
	}
	
	
	//대리입력 유무 조회
	public List<GetUserBean> getPeopleList(SearchBean searchBean) {
		return dao.getPeopleList(searchBean);
	}
	
	
	//프로젝크 코드 목록 조회
	public List<GetProjectCodeBean> getProjectCode(SearchBean searchBean) {
		return dao.getProjectCode(searchBean);
	}
	
	
	//유저 기본 M/M 조회
	public List<GetDefaultMMBean> getUserDefaultMM(SearchBean searchBean) {
		return dao.getUserDefaultMM(searchBean);
	}


	//유저 M/M 중간 저장
	public int getAddUserMM(UserMMBean userMMBean) {
		return dao.getAddUserMM(userMMBean);
	}
	
	
	//유저 M/M 완료
	public int getCompleteUserMM(String i_default_mm) {
		return dao.getCompleteUserMM(i_default_mm);
	}
	
	
	//유저 M/M 미완료
	public int getInCompleteUserMM(String i_default_mm) {
		return dao.getInCompleteUserMM(i_default_mm);
	}
	
	
	//유저 M/M 중간 저장
	public int getDeleteUserMM(String i_default_mm) {
		return dao.getDeleteUserMM(i_default_mm);
	}
		
}

