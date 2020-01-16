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

import com.gravity.mm.bean.AddPrevMonthBean;
import com.gravity.mm.bean.GetConfirmorBean;
import com.gravity.mm.bean.GetUserBean;
import com.gravity.mm.bean.SearchBean;
import com.gravity.mm.bean.UserBean;
import com.gravity.mm.service.IAdminService;
import com.gravity.mm.util.DateTime;
import com.gravity.mm.util.ExcelView;

@Controller
@RequestMapping("/")
public class ConfirmorController {
	
	private static Logger log = LoggerFactory.getLogger(ConfirmorController.class);
	
	@Autowired IAdminService ias;
	
	//확인자 페이지 접속
	@RequestMapping(value = "confirmor", params = "methodType=normal", method = RequestMethod.POST)
	public String confirmorChoice(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(confirmor) Merthod = normal <<<<<<<<<<<<<<<<<<<");
		System.out.println("userBean > " + userBean.getUserID());
		
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(confirmor) Merthod = normal <<<<<<<<<<<<<<<<<<<");
		log.info("userBean > " + userBean.getUserID());
		
		model.addAttribute("userBean", userBean);
		model.addAttribute("urlPage", "confirmor");
		
		return "admin/confirmor";

	}
	
	
	//확인자 조회
	@RequestMapping(value = "confirmor", params = "methodType=search", method = RequestMethod.POST)
	public String confirmorSearch(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(confirmor) Merthod = search <<<<<<<<<<<<<<<<<<<");
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(confirmor) Merthod = search <<<<<<<<<<<<<<<<<<<");
		
		SearchBean searchBean = new SearchBean();
		
		confirmorRepeatedSearch(request, userBean, searchBean, model);
		
		return "admin/confirmor";

	}
	
	
	//전월 데이터 가져와서 새로 입력
	@RequestMapping(value = "confirmor", params = "methodType=prevMonth", method = RequestMethod.POST)
	public String confirmorPrevMonth(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(confirmor) Merthod = prevMonth <<<<<<<<<<<<<<<<<<<");
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(confirmor) Merthod = prevMonth <<<<<<<<<<<<<<<<<<<");
		
		String prev_month 			= request.getParameter("prev_month")+"-01";
		String default_month 		= request.getParameter("default_month")+"-01";
		
		AddPrevMonthBean addPrevMonthBean		= new AddPrevMonthBean();

		addPrevMonthBean.setPrev_month(prev_month);
		addPrevMonthBean.setDefault_month(default_month);

		int Return = ias.addPrevConfirmor(addPrevMonthBean);
		
		confirmorRepeatedSearch(request, userBean, searchBean, model);
		
		return "admin/confirmor";

	}
	
	
	//확인자 등록/수정 저장
	@RequestMapping(value = "confirmor", params = "methodType=save", method = RequestMethod.POST)
	public String confirmorSave(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(confirmor) Merthod = save <<<<<<<<<<<<<<<<<<<");
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(confirmor) Merthod = save <<<<<<<<<<<<<<<<<<<");
		
		String confirmorState 						= request.getParameter("confirmorState");
		String addConfirmorDate 					= request.getParameter("addConfirmorDate");
		String addConfirmorSeq 						= request.getParameter("addConfirmorSeq");
		
		GetConfirmorBean confirmorBean				= new GetConfirmorBean();
		
		confirmorBean.setI_seq_pk(Integer.parseInt(addConfirmorSeq));
		confirmorBean.setD_job_date(addConfirmorDate);
		
		int iResult = ias.addConfirmor(confirmorBean, confirmorState);
		
		confirmorRepeatedSearch(request, userBean, searchBean, model);
		
		return "admin/confirmor";

	}
	
	
	//확인자 제거
	@RequestMapping(value = "confirmor", params = "methodType=delete", method = RequestMethod.POST)
	public String confirmorDelete(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(confirmor) Merthod = delete <<<<<<<<<<<<<<<<<<<");
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(confirmor) Merthod = delete <<<<<<<<<<<<<<<<<<<");
		
		String confirmotSeq 							= request.getParameter("arrConfirmorSeq");
		
		GetConfirmorBean confirmorBean 					= new GetConfirmorBean();
		
		String[] arr_v_confirmor_seq = confirmotSeq.split(",");
		
		confirmorBean.setArr_v_confirmor_seq(arr_v_confirmor_seq);
		
		int iResult = ias.getConfirmorDelete(confirmorBean);
		
		confirmorRepeatedSearch(request, userBean, searchBean, model);
		
		return "admin/confirmor";

	}
	
	
	//해당 목록 Excel 다운로드
	@RequestMapping(value = "confirmor", params = "methodType=excel", method = RequestMethod.POST)
	public View excelDown(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
				
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(confirmor) Merthod = excelDownload <<<<<<<<<<<<<<<<<<<");
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(confirmor) Merthod = excelDownload <<<<<<<<<<<<<<<<<<<");
			
		String search_date 							= request.getParameter("search_date");
		String confirmorSeq 						= request.getParameter("confirmorSeq");
		
		searchBean.setSearch_date(search_date);
		
		List<GetConfirmorBean> lConfirmor 		= ias.getConfirmor(searchBean);
		
		model.addAttribute("userBean", userBean);
		model.addAttribute("searchBean", searchBean);
		model.addAttribute("confirmorSeq", confirmorSeq);
		model.addAttribute("lConfirmor", lConfirmor);
		model.addAttribute("excelType", "confirmorExcel");
		
		return new ExcelView();

	}
	
	
	//세팅값으로 확인자 조회(반복 사용)
	public String confirmorRepeatedSearch(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
									
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(confirmor) Merthod = confirmorRepeatedSearch <<<<<<<<<<<<<<<<<<<");
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(confirmor) Merthod = confirmorRepeatedSearch <<<<<<<<<<<<<<<<<<<");
		
		
		String search_date 							= request.getParameter("search_date");
		searchBean.setSearch_date(search_date);
		
		if(!searchBean.getSearch_date().equals("")) {
			
			List<GetConfirmorBean> lConfirmor 		= ias.getConfirmor(searchBean);
			model.addAttribute("lConfirmor", lConfirmor);
		}
		
		model.addAttribute("userBean", userBean);
		model.addAttribute("searchBean", searchBean);
		model.addAttribute("urlPage", "confirmor");
		
		return "Y";
	}
	
	
	//날짜 검색
	@ModelAttribute("lMonth")
	public List<String> lMonth() throws Exception {
		String user = "admin";
		return DateTime.getMonthList(user);
	}
	
	
	//인원 검색
	@ModelAttribute("lUser")
	public List<GetUserBean> lUser() throws Exception {
		String user = "admin";
		List<GetUserBean> lUser = ias.getUserConfirmor(DateTime.getMonthList(user).get(0));
		return lUser;
	}

}
