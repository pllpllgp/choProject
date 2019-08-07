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

import com.gravity.mm.bean.GetDeptBean;
import com.gravity.mm.bean.UserBean;
import com.gravity.mm.service.IAdminService;
import com.gravity.mm.service.ITeamService;
import com.gravity.mm.service.IUserService;

@Controller
@RequestMapping("/")
public class TeamSuperintend {
	
	private static Logger LOG = Logger.getLogger(TeamSuperintend.class);
	
	@Autowired IAdminService ias;
	@Autowired ITeamService its;
	@Autowired IUserService ius;
	
	//评 包府 其捞瘤 贸澜 立加
	@RequestMapping(value = "teamSuperintend", params = "methodType=normal", method = RequestMethod.POST)
	public String teamSuperintend(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(teamSuperintend) Merthod = normal <<<<<<<<<<<<<<<<<<<");
		
		model.addAttribute("userBean", userBean);
		
		return "admin/teamSuperintend";
	}
	
	
	//何辑 炼雀
	@ModelAttribute("lDept")
	public List<GetDeptBean> lDept() throws Exception {
		List<GetDeptBean> lDept = ias.getDept();
		return lDept;
	}

}
