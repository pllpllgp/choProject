package com.gravity.mm.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

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
import com.gravity.mm.dao.AdminHandler;

@Service
public class AdminService implements IAdminService {

	@Inject
	AdminHandler dao;
	
	
	//전월 프로젝트 데이터 다음월 프로젝트 데이터로 입력
	public int addPrevProjectCode(AddPrevMonthBean addPrevMonthBean) {
		int Result = dao.deleteProjectCode(addPrevMonthBean.getDefault_month());
		return dao.addPrevProjectCode(addPrevMonthBean);
    }
	
	
	//프로젝트 사용/미사용
	public int getProjectCodeUse(GetProjectCodeBean getProjectCodeBean) {
		return dao.getProjectCodeUse(getProjectCodeBean);
    }
	
	
	//프로젝트 추가/수정
	public int getProjectInsertEdit(GetProjectCodeBean getProjectCodeBean, String projectState) {
		
		int result = 0;;
		
		if(projectState.equals("projectAdd")) {
			result = dao.getProjectInsert(getProjectCodeBean);
		} else if(projectState.equals("projectEdit")) {
			result = dao.getProjectEdit(getProjectCodeBean);
		}
		
		return result;
		
    }
	
	
	//타인 입력 조회
	public List<GetOtherPeopleBean> getOtherPeople(SearchBean searchBean) {
		return dao.getOtherPeople(searchBean);
    }
	
	
	//전월 타인 입력 데이터 다음월 타인 입력으로 입력
	public int addPrevOtherPeople(AddPrevMonthBean addPrevMonthBean) {
		
		int result = 0;
		
		dao.deletePrevPeople(addPrevMonthBean.getDefault_month());
		dao.deletePrevOtherPeople(addPrevMonthBean.getDefault_month());
		
		List<GetOtherPeopleBean> PrevPeopleSeq = dao.searchPrevPeople(addPrevMonthBean);
		
		GetOtherPeopleBean getOPB = new GetOtherPeopleBean();
		
		for(int i=0; i < PrevPeopleSeq.size(); i ++) {
			
			getOPB.setV_op_type(PrevPeopleSeq.get(i).getV_op_type());
			getOPB.setD_job_date(addPrevMonthBean.getDefault_month());
			getOPB.setI_user_number(PrevPeopleSeq.get(i).getI_user_number());
			getOPB.setI_to_user_number(PrevPeopleSeq.get(i).getI_to_user_number());
			
			dao.addPrevPeople(getOPB);
			dao.addPrevOtherPeople(getOPB);
			result = 1;
		}
		
		return result;
    }
	
	
	//유저 조회
	public List<GetUserBean> getUserConfirmor(String lMonth) {
		return dao.getUserConfirmor(lMonth);
    }
	
	
	//타인 입력 추가/수정 저장
	public int getPeopleSave(String peopleState, GetOtherPeopleBean lOtherPeople) {
		
		int result = 0;
		int peopleResult = 0;
		int otherPeopleResult = 0;
		
		if(peopleState.equals("add")) {
			peopleResult = dao.getPeopleAdd(lOtherPeople);
			otherPeopleResult = dao.getOtherPeopleAdd(lOtherPeople);
			
		} else if(peopleState.equals("edit")) {
			peopleResult = dao.getPeopleEdit(lOtherPeople);
			otherPeopleResult = dao.getOtherPeopleEdit(lOtherPeople);
			
		}
		
		if(peopleResult != 0 && otherPeopleResult !=0) {
			result = 1;
		}
		
		return result;
    }
	
	
	//타인 입력 제거
	public int getOtherDelete(GetOtherPeopleBean lOtherPeople) {
		return dao.getOtherDelete(lOtherPeople);
    }
	
	
	//확인자 조회
	public List<GetConfirmorBean> getConfirmor(SearchBean searchBean) {
		return dao.getConfirmor(searchBean);
    }
	
	
	//전월 확인자 데이터 다음월 확인자 데이터로 입력
	public int addPrevConfirmor(AddPrevMonthBean addPrevMonthBean) {
		int Result = dao.deleteConfirmor(addPrevMonthBean.getDefault_month());
		return dao.addPrevConfirmor(addPrevMonthBean);
    }
	
	
	//전월  M/M 데이터 다음월 M/M 데이터로 입력
	public int addPrevDefaultMM(AddPrevMonthBean addPrevMonthBean) {
		int Result = dao.deleteDefaultMM(addPrevMonthBean.getDefault_month());
		return dao.addPrevDefaultMM(addPrevMonthBean);
    }
	
	
	//확인자 등록/수정
	public int addConfirmor(GetConfirmorBean confirmorBean, String confirmorState) {
		
		int result = 0;
		
		if(confirmorState.equals("confirmorAdd")) {
			result = dao.getConfirmorAdd(confirmorBean);
			
		} else if(confirmorState.equals("confirmorEdit")) {
			result = dao.getConfirmorEdit(confirmorBean);
			
		}
		
		return result;
    }
	
	
	//확인자 제거
	public int getConfirmorDelete(GetConfirmorBean confirmorBean) {
		return dao.getConfirmorDelete(confirmorBean);
    }
	
	
	//부서 조회
	public List<GetDeptBean> getDept() {
		return dao.getDept();
    }
	
	
	//직원 조회
	public List<GetUserBean> getUser() {
		return dao.getUser();
    }
	
	
	//직원 추가/수정
	public int getUserInsertEdit(GetUserBean getUserBean, String userState) {
		
		int result = 0;;
		
		if(userState.equals("userAdd")) {
			result = dao.getUserInsert(getUserBean);
		} else if(userState.equals("userEdit")) {
			result = dao.getUserEdit(getUserBean);
		}
		
		return result;
		
    }
	
	//직원 관리자 추가/수정
	public int getUserAddDelete(GetUserBean getUserBean, int authCnt) {
	
		if(getUserBean.getUserSEQ() != null) {
			
			if(getUserBean.getUserAuthYN().equals("Y")) {
				
				if(authCnt == 0) {
					
					//기존 직원 관리자 추가
					dao.getAddAuth(getUserBean);
				}
			} else {
				
				if(authCnt > 0) {
					
					//기존 직원 관리자 삭제
					dao.getDeleteAuth(getUserBean);
				}
			}
		} else {
			
			if(getUserBean.getUserAuthYN().equals("Y")) {
				
				//신규 직원 관리자 추가
				dao.getAddAuth(getUserBean);
			}
		}
			
		return 1;
    }
	
	
	//팀 추가/수정
	public int getTeamInsertEdit(GetDeptBean getDeptBean, String teamState) {
		
		int result = 0;;
		
		if(teamState.equals("teamAdd")) {
			
			result = dao.getTeamInsert(getDeptBean);
		} else if(teamState.equals("teamEdit")) {
			
			result = dao.getTeamEdit(getDeptBean);
		}
		
		return result;
		
    }
	
	
	//팀 제거
	public int getTeamDelete(GetDeptBean getDeptBean) {
		return dao.getTeamDelete(getDeptBean);
    }
	
	
	//날짜로  M/M 조회
	public List<GetDefaultMMBean> getDefaultMM(SearchBean searchBean) {
		return dao.getDefaultMM(searchBean);
    }
	
	
	//당월 M/M입력 추가/수정
	public int getDefaultSave(DefaultMMBean defaultMMBean, String defaultState) {
		
		int result = 0;
		
		if(defaultState.equals("defaultAdd")) {
			result = dao.addDefaultMM(defaultMMBean);
			
		} else if(defaultState.equals("defaultEdit")) {
			result = dao.updateDefaultMM(defaultMMBean);
			
		}
		
		return result;
    }
	
	
	//팀별 입력 현황 완료/미완료
	public int getCompleteMM(ConfirmorBean confirmorBean) {
		return dao.getCompleteMM(confirmorBean);
    }
	
	
	//직원 검색
	public List<GetUserBean> getUserSearch(SearchBean searchBean) {
		return dao.getUserSearch(searchBean);
	}
}
