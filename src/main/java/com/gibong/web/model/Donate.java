package com.gibong.web.model;
import java.io.Serializable;

public class Donate implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long donateSeq;
	private String userId;
	private String donateFlag;
	private String donateTitle;
	private String donateContent;
	private String regdate;
	private String endRegdate;
	private long donateNowAmt;
	private long donateGoalAmt;
	private String finishFlag;
	
	private DonateFile donateFile;
	
	public Donate() 
	{
		donateSeq = 0;
		userId = "";
		donateFlag = "";
		donateTitle = "";
		donateContent = "";
		regdate = "";
		donateNowAmt = 0;
		donateGoalAmt = 0;
		finishFlag = "";
		
		donateFile = null;
	}
	
	

	public String getEndRegdate() {
		return endRegdate;
	}



	public void setEndRegdate(String endRegdate) {
		this.endRegdate = endRegdate;
	}



	public long getDonateSeq() {
		return donateSeq;
	}

	public void setDonateSeq(long donateSeq) {
		this.donateSeq = donateSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getDonateFlag() {
		return donateFlag;
	}

	public void setDonateFlag(String donateFlag) {
		this.donateFlag = donateFlag;
	}

	public String getDonateTitle() {
		return donateTitle;
	}

	public void setDonateTitle(String donateTitle) {
		this.donateTitle = donateTitle;
	}

	public String getDonateContent() {
		return donateContent;
	}

	public void setDonateContent(String donateContent) {
		this.donateContent = donateContent;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public long getDonateNowAmt() {
		return donateNowAmt;
	}

	public void setDonateNowAmt(long donateNowAmt) {
		this.donateNowAmt = donateNowAmt;
	}

	public long getDonateGoalAmt() {
		return donateGoalAmt;
	}

	public void setDonateGoalAmt(long donateGoalAmt) {
		this.donateGoalAmt = donateGoalAmt;
	}

	public String getFinishFlag() {
		return finishFlag;
	}

	public void setFinishFlag(String finishFlag) {
		this.finishFlag = finishFlag;
	}

	public DonateFile getDonateFile() {
		return donateFile;
	}

	public void setDonateFile(DonateFile donateFile) {
		this.donateFile = donateFile;
	}
	
}
