package com.gravity.mm.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;

import com.gravity.mm.bean.GetDefaultMMBean;
import com.gravity.mm.bean.GetProjectCodeBean;
import com.gravity.mm.bean.GetTeamBean;
import com.gravity.mm.bean.GetUserBean;
import com.gravity.mm.bean.SearchBean;
import com.gravity.mm.bean.UserBean;
import com.gravity.mm.bean.UserMMBean;
import com.gravity.mm.service.ITeamService;
import com.gravity.mm.service.IUserService;
import com.gravity.mm.util.DateTime;
import com.gravity.mm.util.ExcelView;

@Controller
@RequestMapping("/")
public class TeamController {
	
	private static Logger LOG = Logger.getLogger(TeamController.class);
	
	@Autowired ITeamService its;
	@Autowired IUserService ius;
	
	//확인자 페이지 처음 접속
	@RequestMapping(value = "teamMM", params = "methodType=normal", method = RequestMethod.POST)
	public String team(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> TeamMM Merthod = normal <<<<<<<<<<<<<<<<<<<");
		
		System.out.println("userBean > " + userBean.getUserID());
		
		model.addAttribute("userBean", userBean);
		
		return "team/teamMM";

	}
	
	
	//날짜로 부서 조회
	@RequestMapping(value = "teamMM", params = "methodType=dateSearch", method = RequestMethod.POST)
	public String dateChoice(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
			
		System.out.println(">>>>>>>>>>>>>>>>>>> TeamMM Merthod = dateSearch <<<<<<<<<<<<<<<<<<<");
		
		SearchBean searchBean		= new SearchBean();
			
		String search_date 			= request.getParameter("search_date");
		
		searchBean.setSearch_user_seq(userBean.getUserSEQ());
		searchBean.setSearch_date(search_date);
		
		List<GetTeamBean> lTeam = its.getConfirmorDept(searchBean);
		
		model.addAttribute("lTeam", lTeam);
		model.addAttribute("userBean", userBean);
		model.addAttribute("searchBean", searchBean);
			
		return "team/teamMM";

	}
	
	
	//팀 M/M 조회
	@RequestMapping(value = "teamMM", params = "methodType=search", method = RequestMethod.POST)
	public String MMSearch(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
				
		System.out.println(">>>>>>>>>>>>>>>>>>> TeamMM Merthod = search <<<<<<<<<<<<<<<<<<<");

		//팀 M/M 조회
		String result = teamRepeatedSearch(request, userBean, searchBean, model);	
				
		return "team/teamMM";

	}
	
	
	//유저 M/M 중간 저장
	@RequestMapping(value = "teamMM", params = "methodType=complete", method = RequestMethod.POST)
	public String MMSave(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
						
		System.out.println(">>>>>>>>>>>>>>>>>>> TeamMM Merthod = complete <<<<<<<<<<<<<<<<<<<");
		
		String i_mm_seq_pk 			= request.getParameter("i_mm_seq_pk");
		String complete_check 		= request.getParameter("complete_check");

		String[] i_default_mm 		= i_mm_seq_pk.split(",");
		
		for(int i=0; i_default_mm.length > i; i++) {
			if(complete_check.equals("Y")) {
				int iResult = ius.getCompleteUserMM(i_default_mm[i]);
			} else {
				int iResult = ius.getInCompleteUserMM(i_default_mm[i]);
			}
		}
			
		//팀 M/M 조회
		String result = teamRepeatedSearch(request, userBean, searchBean, model);
		
		return "team/teamMM";

	}
	
	
	//팀 M/M 완료
	@RequestMapping(value = "teamMM", params = "methodType=teamComplete", method = RequestMethod.POST)
	public String MMComplete(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
							
		System.out.println(">>>>>>>>>>>>>>>>>>> TeamMM Merthod = teamComplete <<<<<<<<<<<<<<<<<<<");
		
		String i_mm_seq_pk 			= request.getParameter("i_mm_seq_pk");

		String[] i_default_mm 		= i_mm_seq_pk.split(",");
			
		for(int i=0; i_default_mm.length > i; i++) {
			int iResult = its.getCompleteTeamMM(i_default_mm[i]);
		}
		
		//팀 M/M 조회
		String result = teamRepeatedSearch(request, userBean, searchBean, model);
		
		return "team/teamMM";

	}
	
	
	//해당 목록 Excel 다운로드
	@RequestMapping(value = "teamMM", params = "methodType=excel", method = RequestMethod.POST)
	public View excelDown(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
				
		System.out.println(">>>>>>>>>>>>>>>>>>> TeamMM Merthod = excelDownload <<<<<<<<<<<<<<<<<<<");
			
		String search_Team_user_MM_seq			= request.getParameter("teamUserMMSEQ");
		String search_user_seq					= "";
		
		if(search_Team_user_MM_seq.equals("")) {
			
			String search_dept_seq 					= request.getParameter("search_dept_seq");
			searchBean.setSearch_dept_seq(search_dept_seq);
		} else {
			
			String[] team_user_MM_seq 				= search_Team_user_MM_seq.split(",");
			
			for(int i=0; team_user_MM_seq.length > i; i++) {
				
				String user_seq = its.getTeamUserSeq(team_user_MM_seq[i]);
				search_user_seq += user_seq + ",";
			}
		}
		
		searchBean.setSearch_date(searchBean.getSearch_date());
		
		List<GetDefaultMMBean> lUserDefaultMM 		= ius.getUserDefaultMM(searchBean);
		
		model.addAttribute("search_date", searchBean.getSearch_date());
		model.addAttribute("search_user_seq", search_user_seq);
		model.addAttribute("lUserDefaultMM", lUserDefaultMM);
		model.addAttribute("excelType", "TeamExcel");
		
		return new ExcelView();

	}
	
	
	//팀 M/M 조회(반복 사용)
	public String teamRepeatedSearch(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
								
		System.out.println(">>>>>>>>>>>>>>>>>>> TeamMM Merthod = teamRepeatedSearch <<<<<<<<<<<<<<<<<<<");
					
		String btn_flag = "1";
					
		GetUserBean getUserBean 	= new GetUserBean();
		SearchBean pSearchBean	 	= new SearchBean();
						
		String search_dept_seq 		= request.getParameter("search_dept_seq");
		String search_user_seq 		= request.getParameter("userSEQ");
					
		searchBean.setSearch_dept_seq(search_dept_seq);
		searchBean.setSearch_date(searchBean.getSearch_date());
		searchBean.setProject_user_flag("Y");
					
		pSearchBean.setSearch_date(searchBean.getSearch_date());
		pSearchBean.setSearch_dept_seq(search_dept_seq);
		pSearchBean.setSearch_user_seq(search_user_seq);
					
					
		List<GetProjectCodeBean> lProjectCode 		= ius.getProjectCode(searchBean);
		List<GetDefaultMMBean> lUserDefaultMM 		= ius.getUserDefaultMM(searchBean);
		List<GetDefaultMMBean> lUserProjectGroup 	= its.getUserProjectGroup(searchBean);
		List<GetTeamBean> lTeam 					= its.getConfirmorDept(pSearchBean);
					
		getUserBean.setUserSEQ(userBean.getUserSEQ());
		getUserBean.setUserNum(userBean.getUserNum());
		getUserBean.setUserName(userBean.getUserName());
					
		if(lUserDefaultMM.size() != 0) {
			GetDefaultMMBean getDefaultMMBean = lUserDefaultMM.get(0);
			btn_flag = getDefaultMMBean.getV_complete().equals("Y")?  "2" : "3";
		} else {
			btn_flag = "1";
		}
							
		model.addAttribute("lTeam", lTeam);
		model.addAttribute("userBean", userBean);
		model.addAttribute("lProjectCode", lProjectCode);
		model.addAttribute("lUserDefaultMM", lUserDefaultMM);
		model.addAttribute("lUserProjectGroup", lUserProjectGroup);
		model.addAttribute("btn_flag", btn_flag);
						
		return "Y";

	}
	
	
	//날짜 검색
	@ModelAttribute("lMonth")
	public List<String> lMonth() throws Exception {
		String user = "user";
		return DateTime.getMonthList(user);
	}

}
