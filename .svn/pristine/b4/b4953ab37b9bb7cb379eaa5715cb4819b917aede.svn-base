package com.gravity.mm.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gravity.mm.bean.GetDefaultMMBean;
import com.gravity.mm.bean.GetTeamBean;
import com.gravity.mm.bean.SearchBean;
import com.gravity.mm.dao.TeamHandler;

@Service
public class TeamService implements ITeamService {
	
	@Inject
	TeamHandler dao;
	
	
	//확인자 권한 체크
	public List<GetTeamBean> getConfirmorDept(SearchBean searchBean) {
		return dao.getConfirmorDept(searchBean);
    }
	
	
	//팀 종합 M/M 조회
	public List<GetDefaultMMBean> getUserProjectGroup(SearchBean searchBean) {
		return dao.getUserProjectGroup(searchBean);
    }
	
	
	//팀  M/M 팀 완료
	public int getCompleteTeamMM(String i_default_mm) {
		return dao.getCompleteTeamMM(i_default_mm);
    }
	
	
	//팀 유저 seq값 찾기
	public String getTeamUserSeq(String team_user_MM_seq) {
		return dao.getTeamUserSeq(team_user_MM_seq);
    }

}
