package com.gravity.mm.action;


import java.net.InetAddress;
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

import com.gravity.mm.bean.GetDeptBean;
import com.gravity.mm.bean.GetProjectCodeBean;
import com.gravity.mm.bean.SearchBean;
import com.gravity.mm.bean.UserBean;
import com.gravity.mm.service.IAdminService;
import com.gravity.mm.service.ITeamService;
import com.gravity.mm.service.IUserService;
import com.gravity.mm.util.ExcelView;

@Controller
@RequestMapping("/")
public class TeamSuperintendController {
	
	private static Logger log = LoggerFactory.getLogger(TeamSuperintendController.class);
	
	@Autowired IAdminService ias;
	@Autowired ITeamService its;
	@Autowired IUserService ius;
	
	//팀 관리 페이지 처음 접속
	@RequestMapping(value = "teamSuperintend", params = "methodType=normal", method = RequestMethod.POST)
	public String teamSuperintend(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(teamSuperintend) Merthod = normal <<<<<<<<<<<<<<<<<<<");
		
		model.addAttribute("userBean", userBean);
		model.addAttribute("urlPage", "teamSuperintend");
		
		return "admin/teamSuperintend";
	}
	
	
	//팀 관리 페이지 추가/수정
	@RequestMapping(value = "teamSuperintend", params = "methodType=save", method = RequestMethod.POST)
	public String teamSuperintendSave(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) throws Exception {
		
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(teamSuperintend) Merthod = save <<<<<<<<<<<<<<<<<<<");
		
		String teamState 				= request.getParameter("teamState");
		String editDeptSeq				= request.getParameter("editDeptSeq");
		String DeptSortNameAE			= request.getParameter("DeptSortNameAE");
		String DeptNameAE				= request.getParameter("DeptNameAE");
		String DeptUpNameAE				= request.getParameter("DeptUpNameAE");
		String DeptCountAE		 		= request.getParameter("DeptCountAE");
		String v_user_name		 		= request.getParameter("userName");
		String v_user_seq		 		= request.getParameter("userSEQ");
		String v_user_ip				= InetAddress.getLocalHost().getHostAddress();
		
		GetDeptBean getDeptBean = new GetDeptBean();

		getDeptBean.setI_seq_pk(editDeptSeq);
		getDeptBean.setI_step(DeptSortNameAE);
		getDeptBean.setV_dept_name_k(DeptNameAE);
		getDeptBean.setI_dept_up(DeptUpNameAE);
		getDeptBean.setI_sort(DeptCountAE);
		getDeptBean.setV_user_name(v_user_name);
		getDeptBean.setV_user_seq(v_user_seq);
		getDeptBean.setV_user_ip(v_user_ip);
		
		ias.getTeamInsertEdit(getDeptBean, teamState);
		List<GetDeptBean> lDept = ias.getDept();
		
		model.addAttribute("urlPage", "teamSuperintend");
		model.addAttribute("lDept", lDept);
		
		return "admin/teamSuperintend";
	}
	
	
	//해당 목록 Excel 다운로드
	@RequestMapping(value = "teamSuperintend", params = "methodType=excel", method = RequestMethod.POST)
	public View excelDown(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
				
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(teamSuperintend) Merthod = excelDownload <<<<<<<<<<<<<<<<<<<");
		
		List<GetDeptBean> lDept = ias.getDept();
		
		model.addAttribute("userBean", userBean);
		model.addAttribute("searchBean", searchBean);
		model.addAttribute("lDept", lDept);
		model.addAttribute("excelType", "adminProjectCodeExcel");
		
		return new ExcelView();

	}
	
	
	//팀 삭제
	@RequestMapping(value = "teamSuperintend", params = "methodType=delete", method = RequestMethod.POST)
	public String teamDelete(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) throws Exception {
		
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(teamSuperintend) Merthod = delete <<<<<<<<<<<<<<<<<<<");
		
		String teamState 				= request.getParameter("teamState");
		String editDeptSeq				= request.getParameter("editDeptSeq");
		
		GetDeptBean getDeptBean = new GetDeptBean();

		getDeptBean.setI_seq_pk(editDeptSeq);
		
		ias.getTeamDelete(getDeptBean);
		List<GetDeptBean> lDept = ias.getDept();
		
		model.addAttribute("urlPage", "teamSuperintend");
		model.addAttribute("lDept", lDept);
		
		return "admin/teamSuperintend";
	}
	
	
	//부서 조회
	@ModelAttribute("lDept")
	public List<GetDeptBean> lDept() throws Exception {
		List<GetDeptBean> lDept = ias.getDept();
		return lDept;
	}

}
