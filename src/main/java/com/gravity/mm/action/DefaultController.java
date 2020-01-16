package com.gravity.mm.action;

import java.util.Calendar;
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
import com.gravity.mm.bean.DefaultMMBean;
import com.gravity.mm.bean.GetDefaultMMBean;
import com.gravity.mm.bean.GetDeptBean;
import com.gravity.mm.bean.GetUserBean;
import com.gravity.mm.bean.SearchBean;
import com.gravity.mm.bean.UserBean;
import com.gravity.mm.service.IAdminService;
import com.gravity.mm.service.ITeamService;
import com.gravity.mm.util.DateTime;
import com.gravity.mm.util.ExcelView;

@Controller
@RequestMapping("/")
public class DefaultController {
	
	private static Logger log = LoggerFactory.getLogger(OtherPeopleController.class);
	
	@Autowired IAdminService ias;
	@Autowired ITeamService its;
	
	//당월 M/M 페이지 접속
	@RequestMapping(value = "defaultMM", params = "methodType=normal", method = RequestMethod.POST)
	public String login(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(defaultMM) Merthod = normal <<<<<<<<<<<<<<<<<<<");
		System.out.println("userBean > " + userBean.getUserID());
		
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(defaultMM) Merthod = normal <<<<<<<<<<<<<<<<<<<");
		log.info("userBean > " + userBean.getUserID());
		
		model.addAttribute("userBean", userBean);
		model.addAttribute("urlPage", "defaultMM");
		
		return "admin/defaultMM";

	}
	
	
	//날짜로  M/M 조회
	@RequestMapping(value = "defaultMM", params = "methodType=search", method = RequestMethod.POST)
	public String defaultMMSearch(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
			
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(defaultMM) Merthod = search <<<<<<<<<<<<<<<<<<<");
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(defaultMM) Merthod = search <<<<<<<<<<<<<<<<<<<");
		
		SearchBean searchBean		= new SearchBean();
		
		String search_date 			= request.getParameter("search_date");
		String search_dept			= request.getParameter("search_dept_seq");
		
		searchBean.setSearch_date(search_date);
		searchBean.setSearch_dept_seq(search_dept);
		
		defaultMMRepeatedSearch(request, userBean, searchBean, model);
			
		return "admin/defaultMM";

	}
	
	
	//전월  M/M 가져와서 새로 입력
	@RequestMapping(value = "defaultMM", params = "methodType=prevMonth", method = RequestMethod.POST)
	public String defaultMMPrevMonth(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(defaultMM) Merthod = prevMonth <<<<<<<<<<<<<<<<<<<");
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(defaultMM) Merthod = prevMonth <<<<<<<<<<<<<<<<<<<");
		
		String prev_month 			= request.getParameter("prev_month")+"-01";
		String default_month 		= request.getParameter("default_month")+"-01";
		String month_count 			= request.getParameter("month_count");
		
		AddPrevMonthBean addPrevMonthBean		= new AddPrevMonthBean();

		addPrevMonthBean.setPrev_month(prev_month);
		addPrevMonthBean.setDefault_month(default_month);
		addPrevMonthBean.setMonth_count(month_count);
		
		int Return = ias.addPrevDefaultMM(addPrevMonthBean);
		
		defaultMMRepeatedSearch(request, userBean, searchBean, model);
		
		return "admin/defaultMM";

	}
	
	
	//추가/수정 저장
	@RequestMapping(value = "defaultMM", params = "methodType=save", method = RequestMethod.POST)
	public String defaultMMSave(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(defaultMM) Merthod = save <<<<<<<<<<<<<<<<<<<");
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(defaultMM) Merthod = save <<<<<<<<<<<<<<<<<<<");
		
		String i_seq_pk 				= request.getParameter("addProjectSeq"); //MM SEQ
		String d_job_date 				= request.getParameter("addDefaultYear"); //MM작업월
		String v_dept_code				= request.getParameter("addDefaultCode"); //부서 코드
		String v_dept_code_name			= request.getParameter("addDefaultERP"); //부서 ERP
		String i_dept_seq				= request.getParameter("addDefaultDept"); //부서 Seq
		String v_dept_name				= request.getParameter("defaultDeptNameK"); //부서명
		String i_user_number			= request.getParameter("addDefaultName"); //사원 Seq
		String d_enter_date				= request.getParameter("addDefaultIn"); //사원 입사일
		String d_retirement_date		= request.getParameter("addDefaultOut"); //사원 퇴사일
		String i_day_count				= request.getParameter("addDefaultDay"); //사원 월 작업일 수
		String d_mm						= request.getParameter("addDefaultMM"); //사원 MM입력 값
		String defaultState				= request.getParameter("defaultState"); //추가, 수정 분별 값
		
		DefaultMMBean defaultMMBean = new DefaultMMBean();
		
		defaultMMBean.setI_seq_pk(i_seq_pk);
		defaultMMBean.setD_job_date(d_job_date);
		defaultMMBean.setV_dept_code(v_dept_code);
		defaultMMBean.setV_dept_code_name(v_dept_code_name);
		defaultMMBean.setI_dept_seq(i_dept_seq);
		defaultMMBean.setV_dept_name(v_dept_name);
		defaultMMBean.setI_user_number(i_user_number);
		defaultMMBean.setD_mm(d_mm);
		defaultMMBean.setD_enter_date(d_enter_date);
		defaultMMBean.setD_retirement_date(d_retirement_date);
		defaultMMBean.setI_day_count(i_day_count);
		defaultMMBean.setI_reg_user_number(userBean.getUserSEQ());
		defaultMMBean.setI_update_user_number(userBean.getUserSEQ());
		model.addAttribute("urlPage", "defaultMM");
		
		int Return = ias.getDefaultSave(defaultMMBean, defaultState);
		
		
		
		return "admin/defaultMM";

	}
	
	
	//해당 목록 Excel 다운로드
	@RequestMapping(value = "defaultMM", params = "methodType=excel", method = RequestMethod.POST)
	public View excelDown(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
				
		System.out.println(">>>>>>>>>>>>>>>>>>> defaultMM(defaultMM) Merthod = excelDownload <<<<<<<<<<<<<<<<<<<");
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(defaultMM) Merthod = excelDownload <<<<<<<<<<<<<<<<<<<");
			
		String defaultMMSeq							= request.getParameter("defaultMMSeq");
		String search_dept_seq						= request.getParameter("search_dept_seq");
		
		if(!search_dept_seq.equals("")) {
			
			searchBean.setSearch_dept_seq(search_dept_seq);
		}
		
		searchBean.setSearch_date(searchBean.getSearch_date());
		
		List<GetDefaultMMBean> lUserDefaultMM 		= ias.getDefaultMM(searchBean);
		
		
		model.addAttribute("search_date", searchBean.getSearch_date());
		model.addAttribute("defaultMMSeq", defaultMMSeq);
		model.addAttribute("lUserDefaultMM", lUserDefaultMM);
		model.addAttribute("excelType", "dafaultExcel");
		
		return new ExcelView();

	}
	
	
	//세팅값으로 조회(반복 사용)
	public String defaultMMRepeatedSearch(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
									
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(defaultMM) Merthod = defaultMMRepeatedSearch <<<<<<<<<<<<<<<<<<<");
		log.info(">>>>>>>>>>>>>>>>>>> adminMM(defaultMM) Merthod = defaultMMRepeatedSearch <<<<<<<<<<<<<<<<<<<");
		
		List<GetDefaultMMBean> lDefaultMM = ias.getDefaultMM(searchBean);
		
		model.addAttribute("lDefaultMM", lDefaultMM);
		model.addAttribute("userBean", userBean);
		model.addAttribute("searchBean", searchBean);
		model.addAttribute("urlPage", "defaultMM");
		
		return "Y";

	}
	
	
	//날짜 검색
	@ModelAttribute("lMonth")
	public List<String> lMonth() throws Exception {
		String user = "admin";
		return DateTime.getMonthList(user);
	}
	
	
	//부서 조회
	@ModelAttribute("lDept")
	public List<GetDeptBean> lDept() throws Exception {
		List<GetDeptBean> lDept = ias.getDept();
		return lDept;
	}
	
	
	//유저 조회
	@ModelAttribute("lUser")
	public List<GetUserBean> lUser() throws Exception {
		List<GetUserBean> lUser = ias.getUser();
		return lUser;
	}
	
	
	//이달의 마지막날 값
	@ModelAttribute("monthCount")
	public int monthCount() throws Exception{
		Calendar c = Calendar.getInstance();
		int monthCount = c.getActualMaximum(Calendar.DATE);
		return monthCount;
	}

}
