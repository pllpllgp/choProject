package com.gravity.mm.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gravity.mm.bean.GetDefaultMMBean;
import com.gravity.mm.bean.GetProjectCodeBean;
import com.gravity.mm.bean.GetTeamBean;
import com.gravity.mm.bean.GetUserBean;
import com.gravity.mm.bean.SearchBean;
import com.gravity.mm.bean.UserBean;
import com.gravity.mm.bean.UserMMBean;
import com.gravity.mm.service.IUserService;
import com.gravity.mm.util.DateTime;

import sun.rmi.runtime.Log;

@Controller
@RequestMapping("/")
public class UserController {
	
	private static Logger LOG = Logger.getLogger(UserController.class);
	
	@Autowired IUserService ius;
	
	
	//���� ������ ó�� ����
	@RequestMapping(value = "userMM", params = "methodType=normal", method = RequestMethod.POST)
	public String user(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		LOG.debug(">>>>>>>>>>>>>>>>>>> UserMM Merthod = normal <<<<<<<<<<<<<<<<<<<");
		
		System.out.println("userBean > " + userBean.getUserID());
		
		model.addAttribute("userBean", userBean);
		
		return "user/userMM";
		

	}
	
	
	//��¥ �˻����� �ۼ��� �˻�
	@RequestMapping(value = "userMM", params = "methodType=dateSearch", method = RequestMethod.POST)
	public String dateChoice(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> UserMM Merthod = dateSearch <<<<<<<<<<<<<<<<<<<");
		
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
		
		return "user/userMM";

	}
	
	
	//��� MM ��ȸ
	@RequestMapping(value = "userMM", params = "methodType=search", method = RequestMethod.POST)
	public String MMSearch(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
			
		System.out.println(">>>>>>>>>>>>>>>>>>> UserMM Merthod = search <<<<<<<<<<<<<<<<<<<");
		
		//���� M/M ��ȸ
		String result = userRepeatedSearch(request, userBean, searchBean, model);
			
		return "user/userMM";

	}
	
	
	//���� M/M �Է� �˾�â
	@RequestMapping(value = "userMM", params = "methodType=write", method = RequestMethod.GET)
	public String MMWrite(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
				
		System.out.println(">>>>>>>>>>>>>>>>>>> UserMM Merthod = write <<<<<<<<<<<<<<<<<<<");
			
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
	
	
	//���� M/M �߰� ����
	@RequestMapping(value = "userMM", params = "methodType=save", method = RequestMethod.POST)
	public String MMSave(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
					
		System.out.println(">>>>>>>>>>>>>>>>>>> UserMM Merthod = save <<<<<<<<<<<<<<<<<<<");
			
		String i_default_mm				= request.getParameter("i_mm_seq_pk");
		String project_SEQ 				= request.getParameter("project_SEQ");
		String project_MM 				= request.getParameter("project_MM");
		
		String[] projectSEQ				= project_SEQ.split(",");
		String[] projectMM				= project_MM.split(",");
		
		//������ ���� ���� �� ���� ����
		int iResult = ius.getDeleteUserMM(i_default_mm);
			
		for(int i=0; projectMM.length > i; i++) {
			UserMMBean userMMBeans	= new UserMMBean();
				
			userMMBeans.setI_default_mm(i_default_mm);
			userMMBeans.setI_project_code_pk(projectSEQ[i]);
			userMMBeans.setD_mm_user(projectMM[i]);
			
			System.out.println("projectSEQ[i] : " + projectSEQ[i]);
			
			int uResult = ius.getAddUserMM(userMMBeans);
		}
		
		//���� M/M ��ȸ
		String result = userRepeatedSearch(request, userBean, searchBean, model);
			
		return "user/userMM";

	}
	
	
	//���� M/M �Ϸ�
	@RequestMapping(value = "userMM", params = "methodType=complete", method = RequestMethod.POST)
	public String MMcomplete(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
					
		System.out.println(">>>>>>>>>>>>>>>>>>> UserMM Merthod = complete <<<<<<<<<<<<<<<<<<<");
		
		String i_default_mm				= request.getParameter("i_mm_seq_pk");
		
		int iResult = ius.getCompleteUserMM(i_default_mm);
		
		//���� M/M ��ȸ
		String result = userRepeatedSearch(request, userBean, searchBean, model);
		
		return "user/userMM";

	}
	
	
	//���� M/M ��ȸ(�ݺ� ���)
	public String userRepeatedSearch(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
									
		System.out.println(">>>>>>>>>>>>>>>>>>> UserMM Merthod = userRepeatedSearch <<<<<<<<<<<<<<<<<<<");
						
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
			
		return "Y";

	}
	
	
	//��¥ �˻�
	@ModelAttribute("lMonth")
	public List<String> lMonth() throws Exception {
		String user = "user";
		return DateTime.getMonthList(user);
	}
	
}