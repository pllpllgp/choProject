package com.gravity.mm.action;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;

import com.gravity.mm.bean.AddPrevMonthBean;
import com.gravity.mm.bean.DefaultMMBean;
import com.gravity.mm.bean.GetConfirmorBean;
import com.gravity.mm.bean.GetDefaultMMBean;
import com.gravity.mm.bean.GetDeptBean;
import com.gravity.mm.bean.GetTeamBean;
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
	
	private static Logger LOG = Logger.getLogger(OtherPeopleController.class);
	
	@Autowired IAdminService ias;
	@Autowired ITeamService its;
	
	//��� M/M ������ ����
	@RequestMapping(value = "defaultMM", params = "methodType=normal", method = RequestMethod.POST)
	public String login(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(defaultMM) Merthod = normal <<<<<<<<<<<<<<<<<<<");
		System.out.println("userBean > " + userBean.getUserID());
		
		model.addAttribute("userBean", userBean);
		
		return "admin/defaultMM";

	}
	
	
	//��¥��  M/M ��ȸ
	@RequestMapping(value = "defaultMM", params = "methodType=search", method = RequestMethod.POST)
	public String defaultMMSearch(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, Model model) {
			
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(defaultMM) Merthod = search <<<<<<<<<<<<<<<<<<<");
		
		SearchBean searchBean		= new SearchBean();
		
		String search_date 			= request.getParameter("search_date");
		String search_dept			= request.getParameter("search_dept_seq");
		
		searchBean.setSearch_date(search_date);
		searchBean.setSearch_dept_seq(search_dept);
		
		defaultMMRepeatedSearch(request, userBean, searchBean, model);
			
		return "admin/defaultMM";

	}
	
	
	//����  M/M �����ͼ� ���� �Է�
	@RequestMapping(value = "defaultMM", params = "methodType=prevMonth", method = RequestMethod.POST)
	public String defaultMMPrevMonth(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(defaultMM) Merthod = prevMonth <<<<<<<<<<<<<<<<<<<");
		
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
	
	
	//�߰�/���� ����
	@RequestMapping(value = "defaultMM", params = "methodType=save", method = RequestMethod.POST)
	public String defaultMMSave(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
		
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(defaultMM) Merthod = save <<<<<<<<<<<<<<<<<<<");
		
		String i_seq_pk 				= request.getParameter("addProjectSeq"); //MM SEQ
		System.out.println("i_seq_pk : " + i_seq_pk);
		String d_job_date 				= request.getParameter("addDefaultYear"); //MM�۾���
		System.out.println("d_job_date : " + d_job_date);
		String v_dept_code				= request.getParameter("addDefaultCode"); //�μ� �ڵ�
		System.out.println("v_dept_code : " + v_dept_code);
		String v_dept_code_name			= request.getParameter("addDefaultERP"); //�μ� ERP
		System.out.println("v_dept_code_name : " + v_dept_code_name);
		String i_dept_seq				= request.getParameter("addDefaultDept"); //�μ� Seq
		System.out.println("i_dept_seq : " + i_dept_seq);
		String v_dept_name				= request.getParameter("defaultDeptNameK"); //�μ���
		System.out.println("v_dept_name : " + v_dept_name);
		String i_user_number			= request.getParameter("addDefaultName"); //��� Seq
		System.out.println("i_user_number : " + i_user_number);
		String d_enter_date				= request.getParameter("addDefaultIn"); //��� �Ի���
		System.out.println("d_enter_date : " + d_enter_date);
		String d_retirement_date		= request.getParameter("addDefaultOut"); //��� �����
		System.out.println("d_retirement_date : " + d_retirement_date);
		String i_day_count				= request.getParameter("addDefaultDay"); //��� �� �۾��� ��
		System.out.println("i_day_count : " + i_day_count);
		String d_mm						= request.getParameter("addDefaultMM"); //��� MM�Է� ��
		System.out.println("d_mm : " + d_mm);
		String defaultState				= request.getParameter("defaultState"); //�߰�, ���� �к� ��
		System.out.println("defaultState : " + defaultState);
		
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
		
		int Return = ias.getDefaultSave(defaultMMBean, defaultState);
		
		
		
		return "admin/defaultMM";

	}
	
	
	//�ش� ��� Excel �ٿ�ε�
	@RequestMapping(value = "defaultMM", params = "methodType=excel", method = RequestMethod.POST)
	public View excelDown(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
				
		System.out.println(">>>>>>>>>>>>>>>>>>> defaultMM(defaultMM) Merthod = excelDownload <<<<<<<<<<<<<<<<<<<");
			
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
	
	
	//���ð����� ��ȸ(�ݺ� ���)
	public String defaultMMRepeatedSearch(HttpServletRequest request, @ModelAttribute("userBean")UserBean userBean, @ModelAttribute("searchBean")SearchBean searchBean, Model model) {
									
		System.out.println(">>>>>>>>>>>>>>>>>>> adminMM(defaultMM) Merthod = defaultMMRepeatedSearch <<<<<<<<<<<<<<<<<<<");
		
		List<GetDefaultMMBean> lDefaultMM = ias.getDefaultMM(searchBean);
		
		model.addAttribute("lDefaultMM", lDefaultMM);
		model.addAttribute("userBean", userBean);
		model.addAttribute("searchBean", searchBean);
		
		return "Y";

	}
	
	
	//��¥ �˻�
	@ModelAttribute("lMonth")
	public List<String> lMonth() throws Exception {
		String user = "admin";
		return DateTime.getMonthList(user);
	}
	
	
	//�μ� ��ȸ
	@ModelAttribute("lDept")
	public List<GetDeptBean> lDept() throws Exception {
		List<GetDeptBean> lDept = ias.getDept();
		return lDept;
	}
	
	
	//���� ��ȸ
	@ModelAttribute("lUser")
	public List<GetUserBean> lUser() throws Exception {
		List<GetUserBean> lUser = ias.getUser();
		return lUser;
	}
	
	
	//�̴��� �������� ��
	@ModelAttribute("monthCount")
	public int monthCount() throws Exception{
		Calendar c = Calendar.getInstance();
		int monthCount = c.getActualMaximum(Calendar.DATE);
		return monthCount;
	}

}
