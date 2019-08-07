package com.gravity.mm.util;

import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.web.servlet.view.AbstractView;

import com.gravity.mm.bean.GetDefaultMMBean;
import com.gravity.mm.bean.GetProjectCodeBean;

public class ExcelView extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String sExcelType = (String) model.get("excelType");
		SXSSFWorkbook workBook = new SXSSFWorkbook();
		String fileName = "";
		
		//팀별 입력 현황 페이지		
		if(sExcelType.equals("TeamExcel")) {
			
			String team_user_MM_seq = (String) model.get("search_user_seq");
			String sSearch_date = (String) model.get("search_date");
			List<GetDefaultMMBean> sLUserDefaultMM = (List<GetDefaultMMBean>) model.get("lUserDefaultMM");
			
			String[] sSearch_user_seq 				= team_user_MM_seq.split(",");
			
			Sheet workSheet = workBook.createSheet("팀별MM");
			
			System.out.println(">>>>>>>>>>>>>>>>>>> ExcelDown = teamExcel <<<<<<<<<<<<<<<<<<<");
			
			fileName = sSearch_date + "_" + sLUserDefaultMM.get(0).getV_dept_name() + "_MM팀별입력현황.xlsx";
			
			int rowIndex = 1;
			
			Row row = workSheet.createRow(0);
			workSheet.setColumnWidth(3, (workSheet.getColumnWidth(3)+(short)1800));
			workSheet.setColumnWidth(7, (workSheet.getColumnWidth(7)+(short)1500));
			workSheet.setColumnWidth(8, (workSheet.getColumnWidth(8)+(short)5000));
			
	        Cell cell = row.createCell(0);
            cell.setCellValue("운영단위");
            cell = row.createCell(1);
            cell.setCellValue("작업년도");
            cell = row.createCell(2);
            cell.setCellValue("부서코드");
            cell = row.createCell(3);
            cell.setCellValue("부서명");
            cell = row.createCell(4);
            cell.setCellValue("사번");
            cell = row.createCell(5);
            cell.setCellValue("성명");
            cell = row.createCell(6);
            cell.setCellValue("당월 M/M");
            cell = row.createCell(7);
            cell.setCellValue("프로젝트 코드");
            cell = row.createCell(8);
            cell.setCellValue("프로젝트 명");
            cell = row.createCell(9);
            cell.setCellValue("투입 M/M");
            
			if(!sSearch_user_seq[0].equals("")) {
				
				for(int z = 0; sSearch_user_seq.length > z; z++) {
					String teamUserSeq = sSearch_user_seq[z];
					
					for(int i = 0; i < sLUserDefaultMM.size(); i++) {
						
						if(String.valueOf(sLUserDefaultMM.get(i).getI_user_number()).equals(teamUserSeq)) {
							row = workSheet.createRow(rowIndex);
							
					        if(i > 0) {
					        	
					        	if(!sLUserDefaultMM.get(i).getV_user_name_k().equals(sLUserDefaultMM.get(i-1).getV_user_name_k())) {
					        		
						            cell = row.createCell(0);
						            cell.setCellValue(sLUserDefaultMM.get(i).getS_op_type_name());
						            cell = row.createCell(1);
						            cell.setCellValue(sLUserDefaultMM.get(i).getD_job_date());
						            cell = row.createCell(2);
						            cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_code());
						            cell = row.createCell(3);
						            cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_name());
						            cell = row.createCell(4);
						            cell.setCellValue(sLUserDefaultMM.get(i).getV_man_seq());
						            cell = row.createCell(5);
						            cell.setCellValue(sLUserDefaultMM.get(i).getV_user_name_k());
						            cell = row.createCell(6);
						            cell.setCellValue(sLUserDefaultMM.get(i).getD_mm());
					        	}
					        } else {
						        	
						        cell = row.createCell(0);
						        cell.setCellValue(sLUserDefaultMM.get(i).getS_op_type_name());
						        cell = row.createCell(1);
						        cell.setCellValue(sLUserDefaultMM.get(i).getD_job_date());
						        cell = row.createCell(2);
						        cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_code());
						        cell = row.createCell(3);
						        cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_name());
						        cell = row.createCell(4);
						        cell.setCellValue(sLUserDefaultMM.get(i).getV_man_seq());
						        cell = row.createCell(5);
						        cell.setCellValue(sLUserDefaultMM.get(i).getV_user_name_k());
						        cell = row.createCell(6);
						        cell.setCellValue(sLUserDefaultMM.get(i).getD_mm());
					        }
					        
				            cell = row.createCell(7);
				            cell.setCellValue(sLUserDefaultMM.get(i).getV_project_code());
				            cell = row.createCell(8);
				            cell.setCellValue(sLUserDefaultMM.get(i).getV_project_name());
				            cell = row.createCell(9);
				            cell.setCellValue(sLUserDefaultMM.get(i).getD_mm_user());
				            
				            rowIndex++;
				           
						}
						
					}
				}
			} else {
				
				for(int i = 0; i < sLUserDefaultMM.size(); i++) {
			        row = workSheet.createRow(rowIndex);
			        
			        if(i > 0) {
			        	
			        	if(!sLUserDefaultMM.get(i).getV_user_name_k().equals(sLUserDefaultMM.get(i-1).getV_user_name_k())) {
			        		
				            cell = row.createCell(0);
				            cell.setCellValue(sLUserDefaultMM.get(i).getS_op_type_name());
				            cell = row.createCell(1);
				            cell.setCellValue(sLUserDefaultMM.get(i).getD_job_date());
				            cell = row.createCell(2);
				            cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_code());
				            cell = row.createCell(3);
				            cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_name());
				            cell = row.createCell(4);
				            cell.setCellValue(sLUserDefaultMM.get(i).getV_man_seq());
				            cell = row.createCell(5);
				            cell.setCellValue(sLUserDefaultMM.get(i).getV_user_name_k());
				            cell = row.createCell(6);
				            cell.setCellValue(sLUserDefaultMM.get(i).getD_mm());
			        	}
			        	
			        } else {
				        	
				        cell = row.createCell(0);
				        cell.setCellValue(sLUserDefaultMM.get(i).getS_op_type_name());
				        cell = row.createCell(1);
				        cell.setCellValue(sLUserDefaultMM.get(i).getD_job_date());
				        cell = row.createCell(2);
				        cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_code());
				        cell = row.createCell(3);
				        cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_name());
				        cell = row.createCell(4);
				        cell.setCellValue(sLUserDefaultMM.get(i).getV_man_seq());
				        cell = row.createCell(5);
				        cell.setCellValue(sLUserDefaultMM.get(i).getV_user_name_k());
				        cell = row.createCell(6);
				        cell.setCellValue(sLUserDefaultMM.get(i).getD_mm());
			        }
			        
		            cell = row.createCell(7);
		            cell.setCellValue(sLUserDefaultMM.get(i).getV_project_code());
		            cell = row.createCell(8);
		            cell.setCellValue(sLUserDefaultMM.get(i).getV_project_name());
		            cell = row.createCell(9);
		            cell.setCellValue(sLUserDefaultMM.get(i).getD_mm_user());
			            
		            rowIndex++;
				}
			}
			

		//관리자 M/M (프로젝트 코드) 페이지
		} else if(sExcelType.equals("adminProjectCodeExcel")) {
			
			List<GetProjectCodeBean> sLProjectCode = (List<GetProjectCodeBean>) model.get("lProjectCode");
			String projectCodeSEQ = (String) model.get("projectCodeSEQ");
			String[] sSearch_user_seq 				= projectCodeSEQ.split(",");
			
			Sheet workSheet = workBook.createSheet("프로젝트 목록");
			
			System.out.println(">>>>>>>>>>>>>>>>>>> ExcelDown = adminProjectCodeExcel <<<<<<<<<<<<<<<<<<<");
			
			fileName =  "MM 프로젝트 목록.xlsx";
			
			int rowIndex = 1;
			
			Row row = workSheet.createRow(0);
			workSheet.setColumnWidth(0, (workSheet.getColumnWidth(0)+(short)1800));
			workSheet.setColumnWidth(1, (workSheet.getColumnWidth(1)+(short)3000));
			workSheet.setColumnWidth(2, (workSheet.getColumnWidth(2)+(short)5000));
			
	        Cell cell = row.createCell(0);
            cell.setCellValue("사용유무");
            cell = row.createCell(1);
            cell.setCellValue("코드");
            cell = row.createCell(2);
            cell.setCellValue("프로젝트 명");
				
            if(!sSearch_user_seq[0].equals("")) {
            	
            	for(int z=0; sSearch_user_seq.length > z; z++ ) {
            		String projectCodeSeq = sSearch_user_seq[z];
            		
					for(int i = 0; i < sLProjectCode.size(); i++) {
						
						if(String.valueOf(sLProjectCode.get(i).getI_seq_pk()).equals(projectCodeSeq)) {
						
							row = workSheet.createRow(rowIndex);
							        	
							cell = row.createCell(0);
							cell.setCellValue(sLProjectCode.get(i).getV_disable());
							cell = row.createCell(1);
							cell.setCellValue(sLProjectCode.get(i).getV_project_code());
							cell = row.createCell(2);
							cell.setCellValue(sLProjectCode.get(i).getV_project_name());
							cell = row.createCell(3);
						            
							rowIndex++;
						}
					}	
            	}
            	
            } else {
            	
				for(int i = 0; i < sLProjectCode.size(); i++) {
					
					row = workSheet.createRow(rowIndex);
						        	
					cell = row.createCell(0);
					cell.setCellValue(sLProjectCode.get(i).getV_disable());
					cell = row.createCell(1);
					cell.setCellValue(sLProjectCode.get(i).getV_project_code());
					cell = row.createCell(2);
					cell.setCellValue(sLProjectCode.get(i).getV_project_name());
					cell = row.createCell(3);
					            
					rowIndex++;
				}
            }
			
			
		//관리자 M/M (당월 M/M 입력) 페이지
		} else if(sExcelType.equals("dafaultExcel")) {
						
			String defaultMMSEQ = (String) model.get("defaultMMSeq");
			String sSearch_date = (String) model.get("search_date");
			List<GetDefaultMMBean> sLUserDefaultMM = (List<GetDefaultMMBean>) model.get("lUserDefaultMM");
					
			String[] sSearch_mm_seq 				= defaultMMSEQ.split(",");
			
			Sheet workSheet = workBook.createSheet("당월 MM 입력");
					
			System.out.println(">>>>>>>>>>>>>>>>>>> ExcelDown = adminTeamExcel <<<<<<<<<<<<<<<<<<<");
					
			int rowIndex = 1;
					
			Row row = workSheet.createRow(0);
			workSheet.setColumnWidth(2, (workSheet.getColumnWidth(2)+(short)5000));
			workSheet.setColumnWidth(3, (workSheet.getColumnWidth(3)+(short)3000));
					
	        Cell cell = row.createCell(0);
            cell.setCellValue("작업년도");
            cell = row.createCell(1);
            cell.setCellValue("부서코드");
            cell = row.createCell(2);
            cell.setCellValue("부서명(ERP)");
            cell = row.createCell(3);
            cell.setCellValue("부서명");
            cell = row.createCell(4);
            cell.setCellValue("사번");
            cell = row.createCell(5);
            cell.setCellValue("성명");
            cell = row.createCell(6);
            cell.setCellValue("입사일");
            cell = row.createCell(7);
            cell.setCellValue("퇴사일");
            cell = row.createCell(8);
            cell.setCellValue("급여일수");
            cell = row.createCell(9);
            cell.setCellValue("당월 M/M");
		            
			if(!sSearch_mm_seq[0].equals("")) {
				
				fileName = sSearch_date + "_" + sLUserDefaultMM.get(0).getV_dept_name() + "_당월MM입력.xlsx";
						
				for(int z = 0; sSearch_mm_seq.length > z; z++) {
					String dedauleMMseq = sSearch_mm_seq[z];
							
					for(int i = 0; i < sLUserDefaultMM.size(); i++) {
								
						if(String.valueOf(sLUserDefaultMM.get(i).getI_seq_pk()).equals(dedauleMMseq)) {
							
							row = workSheet.createRow(rowIndex);
								        	
					       	cell = row.createCell(0);
					       	cell.setCellValue(sLUserDefaultMM.get(i).getD_job_date());
					       	cell = row.createCell(1);
					       	cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_code());
					       	cell = row.createCell(2);
					       	cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_code_name());
					       	cell = row.createCell(3);
					       	cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_name());
					       	cell = row.createCell(4);
					       	cell.setCellValue(sLUserDefaultMM.get(i).getV_man_seq());
					       	cell = row.createCell(5);
					       	cell.setCellValue(sLUserDefaultMM.get(i).getV_user_name_k());
					       	cell = row.createCell(6);
					       	cell.setCellValue(sLUserDefaultMM.get(i).getD_enter_date());
					       	cell = row.createCell(7);
					        cell.setCellValue(sLUserDefaultMM.get(i).getD_retirement_date());
					        cell = row.createCell(8);
					        cell.setCellValue(sLUserDefaultMM.get(i).getI_day_count());
					        cell = row.createCell(9);
					        cell.setCellValue(sLUserDefaultMM.get(i).getD_mm());
						            
					        rowIndex++;
						}	
					}
				}
				
			} else {
				
				fileName = "당월MM입력.xlsx";
				
				for(int i = 0; i < sLUserDefaultMM.size(); i++) {
					
					row = workSheet.createRow(rowIndex);
		        	
			       	cell = row.createCell(0);
			       	cell.setCellValue(sLUserDefaultMM.get(i).getD_job_date());
			       	cell = row.createCell(1);
			       	cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_code());
			       	cell = row.createCell(2);
			       	cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_code_name());
			       	cell = row.createCell(3);
			       	cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_name());
			       	cell = row.createCell(4);
			       	cell.setCellValue(sLUserDefaultMM.get(i).getV_man_seq());
			       	cell = row.createCell(5);
			       	cell.setCellValue(sLUserDefaultMM.get(i).getV_user_name_k());
			       	cell = row.createCell(6);
			       	cell.setCellValue(sLUserDefaultMM.get(i).getD_enter_date());
			       	cell = row.createCell(7);
			        cell.setCellValue(sLUserDefaultMM.get(i).getD_retirement_date());
			        cell = row.createCell(8);
			        cell.setCellValue(sLUserDefaultMM.get(i).getI_day_count());
			        cell = row.createCell(9);
			        cell.setCellValue(sLUserDefaultMM.get(i).getD_mm());
				            
			        rowIndex++;
				}
			}

			
		//관리자 M/M (팀별 입력 현황) 페이지
		} else if(sExcelType.equals("adminTeamExcel")) {
			
			String team_user_MM_seq = (String) model.get("search_user_seq");
			String sSearch_date = (String) model.get("search_date");
			List<GetDefaultMMBean> sLUserDefaultMM = (List<GetDefaultMMBean>) model.get("lUserDefaultMM");
			
			String[] sSearch_user_seq 				= team_user_MM_seq.split(",");
			
			Sheet workSheet = workBook.createSheet("팀별MM");
			
			System.out.println(">>>>>>>>>>>>>>>>>>> ExcelDown = adminTeamExcel <<<<<<<<<<<<<<<<<<<");
			
			int rowIndex = 1;
			
			Row row = workSheet.createRow(0);
			workSheet.setColumnWidth(3, (workSheet.getColumnWidth(3)+(short)1800));
			workSheet.setColumnWidth(7, (workSheet.getColumnWidth(7)+(short)1500));
			workSheet.setColumnWidth(8, (workSheet.getColumnWidth(8)+(short)5000));
			
	        Cell cell = row.createCell(0);
            cell.setCellValue("운영단위");
            cell = row.createCell(1);
            cell.setCellValue("작업년도");
            cell = row.createCell(2);
            cell.setCellValue("부서코드");
            cell = row.createCell(3);
            cell.setCellValue("부서명");
            cell = row.createCell(4);
            cell.setCellValue("사번");
            cell = row.createCell(5);
            cell.setCellValue("성명");
            cell = row.createCell(6);
            cell.setCellValue("당월 M/M");
            cell = row.createCell(7);
            cell.setCellValue("프로젝트 코드");
            cell = row.createCell(8);
            cell.setCellValue("프로젝트 명");
            cell = row.createCell(9);
            cell.setCellValue("투입 M/M");
            
			if(!sSearch_user_seq[0].equals("")) {
				
				fileName = sSearch_date + "_" + sLUserDefaultMM.get(0).getV_dept_name() + "_MM팀별입력현황.xlsx";
				
				for(int z = 0; sSearch_user_seq.length > z; z++) {
					String teamUserSeq = sSearch_user_seq[z];
					
					for(int i = 0; i < sLUserDefaultMM.size(); i++) {
						
						if(String.valueOf(sLUserDefaultMM.get(i).getI_user_number()).equals(teamUserSeq)) {
							row = workSheet.createRow(rowIndex);
							
					        if(i > 0) {
					        	
					        	if(!sLUserDefaultMM.get(i).getV_user_name_k().equals(sLUserDefaultMM.get(i-1).getV_user_name_k())) {
					        		
						            cell = row.createCell(0);
						            cell.setCellValue(sLUserDefaultMM.get(i).getS_op_type_name());
						            cell = row.createCell(1);
						            cell.setCellValue(sLUserDefaultMM.get(i).getD_job_date());
						            cell = row.createCell(2);
						            cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_code());
						            cell = row.createCell(3);
						            cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_name());
						            cell = row.createCell(4);
						            cell.setCellValue(sLUserDefaultMM.get(i).getV_man_seq());
						            cell = row.createCell(5);
						            cell.setCellValue(sLUserDefaultMM.get(i).getV_user_name_k());
						            cell = row.createCell(6);
						            cell.setCellValue(sLUserDefaultMM.get(i).getD_mm());
					        	}
					        } else {
						        	
						        cell = row.createCell(0);
						        cell.setCellValue(sLUserDefaultMM.get(i).getS_op_type_name());
						        cell = row.createCell(1);
						        cell.setCellValue(sLUserDefaultMM.get(i).getD_job_date());
						        cell = row.createCell(2);
						        cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_code());
						        cell = row.createCell(3);
						        cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_name());
						        cell = row.createCell(4);
						        cell.setCellValue(sLUserDefaultMM.get(i).getV_man_seq());
						        cell = row.createCell(5);
						        cell.setCellValue(sLUserDefaultMM.get(i).getV_user_name_k());
						        cell = row.createCell(6);
						        cell.setCellValue(sLUserDefaultMM.get(i).getD_mm());
					        }
					        
				            cell = row.createCell(7);
				            cell.setCellValue(sLUserDefaultMM.get(i).getV_project_code());
				            cell = row.createCell(8);
				            cell.setCellValue(sLUserDefaultMM.get(i).getV_project_name());
				            cell = row.createCell(9);
				            cell.setCellValue(sLUserDefaultMM.get(i).getD_mm_user());
				            
				            rowIndex++;
						}
					}
				}
				
			} else {
				
				fileName = "MM팀별입력현황.xlsx";
				
				for(int i = 0; i < sLUserDefaultMM.size(); i++) {
			        row = workSheet.createRow(rowIndex);
			        
			        if(i > 0) {
			        	
			        	if(!sLUserDefaultMM.get(i).getV_user_name_k().equals(sLUserDefaultMM.get(i-1).getV_user_name_k())) {
			        		
				            cell = row.createCell(0);
				            cell.setCellValue(sLUserDefaultMM.get(i).getS_op_type_name());
				            cell = row.createCell(1);
				            cell.setCellValue(sLUserDefaultMM.get(i).getD_job_date());
				            cell = row.createCell(2);
				            cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_code());
				            cell = row.createCell(3);
				            cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_name());
				            cell = row.createCell(4);
				            cell.setCellValue(sLUserDefaultMM.get(i).getV_man_seq());
				            cell = row.createCell(5);
				            cell.setCellValue(sLUserDefaultMM.get(i).getV_user_name_k());
				            cell = row.createCell(6);
				            cell.setCellValue(sLUserDefaultMM.get(i).getD_mm());
			        	}
			        } else {
				        	
				        cell = row.createCell(0);
				        cell.setCellValue(sLUserDefaultMM.get(i).getS_op_type_name());
				        cell = row.createCell(1);
				        cell.setCellValue(sLUserDefaultMM.get(i).getD_job_date());
				        cell = row.createCell(2);
				        cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_code());
				        cell = row.createCell(3);
				        cell.setCellValue(sLUserDefaultMM.get(i).getV_dept_name());
				        cell = row.createCell(4);
				        cell.setCellValue(sLUserDefaultMM.get(i).getV_man_seq());
				        cell = row.createCell(5);
				        cell.setCellValue(sLUserDefaultMM.get(i).getV_user_name_k());
				        cell = row.createCell(6);
				        cell.setCellValue(sLUserDefaultMM.get(i).getD_mm());
			        }
			        
		            cell = row.createCell(7);
		            cell.setCellValue(sLUserDefaultMM.get(i).getV_project_code());
		            cell = row.createCell(8);
		            cell.setCellValue(sLUserDefaultMM.get(i).getV_project_name());
		            cell = row.createCell(9);
		            cell.setCellValue(sLUserDefaultMM.get(i).getD_mm_user());
			            
		            rowIndex++;
				}
			}
		}
		
		response.setContentType("application/smnet");
        response.setHeader("Content-Disposition","attachment; filename=\""+new String((fileName).getBytes("KSC5601"),"8859_1")+"\"");
		OutputStream fos = response.getOutputStream();
		workBook.write(fos);
		fos.close();
	}

}
