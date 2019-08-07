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
	
	//���� ������Ʈ ������ ������ ������Ʈ �����ͷ� �Է�
	public int addPrevProjectCode(AddPrevMonthBean addPrevMonthBean);
	
	
	//������Ʈ ���/�̻��
	public int getProjectCodeUse(GetProjectCodeBean arr_v_project_code);
	
	
	//������Ʈ �߰�/����
	public int getProjectInsertEdit(GetProjectCodeBean getProjectCodeBean, String projectState);
	
	
	//Ÿ�� �Է� ��ȸ
	public List<GetOtherPeopleBean> getOtherPeople(SearchBean searchBean);
	
	
	//���� ��ȸ
	public List<GetUserBean> getUserConfirmor(String lMonth);
	
	
	//Ÿ�� �Է� �߰�/���� ����
	public int getPeopleSave(String peopleState, GetOtherPeopleBean lOtherPeople);
	
	
	//Ÿ�� �Է� ����
	public int getOtherDelete(GetOtherPeopleBean lOtherPeople);
	
	
	//Ȯ���� ��ȸ
	public List<GetConfirmorBean> getConfirmor(SearchBean searchBean);
	
	
	//���� Ȯ���� ������ ������ Ȯ���� �����ͷ� �Է�
	public int addPrevConfirmor(AddPrevMonthBean addPrevMonthBean);
	
	
	//����  M/M ������ ������ M/M �����ͷ� �Է�
	public int addPrevDefaultMM(AddPrevMonthBean addPrevMonthBean);
	
	
	//Ȯ���� ���/����
	public int addConfirmor(GetConfirmorBean confirmorBean, String confirmorState);
	
	
	//Ȯ���� ����
	public int getConfirmorDelete(GetConfirmorBean confirmorBean);
	
	
	//�μ� ��ȸ
	public List<GetDeptBean> getDept();
	
	
	//���� ��ȸ
	public List<GetUserBean> getUser();
	
	
	//��¥��  M/M ��ȸ
	public List<GetDefaultMMBean> getDefaultMM(SearchBean searchBean);
	
	
	//��� M/M�Է� �߰�/����
	public int getDefaultSave(DefaultMMBean defaultMMBean, String defaultState);
	
	
	//���� �Է� ��Ȳ �Ϸ�/�̿Ϸ�
	public int getCompleteMM(ConfirmorBean confirmorBean);
	
}
