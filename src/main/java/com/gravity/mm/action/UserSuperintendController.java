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

import com.gravity.mm.bean.GetProjectCodeBean;
import com.gravity.mm.bean.GetUserBean;
import com.gravity.mm.bean.SearchBean;
import com.gravity.mm.bean.UserBean;
import com.gravity.mm.service.IAdminService;
import com.gravity.mm.service.ITeamService;
import com.gravity.mm.service.IUserService;
import com.gravity.mm.util.ExcelView;

@Controller
@RequestMapping("/")
public class UserSuperintendController {

	private static Logger log = LoggerFactory.getLogger(UserSuperintendController.class);
	
	@Autowired 
	ITeamService its;
	
	@Autowired 
	IUserService ius;
	
	@Autowired 
	IAdminService ias;
	
	
	//직원 관리 페이지 처음 접속 및 조회
	@RequestMapping(value = "userSuperintend", params = "methodType=normal", method = RequestMethod.POST)
	public String userSuperintendSearch(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(userSuperintend) Merthod = search <<<<<<<<<<<<<<<<<<<");
		
		String search_user_seq 			= request.getParameter("search_user_seq");
		String search_user_use 			= request.getParameter("search_use");
		
		SearchBean searchBean = new SearchBean();
		
		searchBean.setSearch_user_seq(search_user_seq);
		searchBean.setSearch_disable(search_user_use);
		
		userRepeatedSearch(request, userBean, searchBean, model);
		
		return "admin/userSuperintend";
	}
	
	
	//직원 관리 페이지 추가/수정
	@RequestMapping(value = "userSuperintend", params = "methodType=save", method = RequestMethod.POST)
	public String userSuperintendSave(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(userSuperintend) Merthod = save <<<<<<<<<<<<<<<<<<<");
		
		String userState 				= request.getParameter("userState");
		String addUserSeq				= request.getParameter("addUserSeq");
		String addUserId				= request.getParameter("addUserId");
		String addUserMail				= request.getParameter("addUserMail");
		String addUserName		 		= request.getParameter("addUserName");
		String addUserNum		 		= request.getParameter("addUserNum");
		String addUserAuthYN 			= request.getParameter("adduserAuthYN");
		
		log.info("addUserSeq : " + addUserSeq);
		
		SearchBean searchBean = new SearchBean();
		
		GetUserBean getUserBean = new GetUserBean();
		
		getUserBean.setUserSEQ(addUserSeq);
		getUserBean.setUserID(addUserId);
		getUserBean.setUserMail(addUserMail);
		getUserBean.setUserName(addUserName);
		getUserBean.setUserNum(addUserNum);
		getUserBean.setUserAuthYN(addUserAuthYN);
		
		ias.getUserInsertEdit(getUserBean, userState);
		
		int authCnt = ius.getAuthCheck(addUserSeq);
		log.info("authCnt : " + authCnt);
		
		if(userState.equals("userAdd")) {
			
			ias.getUserAddDelete(getUserBean, authCnt);
		} else {
			
			ias.getUserAddDelete(getUserBean, authCnt);
		}
		
		model.addAttribute("urlPage", "userSuperintend");
		
		userRepeatedSearch(request, userBean, searchBean, model);
		
		return "admin/userSuperintend";
	}
	
	
	//해당 목록 Excel 다운로드
	@RequestMapping(value = "userSuperintend", params = "methodType=excel", method = RequestMethod.POST)
	public View excelDown(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
				
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(userSuperintend) Merthod = excelDownload <<<<<<<<<<<<<<<<<<<");
			
		String search_user_seq 			= request.getParameter("search_user_seq");
		String search_user_use 			= request.getParameter("search_use");
		
		searchBean = new SearchBean();
		
		searchBean.setSearch_user_seq(search_user_seq);
		searchBean.setSearch_disable(search_user_use);
		
		List<GetUserBean> getUserBean = ias.getUserSearch(searchBean);
		
		model.addAttribute("userBean", userBean);
		model.addAttribute("searchBean", searchBean);
		model.addAttribute("getUserBean", getUserBean);
		model.addAttribute("search_user_seq", search_user_seq);
		model.addAttribute("excelType", "adminUserExcel");
		
		return new ExcelView();

	}
	
	
	//세팅값으로 직원 조회(반복 사용)
	public String userRepeatedSearch(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
		
		List<GetUserBean> getUserBean = ias.getUserSearch(searchBean);
		
		model.addAttribute("userBean", userBean);
		model.addAttribute("searchBean", searchBean);
		model.addAttribute("getUserBean", getUserBean);
		model.addAttribute("urlPage", "userSuperintend");
		
		return "Y";
	}
	
}
