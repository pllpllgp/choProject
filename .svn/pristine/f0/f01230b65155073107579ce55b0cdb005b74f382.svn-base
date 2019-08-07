package com.gravity.mm.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gravity.mm.bean.GetDefaultMMBean;
import com.gravity.mm.bean.GetProjectCodeBean;
import com.gravity.mm.bean.GetUserBean;
import com.gravity.mm.bean.SearchBean;
import com.gravity.mm.bean.UserBean;
import com.gravity.mm.bean.UserMMBean;


@Repository
public class UserHandler {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.gravity.mm.mapper.UserMapper";
	
	
	//유저 정보 조회
	public UserBean getLoginInfo(String userID) {
		return sqlSession.selectOne(NAMESPACE + ".getLoginInfo", userID);
	}
	
	
	//관리자 권한 유무 조회
	public int getAuthCheck(String userSEQ) {
		return sqlSession.selectOne(NAMESPACE + ".getAuthCheck", userSEQ);
	}
		
	
	//대리입력 유무 조회
	public List<GetUserBean> getPeopleList(SearchBean searchBean) {
		return sqlSession.selectList(NAMESPACE + ".getPeopleList", searchBean);
	}
	
	
	//프로젝크 코드 목록 조회
	public List<GetProjectCodeBean> getProjectCode(SearchBean searchBean) {
		return sqlSession.selectList(NAMESPACE + ".getProjectCode", searchBean);
	}
	
	
	//유저 기본 M/M 조회
	public List<GetDefaultMMBean> getUserDefaultMM(SearchBean searchBean) {
		return sqlSession.selectList(NAMESPACE + ".getUserDefaultMM", searchBean);
	}
	
	
	//관리자 권한 유무 조회
	public int getAddUserMM(UserMMBean userMMBean) {
		return sqlSession.insert(NAMESPACE + ".getAddUserMM", userMMBean);
	}
	
	
	//유저 M/M 완료
	public int getCompleteUserMM(String i_default_mm) {
		return sqlSession.update(NAMESPACE + ".getCompleteUserMM", i_default_mm);
	}

	
	//유저 M/M 미완료
	public int getInCompleteUserMM(String i_default_mm) {
		return sqlSession.update(NAMESPACE + ".getInCompleteUserMM", i_default_mm);
	}
	
	
	//유저 M/M 미완료
	public int getDeleteUserMM(String i_default_mm) {
		return sqlSession.delete(NAMESPACE + ".getDeleteUserMM", i_default_mm);
	}
}
