package com.gravity.mm.action;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gravity.mm.bean.UserBean;
import com.gravity.mm.service.IUserService;

@Controller
@RequestMapping("/")
public class LoginController {
	
	private static Logger LOG = Logger.getLogger(LoginController.class); 
	
	@Autowired 
	IUserService ius;
	
	
	//로그인 페이지 처음 접속
	@RequestMapping(value = "login")
	public String login() {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> login Merthod <<<<<<<<<<<<<<<<<<<");
		return "login";

	}

	
	@RequestMapping(value = "login", params = "methodType=login", method = RequestMethod.POST)
	public String login(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		String userID 			= request.getParameter("userID");
		
		int test = 1;
		boolean btn_flag = false;
		
		if(test == 1) {
			
			UserBean login = ius.getLoginInfo(userID);
			
			if(ius.getAuthCheck(login.getUserSEQ()) > 0) {
				System.out.println("관리자 권한 부여");
				btn_flag = true;
				login.setUserAuth("Y");
			} else {
				btn_flag = false;
				login.setUserAuth("N");
			}
		
			model.addAttribute("userBean", login);
			model.addAttribute("btn_flag", btn_flag);
		
		} else {
			
			
			
		}
		
		return "main";

	}

}
