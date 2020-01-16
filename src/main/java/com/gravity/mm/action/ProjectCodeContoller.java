package com.gravity.mm.action;

import java.util.ArrayList;
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

import com.gravity.mm.bean.AddPrevMonthBean;
import com.gravity.mm.bean.GetProjectCodeBean;
import com.gravity.mm.bean.SearchBean;
import com.gravity.mm.bean.UserBean;
import com.gravity.mm.service.IAdminService;
import com.gravity.mm.service.ITeamService;
import com.gravity.mm.service.IUserService;
import com.gravity.mm.util.DateTime;
import com.gravity.mm.util.ExcelView;

@Controller
@RequestMapping("/")
public class ProjectCodeContoller {
	
	private static Logger log = LoggerFactory.getLogger(ProjectCodeContoller.class);
	
	@Autowired ITeamService its;
	@Autowired IUserService ius;
	@Autowired IAdminService ias;
	
	@RequestMapping(value = "projectCode", params = "methodType=normal", method = RequestMethod.POST)
	public String projectCode(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(projectCode) Merthod = normal <<<<<<<<<<<<<<<<<<<");
		log.info("userBean > " + userBean.getUserID());
		
		model.addAttribute("userBean", userBean);
		model.addAttribute("urlPage", "projectCode");
		
		return "admin/projectCode";

	}
	
	
	//날짜 및 특정 프로젝트 검색
	@RequestMapping(value = "projectCode", params = "methodType=search", method = RequestMethod.POST)
	public String dateChoice(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(projectCode) Merthod = projectSearch <<<<<<<<<<<<<<<<<<<");
		
		SearchBean searchBean						= new SearchBean();
		
		String search_date 							= request.getParameter("search_date");
		String search_project_seq 					= request.getParameter("search_project_seq");
		String project_user_flag 					= request.getParameter("project_user_flag");
		
		searchBean.setSearch_date(search_date);
		searchBean.setProject_user_flag(project_user_flag);
		
		if(!search_project_seq.equals("")) {
			searchBean.setSearch_project_seq(search_project_seq);
			
		}
		
		List<GetProjectCodeBean> lProjectCode 		= ius.getProjectCode(searchBean);
		
		model.addAttribute("userBean", userBean);
		model.addAttribute("searchBean", searchBean);
		model.addAttribute("lProjectCode", lProjectCode);
		model.addAttribute("urlPage", "projectCode");
		
		return "admin/projectCode";

	}
	
	
	//전월 프로젝트 데이터 가져와서 새로 입력
	@RequestMapping(value = "projectCode", params = "methodType=addPrev", method = RequestMethod.POST)
	public String addPrevProject(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
		
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(projectCode) Merthod = addPrevMonth <<<<<<<<<<<<<<<<<<<");
		
		String prev_month 			= request.getParameter("prev_month")+"-01";
		String default_month 		= request.getParameter("default_month")+"-01";
		
		AddPrevMonthBean addPrevMonthBean		= new AddPrevMonthBean();

		addPrevMonthBean.setPrev_month(prev_month);
		addPrevMonthBean.setDefault_month(default_month);
		
		log.info(">>>>>>>>>>>>>>>>>>> prev_month <<<<<<<<<<<<<<<<<<<" + prev_month);
		log.info(">>>>>>>>>>>>>>>>>>> default_month <<<<<<<<<<<<<<<<<<<" + default_month);
		
		int iResult = ias.addPrevProjectCode(addPrevMonthBean);
		
		return "admin/projectCode";

	}
	
	
	//프로젝트 사용 유무 변경
	@RequestMapping(value = "projectCode", params = "methodType=projectUse", method = RequestMethod.POST)
	public String projectUseYN(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
		
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(projectCode) Merthod = projectUse <<<<<<<<<<<<<<<<<<<");
		
		GetProjectCodeBean getProjectCodeBean = new GetProjectCodeBean();
		
		String projectSeq 					= request.getParameter("projectSeq");
		String v_disable 					= request.getParameter("projectUseYN");
		String[] arr_v_project_code 		= projectSeq.split(",");
		
		log.info(">>>>>>>>>>>>>>>>>>> v_disable <<<<<<<<<<<<<<<<<<<" + v_disable);
		log.info(">>>>>>>>>>>>>>>>>>> projectSeqe <<<<<<<<<<<<<<<<<<<" + projectSeq);
		
		getProjectCodeBean.setArr_v_project_code(arr_v_project_code);
		getProjectCodeBean.setV_disable(v_disable);
		
		ias.getProjectCodeUse(getProjectCodeBean);
		
		projectRepeatedSearch(request, userBean, searchBean, model);	
		
		return "admin/projectCode";

	}
	
	
	//해당 목록 Excel 다운로드
	@RequestMapping(value = "projectCode", params = "methodType=excel", method = RequestMethod.POST)
	public View excelDown(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
				
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(projectCode) Merthod = excelDownload <<<<<<<<<<<<<<<<<<<");
			
		String search_date 							= request.getParameter("search_date");
		String search_project_seq 					= request.getParameter("search_project_seq");
		String projectCodeSEQ 						= request.getParameter("projectCodeSEQ");
		String project_user_flag 					= request.getParameter("project_user_flag");
		
		searchBean.setSearch_date(search_date);
		searchBean.setProject_user_flag(project_user_flag);
		
		if(!search_project_seq.equals("")) {
			
			searchBean.setSearch_project_seq(search_project_seq);
		}
		
		List<GetProjectCodeBean> lProjectCode 		= ius.getProjectCode(searchBean);
		
		model.addAttribute("userBean", userBean);
		model.addAttribute("searchBean", searchBean);
		model.addAttribute("lProjectCode", lProjectCode);
		model.addAttribute("projectCodeSEQ", projectCodeSEQ);
		model.addAttribute("excelType", "adminProjectCodeExcel");
		
		return new ExcelView();

	}
	
	
	//프로젝트 추가/수정 저장
	@RequestMapping(value = "projectCode", params = "methodType=save", method = RequestMethod.POST)
	public String projectInsertEdit(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
									
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(projectCode) Merthod = save <<<<<<<<<<<<<<<<<<<");
		
		ArrayList<GetProjectCodeBean> list = new ArrayList<GetProjectCodeBean>();
		
		String projectState 						= request.getParameter("projectState");
		String addProjectDate 						= request.getParameter("addProjectDate")+"-01";
		String projectUseYN 						= request.getParameter("projectUseYN");
		String addProjectSeq 						= request.getParameter("addProjectSeq");
		String addProjectName		 				= request.getParameter("addProjectName");
		String addProjectCode		 				= request.getParameter("addProjectCode");
		
		GetProjectCodeBean getProjectCodeBean = new GetProjectCodeBean();
		
		if(!addProjectSeq.equals("")) {
			getProjectCodeBean.setI_seq_pk(Integer.parseInt(addProjectSeq));
		}
		
		getProjectCodeBean.setD_job_date(addProjectDate);
		getProjectCodeBean.setV_disable(projectUseYN);
		getProjectCodeBean.setV_project_name(addProjectName);
		getProjectCodeBean.setV_project_code(addProjectCode);
		
		ias.getProjectInsertEdit(getProjectCodeBean, projectState);
		
		if(!searchBean.getSearch_date().equals("")) {
			String result = projectRepeatedSearch(request, userBean, searchBean, model);
		}
		
		return "admin/projectCode";
	}
	
	
	//세팅값으로 프로젝트 조회(반복 사용)
	public String projectRepeatedSearch(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
									
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(projectCode) Merthod = projectRepeatedSearch <<<<<<<<<<<<<<<<<<<");
		
		String search_date 							= request.getParameter("search_date");
		String search_project_seq 					= request.getParameter("search_project_seq");
		String project_user_flag 					= request.getParameter("project_user_flag");
		
		searchBean.setSearch_date(search_date);
		searchBean.setProject_user_flag(project_user_flag);
		
		if(!search_project_seq.equals("")) {
			
			searchBean.setSearch_project_seq(search_project_seq);
		}
		
		List<GetProjectCodeBean> lProjectCode 		= ius.getProjectCode(searchBean);
		
		model.addAttribute("userBean", userBean);
		model.addAttribute("searchBean", searchBean);
		model.addAttribute("lProjectCode", lProjectCode);
		model.addAttribute("urlPage", "projectCode");
		
		return "Y";

	}
	
	
	//날짜 검색
	@ModelAttribute("lMonth")
	public List<String> lMonth() throws Exception {
		String user = "admin";
		return DateTime.getMonthList(user);
	}

}
