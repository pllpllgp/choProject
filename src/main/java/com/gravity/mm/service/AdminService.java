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
	
	
	//���� ������Ʈ ������ ������ ������Ʈ �����ͷ� �Է�
	public int addPrevProjectCode(AddPrevMonthBean addPrevMonthBean) {
		int Result = dao.deleteProjectCode(addPrevMonthBean.getDefault_month());
		return dao.addPrevProjectCode(addPrevMonthBean);
    }
	
	
	//������Ʈ ���/�̻��
	public int getProjectCodeUse(GetProjectCodeBean getProjectCodeBean) {
		return dao.getProjectCodeUse(getProjectCodeBean);
    }
	
	
	//������Ʈ �߰�/����
	public int getProjectInsertEdit(GetProjectCodeBean getProjectCodeBean, String projectState) {
		
		int result = 0;;
		
		if(projectState.equals("projectAdd")) {
			result = dao.getProjectInsert(getProjectCodeBean);
		} else if(projectState.equals("projectEdit")) {
			result = dao.getProjectEdit(getProjectCodeBean);
		}
		
		return result;
		
    }
	
	
	//Ÿ�� �Է� ��ȸ
	public List<GetOtherPeopleBean> getOtherPeople(SearchBean searchBean) {
		return dao.getOtherPeople(searchBean);
    }
	
	
	//���� Ÿ�� �Է� ������ ������ Ÿ�� �Է����� �Է�
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
	
	
	//���� ��ȸ
	public List<GetUserBean> getUserConfirmor(String lMonth) {
		return dao.getUserConfirmor(lMonth);
    }
	
	
	//Ÿ�� �Է� �߰�/���� ����
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
	
	
	//Ÿ�� �Է� ����
	public int getOtherDelete(GetOtherPeopleBean lOtherPeople) {
		return dao.getOtherDelete(lOtherPeople);
    }
	
	
	//Ȯ���� ��ȸ
	public List<GetConfirmorBean> getConfirmor(SearchBean searchBean) {
		return dao.getConfirmor(searchBean);
    }
	
	
	//���� Ȯ���� ������ ������ Ȯ���� �����ͷ� �Է�
	public int addPrevConfirmor(AddPrevMonthBean addPrevMonthBean) {
		int Result = dao.deleteConfirmor(addPrevMonthBean.getDefault_month());
		return dao.addPrevConfirmor(addPrevMonthBean);
    }
	
	
	//����  M/M ������ ������ M/M �����ͷ� �Է�
	public int addPrevDefaultMM(AddPrevMonthBean addPrevMonthBean) {
		int Result = dao.deleteDefaultMM(addPrevMonthBean.getDefault_month());
		return dao.addPrevDefaultMM(addPrevMonthBean);
    }
	
	
	//Ȯ���� ���/����
	public int addConfirmor(GetConfirmorBean confirmorBean, String confirmorState) {
		
		int result = 0;
		
		if(confirmorState.equals("confirmorAdd")) {
			result = dao.getConfirmorAdd(confirmorBean);
			
		} else if(confirmorState.equals("confirmorEdit")) {
			result = dao.getConfirmorEdit(confirmorBean);
			
		}
		
		return result;
    }
	
	
	//Ȯ���� ����
	public int getConfirmorDelete(GetConfirmorBean confirmorBean) {
		return dao.getConfirmorDelete(confirmorBean);
    }
	
	
	//�μ� ��ȸ
	public List<GetDeptBean> getDept() {
		return dao.getDept();
    }
	
	
	//���� ��ȸ
	public List<GetUserBean> getUser() {
		return dao.getUser();
    }
	
	
	//���� �߰�/����
	public int getUserInsertEdit(GetUserBean getUserBean, String userState) {
		
		int result = 0;;
		
		if(userState.equals("userAdd")) {
			result = dao.getUserInsert(getUserBean);
		} else if(userState.equals("userEdit")) {
			result = dao.getUserEdit(getUserBean);
		}
		
		return result;
		
    }
	
	//���� ������ �߰�/����
	public int getUserAddDelete(GetUserBean getUserBean, int authCnt) {
	
		if(getUserBean.getUserSEQ() != null) {
			
			if(getUserBean.getUserAuthYN().equals("Y")) {
				
				if(authCnt == 0) {
					
					//���� ���� ������ �߰�
					dao.getAddAuth(getUserBean);
				}
			} else {
				
				if(authCnt > 0) {
					
					//���� ���� ������ ����
					dao.getDeleteAuth(getUserBean);
				}
			}
		} else {
			
			if(getUserBean.getUserAuthYN().equals("Y")) {
				
				//�ű� ���� ������ �߰�
				dao.getAddAuth(getUserBean);
			}
		}
			
		return 1;
    }
	
	
	//�� �߰�/����
	public int getTeamInsertEdit(GetDeptBean getDeptBean, String teamState) {
		
		int result = 0;;
		
		if(teamState.equals("teamAdd")) {
			
			result = dao.getTeamInsert(getDeptBean);
		} else if(teamState.equals("teamEdit")) {
			
			result = dao.getTeamEdit(getDeptBean);
		}
		
		return result;
		
    }
	
	
	//�� ����
	public int getTeamDelete(GetDeptBean getDeptBean) {
		return dao.getTeamDelete(getDeptBean);
    }
	
	
	//��¥��  M/M ��ȸ
	public List<GetDefaultMMBean> getDefaultMM(SearchBean searchBean) {
		return dao.getDefaultMM(searchBean);
    }
	
	
	//��� M/M�Է� �߰�/����
	public int getDefaultSave(DefaultMMBean defaultMMBean, String defaultState) {
		
		int result = 0;
		
		if(defaultState.equals("defaultAdd")) {
			result = dao.addDefaultMM(defaultMMBean);
			
		} else if(defaultState.equals("defaultEdit")) {
			result = dao.updateDefaultMM(defaultMMBean);
			
		}
		
		return result;
    }
	
	
	//���� �Է� ��Ȳ �Ϸ�/�̿Ϸ�
	public int getCompleteMM(ConfirmorBean confirmorBean) {
		return dao.getCompleteMM(confirmorBean);
    }
	
	
	//���� �˻�
	public List<GetUserBean> getUserSearch(SearchBean searchBean) {
		return dao.getUserSearch(searchBean);
	}
}
