package com.gravity.mm.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

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


@Repository
public class AdminHandler {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.gravity.mm.mapper.AdminMapper";
	
	
	//������ ������Ʈ ������ ����
	public int deleteProjectCode(String default_month) {
		return sqlSession.delete(NAMESPACE + ".deleteProjectCode", default_month);
	}
	
	
	//���� ������Ʈ ������ ������ ������Ʈ �����ͷ� �Է�
	public int addPrevProjectCode(AddPrevMonthBean addPrevMonthBean) {
		return sqlSession.insert(NAMESPACE + ".addPrevProjectCode", addPrevMonthBean);
	}
	
	
	//������Ʈ ���/�̻��
	public int getProjectCodeUse(GetProjectCodeBean getProjectCodeBean) {
		return sqlSession.update(NAMESPACE + ".getProjectCodeUse", getProjectCodeBean);
	}
	
	
	//������Ʈ �߰�
	public int getProjectInsert(GetProjectCodeBean getProjectCodeBean) {
		return sqlSession.insert(NAMESPACE + ".getProjectInsert", getProjectCodeBean);
	}
	
	
	//������Ʈ ����
	public int getProjectEdit(GetProjectCodeBean getProjectCodeBean) {
		return sqlSession.update(NAMESPACE + ".getProjectEdit", getProjectCodeBean);
	}
	
	
	//Ÿ�� �Է� ��ȸ
	public List<GetOtherPeopleBean> getOtherPeople(SearchBean searchBean) {
		return sqlSession.selectList(NAMESPACE + ".getOtherPeople", searchBean);
	}
	
	
	//������ Ÿ���Է� ������ ����
	public int deletePrevPeople(String default_month) {
		return sqlSession.update(NAMESPACE + ".deletePrevPeople", default_month);
	}
	
	
	//������ Ÿ���Է� ������ ������ ����
	public int deletePrevOtherPeople(String default_month) {
		return sqlSession.delete(NAMESPACE + ".deletePrevOtherPeople", default_month);
	}
	
	
	//���� Ÿ�� ������ & ���� Ÿ�� �Է� ������ ������ ������ �����ͷ� �Է�
	public List<GetOtherPeopleBean> searchPrevPeople(AddPrevMonthBean addPrevMonthBean) {
		return sqlSession.selectList(NAMESPACE + ".searchPrevPeople", addPrevMonthBean);
	}
	
	
	//���� Ÿ���Է� ������ ������ Ÿ���Է� �����ͷ� �Է�
	public int addPrevPeople(GetOtherPeopleBean addPrevMonthBean) {
		return sqlSession.insert(NAMESPACE + ".addPrevPeople", addPrevMonthBean);
	}
	
	
	//���� Ÿ���Է� ������ ������ ������ Ÿ���Է� ������ �����ͷ� �Է�
	public int addPrevOtherPeople(GetOtherPeopleBean GetOtherPeopleBean) {
		return sqlSession.insert(NAMESPACE + ".addPrevOtherPeople", GetOtherPeopleBean);
	}
		
	
	//���� ��ȸ
	public List<GetUserBean> getUserConfirmor(String lMonth) {
		return sqlSession.selectList(NAMESPACE + ".getUserConfirmor", lMonth);
	}
	
	
	//Ÿ�� �Է� ����
	public int getPeopleAdd(GetOtherPeopleBean lOtherPeople) {
		return sqlSession.insert(NAMESPACE + ".getPeopleAdd", lOtherPeople);
	}
	
	
	//Ÿ�� �Է� ������ ����
	public int getOtherPeopleAdd(GetOtherPeopleBean lOtherPeople) {
		return sqlSession.insert(NAMESPACE + ".getOtherPeopleAdd", lOtherPeople);
	}
	
	
	//Ÿ�� �Է� ����
	public int getPeopleEdit(GetOtherPeopleBean lOtherPeople) {
		return sqlSession.update(NAMESPACE + ".getPeopleEdit", lOtherPeople);
	}
	
	
	//Ÿ�� �Է� ������ ����
	public int getOtherPeopleEdit(GetOtherPeopleBean lOtherPeople) {
		return sqlSession.update(NAMESPACE + ".getOtherPeopleEdit", lOtherPeople);
	}
	
	
	//Ÿ�� �Է� ����
	public int getOtherDelete(GetOtherPeopleBean lOtherPeople) {
		return sqlSession.update(NAMESPACE + ".getOtherDelete", lOtherPeople);
	}
	
	
	//Ȯ���� ��ȸ
	public List<GetConfirmorBean> getConfirmor(SearchBean searchBean) {
		return sqlSession.selectList(NAMESPACE + ".getConfirmor", searchBean);
	}
	
	
	//������ Ȯ���� ������ ����
	public int deleteConfirmor(String default_month) {
		return sqlSession.delete(NAMESPACE + ".deleteConfirmor", default_month);
	}
	
	
	//���� Ȯ���� ������ ������ Ȯ���� �����ͷ� �Է�
	public int addPrevConfirmor(AddPrevMonthBean addPrevMonthBean) {
		return sqlSession.insert(NAMESPACE + ".addPrevConfirmor", addPrevMonthBean);
	}
	
	
	//������ M/M ������ ����
	public int deleteDefaultMM(String default_month) {
		return sqlSession.delete(NAMESPACE + ".deleteDefaultMM", default_month);
	}
	
	
	//����  M/M ������ ������ M/M �����ͷ� �Է�
	public int addPrevDefaultMM(AddPrevMonthBean addPrevMonthBean) {
		return sqlSession.insert(NAMESPACE + ".addPrevDefaultMM", addPrevMonthBean);
	}
	
	
	//Ȯ���� ������ ���
	public int getConfirmorAdd(GetConfirmorBean confirmorBean) {
		return sqlSession.insert(NAMESPACE + ".getConfirmorAdd", confirmorBean);
	}
	
	
	//Ȯ���� ������ ����
	public int getConfirmorEdit(GetConfirmorBean confirmorBean) {
		return sqlSession.update(NAMESPACE + ".getConfirmorEdit", confirmorBean);
	}
	
	
	//Ȯ���� ������ ����
	public int getConfirmorDelete(GetConfirmorBean confirmorBean) {
		return sqlSession.update(NAMESPACE + ".getConfirmorDelete", confirmorBean);
	}
	
	
	//�μ� ��ȸ
	public List<GetDeptBean> getDept() {
		return sqlSession.selectList(NAMESPACE + ".getDept");
	}
	
	
	//���� ��ȸ
	public List<GetUserBean> getUser() {
		return sqlSession.selectList(NAMESPACE + ".getUser");
	}
	
	
	//���� �߰�
	public int getUserInsert(GetUserBean getUserBean) {
		return sqlSession.insert(NAMESPACE + ".getUserInsert", getUserBean);
	}
	
	
	//���� ����
	public int getUserEdit(GetUserBean getUserBean) {
		return sqlSession.update(NAMESPACE + ".getUserEdit", getUserBean);
	}
	
	
	//���� ������ �߰�
	public int getAddAuth(GetUserBean getUserBean) {
		return sqlSession.insert(NAMESPACE + ".getAddAuth", getUserBean);
	}
	
	
	//���� ������ ����
	public int getDeleteAuth(GetUserBean getUserBean) {
		return sqlSession.delete(NAMESPACE + ".getDeleteAuth", getUserBean);
	}
	
	
	//�� �߰�
	public int getTeamInsert(GetDeptBean getDeptBean) {
		return sqlSession.insert(NAMESPACE + ".getTeamInsert", getDeptBean);
	}
	
	
	//�� ����
	public int getTeamEdit(GetDeptBean getDeptBean) {
		return sqlSession.update(NAMESPACE + ".getTeamEdit", getDeptBean);
	}
	
	
	//�� ����
	public int getTeamDelete(GetDeptBean getDeptBean) {
		return sqlSession.update(NAMESPACE + ".getTeamDelete", getDeptBean);
	}
	
	
	//��¥��  M/M ��ȸ
	public List<GetDefaultMMBean> getDefaultMM(SearchBean searchBean) {
		return sqlSession.selectList(NAMESPACE + ".getDefaultMM", searchBean);
	}
	
	
	//��� M/M ������ �߰�
	public int addDefaultMM(DefaultMMBean defaultMMBean) {
		return sqlSession.insert(NAMESPACE + ".addDefaultMM", defaultMMBean);
	}
	
	
	//��� M/M ������ ����
	public int updateDefaultMM(DefaultMMBean defaultMMBean) {
		return sqlSession.update(NAMESPACE + ".updateDefaultMM", defaultMMBean);
	}
	
	
	//���� �Է� ��Ȳ �Ϸ�/�̿Ϸ�
	public int getCompleteMM(ConfirmorBean confirmorBean) {
		return sqlSession.update(NAMESPACE + ".getCompleteMM", confirmorBean);
	}
	
	
	//���� �˻�
	public List<GetUserBean> getUserSearch(SearchBean searchBean) {
		return sqlSession.selectList(NAMESPACE + ".getUserSearch", searchBean);
	}

}
