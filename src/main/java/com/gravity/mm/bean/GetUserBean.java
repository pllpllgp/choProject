package com.gravity.mm.bean;

public class GetUserBean {
	
	private String userSEQ;
	private String userID;
	private String userMail;
	private String userNum;
	private String userName;
	private String userUse;
	private String userDeptName;
	private String userAuthYN;
	private int userAuthCount;
	private String v_confirmor;
	
	
	public int getUserAuthCount() {
		return userAuthCount;
	}
	public void setUserAuthCount(int userAuthCount) {
		this.userAuthCount = userAuthCount;
	}
	
	
	public String getUserAuthYN() {
		return userAuthYN;
	}
	public void setUserAuthYN(String userAuthYN) {
		this.userAuthYN = userAuthYN;
	}
	
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	
	
	public String getUserMail() {
		return userMail;
	}
	public void setUserMail(String userMail) {
		this.userMail = userMail;
	}
	
	
	public String getUserUse() {
		return userUse;
	}
	public void setUserUse(String userUse) {
		this.userUse = userUse;
	}
	
	
	public String getUserSEQ() {
		return userSEQ;
	}
	public void setUserSEQ(String userSEQ) {
		this.userSEQ = userSEQ;
	}
	
	
	public String getUserNum() {
		return userNum;
	}
	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}
	
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
	public String getUserDeptName() {
		return userDeptName;
	}
	public void setUserDeptName(String userDeptName) {
		this.userDeptName = userDeptName;
	}
	
	
	public String getV_confirmor() {
		return v_confirmor;
	}
	public void setV_confirmor(String v_confirmor) {
		this.v_confirmor = v_confirmor;
	}
	
	

}
