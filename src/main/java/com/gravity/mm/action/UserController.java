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

import com.gravity.mm.bean.GetDefaultMMBean;
import com.gravity.mm.bean.GetProjectCodeBean;
import com.gravity.mm.bean.GetUserBean;
import com.gravity.mm.bean.SearchBean;
import com.gravity.mm.bean.UserBean;
import com.gravity.mm.bean.UserMMBean;
import com.gravity.mm.service.IUserService;
import com.gravity.mm.util.DateTime;


@Controller
@RequestMapping("/")
public class UserController {
	
	private static Logger log = LoggerFactory.getLogger(UserController.class);
	
	@Autowired IUserService ius;
	
	
	//유저 페이지 처음 접속
	@RequestMapping(value = "userMM", params = "methodType=normal", method = RequestMethod.POST)
	public String user(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> UserMM Merthod = normal <<<<<<<<<<<<<<<<<<<");		
		System.out.println("userBean > " + userBean.getUserID());
		
		log.info(">>>>>>>>>>>>>>>>>>> UserMM Merthod = normal <<<<<<<<<<<<<<<<<<<");
		log.info("userBean > " + userBean.getUserID());
		
		model.addAttribute("userBean", userBean);
		model.addAttribute("urlPage", "userMM");
		
		return "user/userMM";
		

	}
	
	
	//날짜 검색으로 작성자 검색
	@RequestMapping(value = "userMM", params = "methodType=dateSearch", method = RequestMethod.POST)
	public String dateChoice(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> UserMM Merthod = dateSearch <<<<<<<<<<<<<<<<<<<");
		log.info(">>>>>>>>>>>>>>>>>>> UserMM Merthod = dateSearch <<<<<<<<<<<<<<<<<<<");
		
		GetUserBean getUserBean 	= new GetUserBean();
		SearchBean searchBean		= new SearchBean();
		
		String search_date 			= request.getParameter("search_date");
		
		getUserBean.setUserSEQ(userBean.getUserSEQ());
		getUserBean.setUserNum(userBean.getUserNum());
		getUserBean.setUserName(userBean.getUserName());
		searchBean.setSearch_user_seq(userBean.getUserSEQ());
		searchBean.setSearch_date(search_date);
		
		List<GetUserBean> lPeople = ius.getPeopleList(searchBean);
		lPeople.add(getUserBean);
		
		model.addAttribute("lPeople", lPeople);
		model.addAttribute("userBean", userBean);
		model.addAttribute("searchBean", searchBean);
		model.addAttribute("urlPage", "userMM");
		
		return "user/userMM";

	}
	
	
	//당월 MM 조회
	@RequestMapping(value = "userMM", params = "methodType=search", method = RequestMethod.POST)
	public String MMSearch(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
			
		System.out.println(">>>>>>>>>>>>>>>>>>> UserMM Merthod = search <<<<<<<<<<<<<<<<<<<");
		log.info(">>>>>>>>>>>>>>>>>>> UserMM Merthod = search <<<<<<<<<<<<<<<<<<<");
		
		//유저 M/M 조회
		userRepeatedSearch(request, userBean, searchBean, model);
			
		return "user/userMM";

	}
	
	
	//유저 M/M 입력 팝업창
	@RequestMapping(value = "userMM", params = "methodType=write", method = RequestMethod.GET)
	public String MMWrite(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
				
		System.out.println(">>>>>>>>>>>>>>>>>>> UserMM Merthod = write <<<<<<<<<<<<<<<<<<<");
		log.info(">>>>>>>>>>>>>>>>>>> UserMM Merthod = write <<<<<<<<<<<<<<<<<<<");
			
		SearchBean searchBean			= new SearchBean();
		String search_date 				= request.getParameter("search_date");
		String userSEQ	 				= request.getParameter("userSEQ");
		String userMM	 				= request.getParameter("userMM");
		
		searchBean.setSearch_user_seq(userSEQ);
		searchBean.setSearch_date(search_date);
		
		searchBean.setProject_user_flag("Y");
		List<GetProjectCodeBean> lProjectCode = ius.getProjectCode(searchBean);
		List<GetDefaultMMBean> lUserDefaultMM = ius.getUserDefaultMM(searchBean);
		
		model.addAttribute("lUserDefaultMM", lUserDefaultMM);
		model.addAttribute("lProjectCode", lProjectCode);
		model.addAttribute("search_date", search_date);
		model.addAttribute("userSEQ", userSEQ);
		model.addAttribute("userMM", userMM);
		
		return "user/writeUserMM";

	}
	
	
	//유저 M/M 중간 저장
	@RequestMapping(value = "userMM", params = "methodType=save", method = RequestMethod.POST)
	public String MMSave(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
					
		System.out.println(">>>>>>>>>>>>>>>>>>> UserMM Merthod = save <<<<<<<<<<<<<<<<<<<");
		log.info(">>>>>>>>>>>>>>>>>>> UserMM Merthod = save <<<<<<<<<<<<<<<<<<<");
			
		String i_default_mm				= request.getParameter("i_mm_seq_pk");
		String project_SEQ 				= request.getParameter("project_SEQ");
		String project_MM 				= request.getParameter("project_MM");
		
		String[] projectSEQ				= project_SEQ.split(",");
		String[] projectMM				= project_MM.split(",");
		
		//데이터 전부 삭제 후 새로 저장
		ius.getDeleteUserMM(i_default_mm);
			
		for(int i=0; projectMM.length > i; i++) {
			UserMMBean userMMBeans	= new UserMMBean();
				
			userMMBeans.setI_default_mm(i_default_mm);
			userMMBeans.setI_project_code_pk(projectSEQ[i]);
			userMMBeans.setD_mm_user(projectMM[i]);
			
			System.out.println("projectSEQ[i] : " + projectSEQ[i]);
			log.info("projectSEQ[i] : " + projectSEQ[i]);
			
			ius.getAddUserMM(userMMBeans);
		}
		
		//유저 M/M 조회
		userRepeatedSearch(request, userBean, searchBean, model);
			
		return "user/userMM";

	}
	
	
	//유저 M/M 완료
	@RequestMapping(value = "userMM", params = "methodType=complete", method = RequestMethod.POST)
	public String MMcomplete(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
					
		System.out.println(">>>>>>>>>>>>>>>>>>> UserMM Merthod = complete <<<<<<<<<<<<<<<<<<<");
		log.info(">>>>>>>>>>>>>>>>>>> UserMM Merthod = complete <<<<<<<<<<<<<<<<<<<");
		
		String i_default_mm				= request.getParameter("i_mm_seq_pk");
		
		ius.getCompleteUserMM(i_default_mm);
		
		//유저 M/M 조회
		userRepeatedSearch(request, userBean, searchBean, model);
		
		return "user/userMM";

	}
	
	
	//유저 M/M 조회(반복 사용)
	public String userRepeatedSearch(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
									
		System.out.println(">>>>>>>>>>>>>>>>>>> UserMM Merthod = userRepeatedSearch <<<<<<<<<<<<<<<<<<<");
		log.info(">>>>>>>>>>>>>>>>>>> UserMM Merthod = userRepeatedSearch <<<<<<<<<<<<<<<<<<<");
						
		GetUserBean getUserBean 		= new GetUserBean();
		SearchBean getSearchBean		= new SearchBean();
		
		boolean btn_flag = false;
		
		String search_user_seq 			= request.getParameter("search_user_seq");

		searchBean.setSearch_user_seq(search_user_seq);
		
		searchBean.setProject_user_flag("Y");
		List<GetProjectCodeBean> lProjectCode = ius.getProjectCode(searchBean);
		List<GetDefaultMMBean> lUserDefaultMM = ius.getUserDefaultMM(searchBean);
		
		getUserBean.setUserSEQ(userBean.getUserSEQ());
		getUserBean.setUserNum(userBean.getUserNum());
		getUserBean.setUserName(userBean.getUserName());
		getSearchBean.setSearch_user_seq(userBean.getUserSEQ());
		getSearchBean.setSearch_date(searchBean.getSearch_date());
		
		List<GetUserBean> lPeople = ius.getPeopleList(getSearchBean);
		lPeople.add(getUserBean);

		if(lUserDefaultMM.size() != 0) {
			
			System.out.println("lUserDefaultMM.get(0).getV_disable() = " + lUserDefaultMM.get(0).getV_disable());
			log.info("lUserDefaultMM.get(0).getV_disable() = " + lUserDefaultMM.get(0).getV_disable());
			
			if(lUserDefaultMM.get(0).getV_disable().equals("Y")) {
				btn_flag = false;
			} else {
				btn_flag = true;
			}
			
		} else {
			btn_flag = false;
		}
			
		model.addAttribute("lPeople", lPeople);
		model.addAttribute("lProjectCode", lProjectCode);
		model.addAttribute("lUserDefaultMM", lUserDefaultMM);
		model.addAttribute("btn_flag", btn_flag);
		model.addAttribute("urlPage", "userMM");
			
		return "Y";

	}
	
	
	//날짜 검색
	@ModelAttribute("lMonth")
	public List<String> lMonth() throws Exception {
		String user = "user";
		return DateTime.getMonthList(user);
	}
	
}
