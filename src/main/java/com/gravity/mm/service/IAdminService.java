package com.gravity.mm.service;

import java.util.List;

import com.gravity.mm.bean.AddPrevMonthBean;
import com.gravity.mm.bean.ConfirmorBean;
import com.gravity.mm.bean.DefaultMMBean;
import com.gravity.mm.bean.GetConfirmorBean;
import com.gravity.mm.bean.GetDefaultMMBean;
import com.gravity.mm.bean.GetDeptBean;
import com.gravity.mm.bean.GetOtherPeopleBean;
import com.gravity.mm.bean.GetProjectCodeBean;
import com.gravity.mm.bean.GetUserBean;
import com.gravity.mm.bean.SearchBean;

public interface IAdminService {
	
	//전월 프로젝트 데이터 다음월 프로젝트 데이터로 입력
	public int addPrevProjectCode(AddPrevMonthBean addPrevMonthBean);
	
	
	//프로젝트 사용/미사용
	public int getProjectCodeUse(GetProjectCodeBean arr_v_project_code);
	
	
	//프로젝트 추가/수정
	public int getProjectInsertEdit(GetProjectCodeBean getProjectCodeBean, String projectState);
	
	
	//타인 입력 조회
	public List<GetOtherPeopleBean> getOtherPeople(SearchBean searchBean);
	
	
	//유저 조회
	public List<GetUserBean> getUserConfirmor(String lMonth);
	
	
	//타인 입력 추가/수정 저장
	public int getPeopleSave(String peopleState, GetOtherPeopleBean lOtherPeople);
	
	
	//타인 입력 제거
	public int getOtherDelete(GetOtherPeopleBean lOtherPeople);
	
	
	//확인자 조회
	public List<GetConfirmorBean> getConfirmor(SearchBean searchBean);
	
	
	//전월 확인자 데이터 다음월 확인자 데이터로 입력
	public int addPrevConfirmor(AddPrevMonthBean addPrevMonthBean);
	
	
	//전월  M/M 데이터 다음월 M/M 데이터로 입력
	public int addPrevDefaultMM(AddPrevMonthBean addPrevMonthBean);
	
	
	//확인자 등록/수정
	public int addConfirmor(GetConfirmorBean confirmorBean, String confirmorState);
	
	
	//확인자 제거
	public int getConfirmorDelete(GetConfirmorBean confirmorBean);
	
	
	//부서 조회
	public List<GetDeptBean> getDept();
	
	
	//유저 조회
	public List<GetUserBean> getUser();
	
	
	//날짜로  M/M 조회
	public List<GetDefaultMMBean> getDefaultMM(SearchBean searchBean);
	
	
	//당월 M/M입력 추가/수정
	public int getDefaultSave(DefaultMMBean defaultMMBean, String defaultState);
	
	
	//팀별 입력 현황 완료/미완료
	public int getCompleteMM(ConfirmorBean confirmorBean);
	
}
