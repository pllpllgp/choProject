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

import com.gravity.mm.action.LoginController;
import com.gravity.mm.bean.GetTeamBean;
import com.gravity.mm.bean.SearchBean;
import com.gravity.mm.bean.UserBean;
import com.gravity.mm.service.ITeamService;
import com.gravity.mm.service.IUserService;
import com.gravity.mm.util.DateTime;

@Controller
@RequestMapping("/")
public class LoginController {
	
	private static Logger log = LoggerFactory.getLogger(LoginController.class); 
	
	@Autowired 
	IUserService ius;
	
	
	//로그인 페이지 처음 접속
	@RequestMapping(value = "login")
	public String login() {
		
		log.info(">>>>>>>>>>>>>>>>>>> login Merthod <<<<<<<<<<<<<<<<<<<");
		return "login";

	}

	
	//로그인
	@RequestMapping(value = "login", params = "methodType=login", method = RequestMethod.POST)
	public String login(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) throws Exception {
		
		SearchBean searchBean = new SearchBean();
		
		String userID 			= request.getParameter("userID");
		
		int test = 1;
		boolean btn_flag = false;
		
		if(test == 1) {
			
			UserBean login = ius.getLoginInfo(userID);
			
			if(ius.getAuthCheck(login.getUserSEQ()) > 0) {
				
				log.info(">>>>>>>>>>>>>>>>>>> 관리자 권한 부여 <<<<<<<<<<<<<<<<<<<");
				login.setUserAuth("Y");
			} else {
				
				login.setUserAuth("N");
			}
			
			String search_prevMonth = lMonth().get(4);
			String search_nowMonth = lMonth().get(0);
			
			searchBean.setSearch_prevMonth(search_prevMonth);
			searchBean.setSearch_nowMonth(search_nowMonth);
			searchBean.setSearch_user_seq(login.getUserSEQ());
			
			int DeptAuth = ius.getConfirmorDeptAuth(searchBean);
			String userDeptAutn;
			
			if(DeptAuth > 0) {
				
				login.setUserDeptAuth("Y");
			} else {
				
				login.setUserDeptAuth("N");
			}
			
			model.addAttribute("userBean", login);
			model.addAttribute("btn_flag", btn_flag);
			model.addAttribute("urlPage", "userMM");
		
		}
		
		return "user/userMM";

	}
	
	
	//로그인 SSO
	@RequestMapping(value = "loginSSO")
	public String loginSSO(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		
		String userID 			= request.getParameter("userID");
		
		int test = 1;
		boolean btn_flag = false;
		
		if(test == 1) {
			
			UserBean login = ius.getLoginInfo(userID);
			
			if(ius.getAuthCheck(login.getUserSEQ()) > 0) {
				
				log.info(">>>>>>>>>>>>>>>>>>> 관리자 권한 부여 <<<<<<<<<<<<<<<<<<<");
				login.setUserAuth("Y");
			} else {
				login.setUserAuth("N");
			}
			
			
			log.debug("userBean > " + userBean.getUserID());
			
			model.addAttribute("userBean", login);
			model.addAttribute("btn_flag", btn_flag);
			model.addAttribute("urlPage", "userMM");
		
		}
		
		return "user/userMM";

	}
	
	
	//날짜 검색
	@ModelAttribute("lMonth")
	public List<String> lMonth() throws Exception {
		String user = "user";
		return DateTime.getMonthList(user);
	}

}
