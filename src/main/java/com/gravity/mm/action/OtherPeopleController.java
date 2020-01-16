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

import com.gravity.mm.bean.AddPrevMonthBean;
import com.gravity.mm.bean.GetOtherPeopleBean;
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
	
	private static Logger log = LoggerFactory.getLogger(OtherPeopleController.class);
	
	@Autowired ITeamService its;
	@Autowired IUserService ius;
	@Autowired IAdminService ias;
	
	//타인 입력 지정 페이지 처음 접속
	@RequestMapping(value = "otherPeople", method = RequestMethod.POST)
	public String login(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
				
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(otherPeople) Merthod = normal <<<<<<<<<<<<<<<<<<<");
		log.info("userBean > " + userBean.getUserID());
		
		model.addAttribute("userBean", userBean);
		model.addAttribute("urlPage", "otherPeople");
		
		return "admin/otherPeople";

	}
	
	
	//전월 프로젝트 데이터 가져와서 새로 입력
	@RequestMapping(value = "otherPeople", params = "methodType=addPrev", method = RequestMethod.POST)
	public String addPrevOther(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
		
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(projectCode) Merthod = addPrevMonth <<<<<<<<<<<<<<<<<<<");
		
		String prev_month 			= request.getParameter("prev_month")+"-01";
		String default_month 		= request.getParameter("default_month")+"-01";
		
		AddPrevMonthBean addPrevMonthBean		= new AddPrevMonthBean();

		addPrevMonthBean.setPrev_month(prev_month);
		addPrevMonthBean.setDefault_month(default_month);
		
		log.info(">>>>>>>>>>>>>>>>>>> prev_month <<<<<<<<<<<<<<<<<<<" + prev_month);
		log.info(">>>>>>>>>>>>>>>>>>> default_month <<<<<<<<<<<<<<<<<<<" + default_month);
		
		int iResult = ias.addPrevOtherPeople(addPrevMonthBean);
		
		return "admin/otherPeople";

	}
	
	
	//타인지정 조회
	@RequestMapping(value = "otherPeople", params="methodType=search", method = RequestMethod.POST)
	public String getOtherPeoplePost(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean,Model model) {
		
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(otherPeople) Merthod = search <<<<<<<<<<<<<<<<<<<");
		
		String search_date 							= request.getParameter("search_date");
		
		searchBean.setSearch_date(search_date);
		
		String result = getOtherPeopleRepeatedSearch(request, userBean, searchBean, model);
		
		return "admin/otherPeople";

	}
	
	
	//타인지정 저장
	@RequestMapping(value = "otherPeople", params="methodType=save", method = RequestMethod.POST)
	public String getSave(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean,Model model) {
		
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(otherPeople) Merthod = save <<<<<<<<<<<<<<<<<<<");
		
		String peopleState 								= request.getParameter("peopleState");
		String addPeopleDate 							= request.getParameter("addPeopleDate");
		String peopleSeq 								= request.getParameter("peopleSeq");
		String otherPeopleSeq 							= request.getParameter("otherPeopleSeq");
		String addPeopleSeq 							= request.getParameter("addPeopleSeq");
		String addOtherPeopleSeq 						= request.getParameter("addOtherPeopleSeq");
		
		GetOtherPeopleBean lOtherPeople 				= new GetOtherPeopleBean();
		
		log.info("peopleSeq : " + peopleSeq);
		log.info("addOtherPeopleSeq : " + addOtherPeopleSeq);
		
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
	
	
	//타인지정 삭제
	@RequestMapping(value = "otherPeople", params="methodType=delete", method = RequestMethod.POST)
	public String getDelete(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean,Model model) {
		
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(otherPeople) Merthod = delete <<<<<<<<<<<<<<<<<<<");
		
		String otherSeq 								= request.getParameter("otherSeq");
		
		GetOtherPeopleBean lOtherPeople 				= new GetOtherPeopleBean();
		
		String[] arr_v_other_seq = otherSeq.split(",");
		
		lOtherPeople.setArr_v_other_seq(arr_v_other_seq);
		
		int resultSave = ias.getOtherDelete(lOtherPeople);
		
		getOtherPeopleRepeatedSearch(request, userBean, searchBean, model);
		
		return "admin/otherPeople";

	}
	
	
	//세팅값으로 타인지정 조회(반복 사용)
	public String getOtherPeopleRepeatedSearch(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
									
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(otherPeople) Merthod = getOtherPeopleRepeatedSearch <<<<<<<<<<<<<<<<<<<");
		
		List<GetOtherPeopleBean> lOtherPeople 	= ias.getOtherPeople(searchBean);
		
		model.addAttribute("userBean", userBean);
		model.addAttribute("searchBean", searchBean);
		model.addAttribute("lOtherPeople", lOtherPeople);
		model.addAttribute("urlPage", "otherPeople");

		
		return "Y";

	}
	
	
	//인원 검색
	@ModelAttribute("lUser")
	public List<GetUserBean> lUser() throws Exception {
		String user = "admin";
		List<GetUserBean> lUser = ias.getUserConfirmor(DateTime.getMonthList(user).get(0));
		return lUser;
	}
	
	
	//날짜 검색
	@ModelAttribute("lMonth")
	public List<String> lMonth() throws Exception {
		String user = "admin";
		return DateTime.getMonthList(user);
	}

}
