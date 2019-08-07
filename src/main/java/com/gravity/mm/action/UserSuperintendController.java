package com.gravity.mm.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gravity.mm.bean.UserBean;
import com.gravity.mm.service.ITeamService;
import com.gravity.mm.service.IUserService;

@Controller
@RequestMapping("/")
public class UserSuperintendController {

	private static Logger LOG = Logger.getLogger(UserSuperintendController.class);
	
	@Autowired ITeamService its;
	@Autowired IUserService ius;
	
	//涝仿磊 包府 其捞瘤 贸澜 立加
	@RequestMapping(value = "userSuperintend", params = "methodType=normal", method = RequestMethod.POST)
	public String userSuperintend(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(userSuperintend) Merthod = normal <<<<<<<<<<<<<<<<<<<");
		
		model.addAttribute("userBean", userBean);
		
		return "admin/userSuperintend";

	}
	
}
