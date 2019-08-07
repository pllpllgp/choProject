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

import com.gravity.mm.bean.GetOtherPeopleBean;
import com.gravity.mm.bean.GetProjectCodeBean;
import com.gravity.mm.bean.GetUserBean;
import com.gravity.mm.bean.SearchBean;
import com.gravity.mm.bean.UserBean;
import com.gravity.mm.service.IAdminService;
import com.gravity.mm.service.ITeamService;
import com.gravity.mm.service.IUserService;
import com.gravity.mm.util.DateTime;

@Controller
@RequestMapping("/")
public class OtherPeopleController {
	
	private static Logger LOG = Logger.getLogger(OtherPeopleController.class);
	
	@Autowired ITeamService its;
	@Autowired IUserService ius;
	@Autowired IAdminService ias;
	
	//Ÿ�� �Է� ���� ������ ó�� ����
	@RequestMapping(value = "otherPeople", method = RequestMethod.POST)
	public String login(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(otherPeople) Merthod = normal <<<<<<<<<<<<<<<<<<<");
		System.out.println("userBean > " + userBean.getUserID());
		
		model.addAttribute("userBean", userBean);
		
		return "admin/otherPeople";

	}
	
	
	//Ÿ������ ��ȸ
	@RequestMapping(value = "otherPeople", params="methodType=search", method = RequestMethod.POST)
	public String getOtherPeoplePost(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean,Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(otherPeople) Merthod = search <<<<<<<<<<<<<<<<<<<");
		
		String search_date 							= request.getParameter("search_date");
		
		searchBean.setSearch_date(search_date);
		
		String result = getOtherPeopleRepeatedSearch(request, userBean, searchBean, model);
		
		return "admin/otherPeople";

	}
	
	
	//Ÿ������ ����
	@RequestMapping(value = "otherPeople", params="methodType=save", method = RequestMethod.POST)
	public String getSave(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean,Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(otherPeople) Merthod = save <<<<<<<<<<<<<<<<<<<");
		
		String peopleState 								= request.getParameter("peopleState");
		String addPeopleDate 							= request.getParameter("addPeopleDate");
		String peopleSeq 								= request.getParameter("peopleSeq");
		String otherPeopleSeq 							= request.getParameter("otherPeopleSeq");
		String addPeopleSeq 							= request.getParameter("addPeopleSeq");
		String addOtherPeopleSeq 						= request.getParameter("addOtherPeopleSeq");
		
		GetOtherPeopleBean lOtherPeople 				= new GetOtherPeopleBean();
		
		if(peopleState.equals("edit")) {
			lOtherPeople.setI_seq_pk(Integer.parseInt(peopleSeq));
			lOtherPeople.setI_to_seq_pk(Integer.parseInt(otherPeopleSeq));
			
		}
		
		lOtherPeople.setD_job_date(addPeopleDate);
		lOtherPeople.setI_user_number(Integer.parseInt(addPeopleSeq));
		lOtherPeople.setI_to_user_number(Integer.parseInt(addOtherPeopleSeq));
		
		int resultSave = ias.getPeopleSave(peopleState, lOtherPeople);
		
		getOtherPeopleRepeatedSearch(request, userBean, searchBean, model);
		
		return "admin/otherPeople";

	}
	
	
	//Ÿ������ ����
	@RequestMapping(value = "otherPeople", params="methodType=delete", method = RequestMethod.POST)
	public String getDelete(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean,Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(otherPeople) Merthod = delete <<<<<<<<<<<<<<<<<<<");
		
		String otherSeq 								= request.getParameter("otherSeq");
		
		GetOtherPeopleBean lOtherPeople 				= new GetOtherPeopleBean();
		
		String[] arr_v_other_seq = otherSeq.split(",");
		
		lOtherPeople.setArr_v_other_seq(arr_v_other_seq);
		
		int resultSave = ias.getOtherDelete(lOtherPeople);
		
		getOtherPeopleRepeatedSearch(request, userBean, searchBean, model);
		
		return "admin/otherPeople";

	}
	
	
	//���ð����� Ÿ������ ��ȸ(�ݺ� ���)
	public String getOtherPeopleRepeatedSearch(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
									
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(projectCode) Merthod = getOtherPeopleRepeatedSearch <<<<<<<<<<<<<<<<<<<");
		
		List<GetOtherPeopleBean> lOtherPeople 	= ias.getOtherPeople(searchBean);
		
		model.addAttribute("userBean", userBean);
		model.addAttribute("searchBean", searchBean);
		model.addAttribute("lOtherPeople", lOtherPeople);

		
		return "Y";

	}
	
	
	//�ο� �˻�
	@ModelAttribute("lUser")
	public List<GetUserBean> lUser() throws Exception {
		String user = "admin";
		List<GetUserBean> lUser = ias.getUserConfirmor(DateTime.getMonthList(user).get(0));
		return lUser;
	}
	
	
	//��¥ �˻�
	@ModelAttribute("lMonth")
	public List<String> lMonth() throws Exception {
		String user = "admin";
		return DateTime.getMonthList(user);
	}

}