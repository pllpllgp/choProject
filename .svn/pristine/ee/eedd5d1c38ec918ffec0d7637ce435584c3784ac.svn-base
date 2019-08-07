package com.gravity.mm.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gravity.mm.bean.GetDefaultMMBean;
import com.gravity.mm.bean.GetTeamBean;
import com.gravity.mm.bean.GetUserBean;
import com.gravity.mm.bean.SearchBean;
import com.gravity.mm.bean.UserBean;


@Repository
public class TeamHandler {

	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.gravity.mm.mapper.TeamMapper";
	
	
	//확인자 권한 체크
	public List<GetTeamBean> getConfirmorDept(SearchBean searchBean) {
		return sqlSession.selectList(NAMESPACE + ".getConfirmorDept", searchBean);
	}
	
	
	//팀 종합 M/M 조회
	public List<GetDefaultMMBean> getUserProjectGroup(SearchBean searchBean) {
		return sqlSession.selectList(NAMESPACE + ".getUserProjectGroup", searchBean);
	}
	
	
	//팀  M/M 팀 완료
	public int getCompleteTeamMM(String i_default_mm) {
		return sqlSession.update(NAMESPACE + ".getCompleteTeamMM", i_default_mm);
	}
	
	
	//팀 유저 seq값 찾기
	public String getTeamUserSeq(String team_user_MM_seq) {
		return sqlSession.selectOne(NAMESPACE + ".getTeamUserSeq", team_user_MM_seq);
	}
	
}
