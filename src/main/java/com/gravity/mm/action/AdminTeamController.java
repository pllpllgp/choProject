package com.gravity.mm.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;

import com.gravity.mm.bean.ConfirmorBean;
import com.gravity.mm.bean.GetDefaultMMBean;
import com.gravity.mm.bean.GetDeptBean;
import com.gravity.mm.bean.GetProjectCodeBean;
import com.gravity.mm.bean.GetUserBean;
import com.gravity.mm.bean.SearchBean;
import com.gravity.mm.bean.UserBean;
import com.gravity.mm.bean.UserMMBean;
import com.gravity.mm.service.IAdminService;
import com.gravity.mm.service.ITeamService;
import com.gravity.mm.service.IUserService;
import com.gravity.mm.util.DateTime;
import com.gravity.mm.util.ExcelView;

@Controller
@RequestMapping("/")
public class AdminTeamController {
	
	private static Logger log = LoggerFactory.getLogger(AdminTeamController.class);
	
	@Autowired IAdminService ias;
	@Autowired IUserService ius;
	@Autowired ITeamService its;
	
	//팀별 입력 현황 페이지 접속
	@RequestMapping(value = "adminTeam", params = "methodType=normal", method = RequestMethod.POST)
	public String login(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(adminTeam) Merthod = normal <<<<<<<<<<<<<<<<<<<");
		
		
		model.addAttribute("userBean", userBean);
		model.addAttribute("urlPage", "adminTeam");
		
		return "admin/adminTeam";
	}
	
	
	//팀별 입력 현황 페이지 조회
	@RequestMapping(value = "adminTeam", params = "methodType=search", method = RequestMethod.POST)
	public String search(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
			
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(adminTeam) Merthod = search <<<<<<<<<<<<<<<<<<<");
		
		adminTeamRepeatedSearch(request, userBean, searchBean, model);
		
		return "admin/adminTeam";
	}
	
	
	//팀별 입력 현황 완료/미완료
	@RequestMapping(value = "adminTeam", params = "methodType=completeYN", method = RequestMethod.POST)
	public String completeYN(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
		
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(adminTeam) Merthod = completeYN <<<<<<<<<<<<<<<<<<<");
		
		String i_seq_pk 							= request.getParameter("check_MM_seq");
		String v_disable 								= request.getParameter("disable");
		
		ConfirmorBean confirmorBean = new ConfirmorBean();
		
		confirmorBean.setI_seq_pk(i_seq_pk);
		confirmorBean.setV_disable(v_disable);
		
		int iResult = ias.getCompleteMM(confirmorBean);
		
		adminTeamRepeatedSearch(request, userBean, searchBean, model);
		
		return "admin/adminTeam";
	}
	
	
	//팀별 입력 현황 M/M 입력 팝업창
	@RequestMapping(value = "adminTeam", params = "methodType=write", method = RequestMethod.GET)
	public String MMWrite(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
				
		log.info(">>>>>>>>>>>>>>>>>>>adminMM(adminTeam) Merthod = write <<<<<<<<<<<<<<<<<<<");
			
		SearchBean searchBean			= new SearchBean();
		String search_date 				= request.getParameter("search_date");
		String userSEQ	 				= request.getParameter("userSEQ");
		String userMM	 				= request.getParameter("userMM");
		
		searchBean.setSearch_user_seq(userSEQ);
		searchBean.setSearch_date(search_date);
		
		log.info("userSEQ : " + userSEQ);
		log.info("userMM : " + userMM);
		
		searchBean.setProject_user_flag("Y");
		List<GetProjectCodeBean> lProjectCode = ius.getProjectCode(searchBean);
		List<GetDefaultMMBean> lUserDefaultMM = ius.getUserDefaultMM(searchBean);
		
		model.addAttribute("lUserDefaultMM", lUserDefaultMM);
		model.addAttribute("lProjectCode", lProjectCode);
		model.addAttribute("search_date", search_date);
		model.addAttribute("project_user_SEQ", userSEQ);
		model.addAttribute("project_user_MM", userMM);
		model.addAttribute("urlPage", "adminTeam");
		
		return "admin/writeAdminTeam";

	}
	
	
	//유저 M/M 중간 저장
	@RequestMapping(value = "adminTeam", params = "methodType=save", method = RequestMethod.POST)
	public String MMSave(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
					
		log.info(">>>>>>>>>>>>>>>>>>>adminMM(adminTeam) Merthod = save <<<<<<<<<<<<<<<<<<<");
			
		String i_default_mm				= request.getParameter("project_user_MM_SEQ");
		String project_SEQ 				= request.getParameter("project_SEQ");
		String project_MM 				= request.getParameter("project_MM");
		
		String[] projectSEQ				= project_SEQ.split(",");
		String[] projectMM				= project_MM.split(",");
		
		//데이터 전부 삭제 후 새로 저장
		int iResult = ius.getDeleteUserMM(i_default_mm);
			
		for(int i=0; projectMM.length > i; i++) {
			UserMMBean userMMBeans	= new UserMMBean();
				
			userMMBeans.setI_default_mm(i_default_mm);
			userMMBeans.setI_project_code_pk(projectSEQ[i]);
			userMMBeans.setD_mm_user(projectMM[i]);
			
			System.out.println("projectSEQ[i] : " + projectSEQ[i]);
			
			int uResult = ius.getAddUserMM(userMMBeans);
		}
		
		//유저 M/M 조회
		adminTeamRepeatedSearch(request, userBean, searchBean, model);
			
		return "admin/adminTeam";

	}
	
	
	//해당 목록 Excel 다운로드
	@RequestMapping(value = "adminTeam", params = "methodType=excel", method = RequestMethod.POST)
	public View excelDown(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
				
		log.info(">>>>>>>>>>>>>>>>>>>adminMM(adminTeam) Merthod = excelDownload <<<<<<<<<<<<<<<<<<<");
			
		String adminTeamMMSEQ						= request.getParameter("adminTeamMMSEQ");
		String search_user_seq						= "";
		
		if(adminTeamMMSEQ.equals("")) {
			String search_dept_seq 					= request.getParameter("search_dept_seq");
			searchBean.setSearch_dept_seq(search_dept_seq);
		} else {
			String[] admin_team_MM_seq 				= adminTeamMMSEQ.split(",");
			
			for(int i=0; admin_team_MM_seq.length > i; i++) {
				
				String user_seq = its.getTeamUserSeq(admin_team_MM_seq[i]);
				search_user_seq += user_seq + ",";
			}
		}
		
		searchBean.setSearch_date(searchBean.getSearch_date());
		
		List<GetDefaultMMBean> lUserDefaultMM 		= ius.getUserDefaultMM(searchBean);
		
		model.addAttribute("search_date", searchBean.getSearch_date());
		model.addAttribute("search_user_seq", search_user_seq);
		model.addAttribute("lUserDefaultMM", lUserDefaultMM);
		model.addAttribute("excelType", "adminTeamExcel");
		
		return new ExcelView();

	}
	
	
	//세팅값으로 조회(반복 사용)
	public String adminTeamRepeatedSearch(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
									
		log.info(">>>>>>>>>>>>>>>>>>>adminMM(adminTeam) Merthod = adminTeamRepeatedSearch <<<<<<<<<<<<<<<<<<<");
		
		String search_date 							= request.getParameter("search_date");
		String search_dept_seq 						= request.getParameter("search_dept_seq");
		String search_user_seq 						= request.getParameter("search_user_seq");
		String project_user_flag 					= request.getParameter("project_user_flag");
		
		searchBean.setSearch_date(search_date);
		searchBean.setSearch_dept_seq(search_dept_seq);
		searchBean.setSearch_user_seq(search_user_seq);
		searchBean.setProject_user_flag(project_user_flag);
		
		List<GetProjectCodeBean> lProjectCode 		= ius.getProjectCode(searchBean);
		List<GetDefaultMMBean> lUserDefaultMM 		= ius.getUserDefaultMM(searchBean);
		List<GetDefaultMMBean> lUserProjectGroup 	= its.getUserProjectGroup(searchBean);
		
		model.addAttribute("lProjectCode", lProjectCode);
		model.addAttribute("lUserDefaultMM", lUserDefaultMM);
		model.addAttribute("lUserProjectGroup", lUserProjectGroup);
		model.addAttribute("userBean", userBean);
		model.addAttribute("searchBean", searchBean);
		model.addAttribute("urlPage", "adminTeam");
		
		return "Y";

	}
	
	
	//날짜 검색
	@ModelAttribute("lMonth")
	public List<String> lMonth() throws Exception {
		String user = "admin";
		return DateTime.getMonthList(user);
	}
	
	
	//부서 조회
	@ModelAttribute("lDept")
	public List<GetDeptBean> lDept() throws Exception {
		List<GetDeptBean> lDept = ias.getDept();
		return lDept;
	}
	
	
	//유저 조회
	@ModelAttribute("lUser")
	public List<GetUserBean> lUser() throws Exception {
		List<GetUserBean> lUser = ias.getUser();
		return lUser;
	}

}
