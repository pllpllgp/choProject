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
	
	
	//다음월 프로젝트 데이터 삭제
	public int deleteProjectCode(String default_month) {
		return sqlSession.delete(NAMESPACE + ".deleteProjectCode", default_month);
	}
	
	
	//전월 프로젝트 데이터 다음월 프로젝트 데이터로 입력
	public int addPrevProjectCode(AddPrevMonthBean addPrevMonthBean) {
		return sqlSession.insert(NAMESPACE + ".addPrevProjectCode", addPrevMonthBean);
	}
	
	
	//프로젝트 사용/미사용
	public int getProjectCodeUse(GetProjectCodeBean getProjectCodeBean) {
		return sqlSession.update(NAMESPACE + ".getProjectCodeUse", getProjectCodeBean);
	}
	
	
	//프로젝트 추가
	public int getProjectInsert(GetProjectCodeBean getProjectCodeBean) {
		return sqlSession.insert(NAMESPACE + ".getProjectInsert", getProjectCodeBean);
	}
	
	
	//프로젝트 수정
	public int getProjectEdit(GetProjectCodeBean getProjectCodeBean) {
		return sqlSession.update(NAMESPACE + ".getProjectEdit", getProjectCodeBean);
	}
	
	
	//타인 입력 조회
	public List<GetOtherPeopleBean> getOtherPeople(SearchBean searchBean) {
		return sqlSession.selectList(NAMESPACE + ".getOtherPeople", searchBean);
	}
	
	
	//다음월 타인입력 데이터 삭제
	public int deletePrevPeople(String default_month) {
		return sqlSession.update(NAMESPACE + ".deletePrevPeople", default_month);
	}
	
	
	//다음월 타인입력 지정자 데이터 삭제
	public int deletePrevOtherPeople(String default_month) {
		return sqlSession.delete(NAMESPACE + ".deletePrevOtherPeople", default_month);
	}
	
	
	//전월 타인 지정자 & 전월 타인 입력 지정자 데이터 다음월 데이터로 입력
	public List<GetOtherPeopleBean> searchPrevPeople(AddPrevMonthBean addPrevMonthBean) {
		return sqlSession.selectList(NAMESPACE + ".searchPrevPeople", addPrevMonthBean);
	}
	
	
	//전월 타인입력 데이터 다음월 타인입력 데이터로 입력
	public int addPrevPeople(GetOtherPeopleBean addPrevMonthBean) {
		return sqlSession.insert(NAMESPACE + ".addPrevPeople", addPrevMonthBean);
	}
	
	
	//전월 타인입력 지정자 데이터 다음월 타인입력 지정자 데이터로 입력
	public int addPrevOtherPeople(GetOtherPeopleBean GetOtherPeopleBean) {
		return sqlSession.insert(NAMESPACE + ".addPrevOtherPeople", GetOtherPeopleBean);
	}
		
	
	//유저 조회
	public List<GetUserBean> getUserConfirmor(String lMonth) {
		return sqlSession.selectList(NAMESPACE + ".getUserConfirmor", lMonth);
	}
	
	
	//타입 입력 저장
	public int getPeopleAdd(GetOtherPeopleBean lOtherPeople) {
		return sqlSession.insert(NAMESPACE + ".getPeopleAdd", lOtherPeople);
	}
	
	
	//타입 입력 지정자 저장
	public int getOtherPeopleAdd(GetOtherPeopleBean lOtherPeople) {
		return sqlSession.insert(NAMESPACE + ".getOtherPeopleAdd", lOtherPeople);
	}
	
	
	//타입 입력 수정
	public int getPeopleEdit(GetOtherPeopleBean lOtherPeople) {
		return sqlSession.update(NAMESPACE + ".getPeopleEdit", lOtherPeople);
	}
	
	
	//타입 입력 지정자 수정
	public int getOtherPeopleEdit(GetOtherPeopleBean lOtherPeople) {
		return sqlSession.update(NAMESPACE + ".getOtherPeopleEdit", lOtherPeople);
	}
	
	
	//타입 입력 제거
	public int getOtherDelete(GetOtherPeopleBean lOtherPeople) {
		return sqlSession.update(NAMESPACE + ".getOtherDelete", lOtherPeople);
	}
	
	
	//확인자 조회
	public List<GetConfirmorBean> getConfirmor(SearchBean searchBean) {
		return sqlSession.selectList(NAMESPACE + ".getConfirmor", searchBean);
	}
	
	
	//다음월 확인자 데이터 삭제
	public int deleteConfirmor(String default_month) {
		return sqlSession.delete(NAMESPACE + ".deleteConfirmor", default_month);
	}
	
	
	//전월 확인자 데이터 다음월 확인자 데이터로 입력
	public int addPrevConfirmor(AddPrevMonthBean addPrevMonthBean) {
		return sqlSession.insert(NAMESPACE + ".addPrevConfirmor", addPrevMonthBean);
	}
	
	
	//다음월 M/M 데이터 삭제
	public int deleteDefaultMM(String default_month) {
		return sqlSession.delete(NAMESPACE + ".deleteDefaultMM", default_month);
	}
	
	
	//전월  M/M 데이터 다음월 M/M 데이터로 입력
	public int addPrevDefaultMM(AddPrevMonthBean addPrevMonthBean) {
		return sqlSession.insert(NAMESPACE + ".addPrevDefaultMM", addPrevMonthBean);
	}
	
	
	//확인자 데이터 등록
	public int getConfirmorAdd(GetConfirmorBean confirmorBean) {
		return sqlSession.insert(NAMESPACE + ".getConfirmorAdd", confirmorBean);
	}
	
	
	//확인자 데이터 수정
	public int getConfirmorEdit(GetConfirmorBean confirmorBean) {
		return sqlSession.update(NAMESPACE + ".getConfirmorEdit", confirmorBean);
	}
	
	
	//확인자 데이터 삭제
	public int getConfirmorDelete(GetConfirmorBean confirmorBean) {
		return sqlSession.update(NAMESPACE + ".getConfirmorDelete", confirmorBean);
	}
	
	
	//부서 조회
	public List<GetDeptBean> getDept() {
		return sqlSession.selectList(NAMESPACE + ".getDept");
	}
	
	
	//직원 조회
	public List<GetUserBean> getUser() {
		return sqlSession.selectList(NAMESPACE + ".getUser");
	}
	
	
	//직원 추가
	public int getUserInsert(GetUserBean getUserBean) {
		return sqlSession.insert(NAMESPACE + ".getUserInsert", getUserBean);
	}
	
	
	//직원 수정
	public int getUserEdit(GetUserBean getUserBean) {
		return sqlSession.update(NAMESPACE + ".getUserEdit", getUserBean);
	}
	
	
	//직원 관리자 추가
	public int getAddAuth(GetUserBean getUserBean) {
		return sqlSession.insert(NAMESPACE + ".getAddAuth", getUserBean);
	}
	
	
	//직원 관리자 삭제
	public int getDeleteAuth(GetUserBean getUserBean) {
		return sqlSession.delete(NAMESPACE + ".getDeleteAuth", getUserBean);
	}
	
	
	//팀 추가
	public int getTeamInsert(GetDeptBean getDeptBean) {
		return sqlSession.insert(NAMESPACE + ".getTeamInsert", getDeptBean);
	}
	
	
	//팀 수정
	public int getTeamEdit(GetDeptBean getDeptBean) {
		return sqlSession.update(NAMESPACE + ".getTeamEdit", getDeptBean);
	}
	
	
	//팀 삭제
	public int getTeamDelete(GetDeptBean getDeptBean) {
		return sqlSession.update(NAMESPACE + ".getTeamDelete", getDeptBean);
	}
	
	
	//날짜로  M/M 조회
	public List<GetDefaultMMBean> getDefaultMM(SearchBean searchBean) {
		return sqlSession.selectList(NAMESPACE + ".getDefaultMM", searchBean);
	}
	
	
	//당월 M/M 데이터 추가
	public int addDefaultMM(DefaultMMBean defaultMMBean) {
		return sqlSession.insert(NAMESPACE + ".addDefaultMM", defaultMMBean);
	}
	
	
	//당월 M/M 데이터 수정
	public int updateDefaultMM(DefaultMMBean defaultMMBean) {
		return sqlSession.update(NAMESPACE + ".updateDefaultMM", defaultMMBean);
	}
	
	
	//팀별 입력 현황 완료/미완료
	public int getCompleteMM(ConfirmorBean confirmorBean) {
		return sqlSession.update(NAMESPACE + ".getCompleteMM", confirmorBean);
	}
	
	
	//직원 검색
	public List<GetUserBean> getUserSearch(SearchBean searchBean) {
		return sqlSession.selectList(NAMESPACE + ".getUserSearch", searchBean);
	}

}
