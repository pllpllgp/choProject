package com.gravity.mm.util;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public final class DateTime {
	
	Calendar cal = Calendar.getInstance();
	
	
	/**
	 * 년 조회 
	 * @return getYear
	 * @throws Exception
	 */
	public static int getYear() {
		return getNumberByPattern("yyyy");
	}
	
	
	/**
	 * 월 조회 
	 * @return getMonth
	 * @throws Exception
	 */
	public static int getMonth() {
		return getNumberByPattern("MM");
	}
	
	
	/**
	 * 날짜 조회 
	 * @return getNumberByPattern
	 * @throws Exception
	 */
	public static int getNumberByPattern(String pattern) {
		java.text.SimpleDateFormat formatter =
            new java.text.SimpleDateFormat (pattern, java.util.Locale.KOREA);
		String dateString = formatter.format(new java.util.Date());
		return Integer.parseInt(dateString);
	}
	
	
	/**
	 * 년월 목록 조회 
	 * @return monthList
	 * @throws Exception
	 */
	public static List<String> getMonthList(String user) {
		
		int iYear = getYear();
		int iMonth = 0;
		int monList = 0;
		
		if(user.equals("user")) {
			
			monList = 5;
			iMonth = getMonth()-1;
			
			if(iMonth == 0) {
				
				iYear -= 1;
				iMonth = 12;
			}
		} else if(user.equals("admin")) {
			
			monList = 6;
			iMonth = getMonth();
		}
		List<String> lMonth = new ArrayList<String>();
		System.out.println("iMonth : " + iMonth);
		for (int i = 0; i < monList; i++) {
			
			String sMonth = Integer.toString(iYear)+"-" ;
				   sMonth += Integer.toString(iMonth).length() == 1 ? "0" + Integer.toString(iMonth) : Integer.toString(iMonth);
			lMonth.add(sMonth);
			
			if (iMonth == 1) {
				
				iYear -= 1;
				iMonth = 12;
			}else {
				
				iMonth -= 1;
			}
		}
		return lMonth;
		
	}

}
