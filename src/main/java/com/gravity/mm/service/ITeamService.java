package com.gravity.mm.service;

import java.util.List;

import com.gravity.mm.bean.GetDefaultMMBean;
import com.gravity.mm.bean.GetTeamBean;
import com.gravity.mm.bean.SearchBean;


public interface ITeamService {
	
	
	//확인자 권한 체크
	public List<GetTeamBean> getConfirmorDept(SearchBean searchBean);
	
	
	//팀 종합 M/M 조회
	public List<GetDefaultMMBean> getUserProjectGroup(SearchBean searchBean);
	
	
	//팀  M/M 팀 완료
	public int getCompleteTeamMM(String i_default_mm);
	
	
	//팀 유저 seq값 찾기
	public String getTeamUserSeq(String team_user_MM_seq);

}
