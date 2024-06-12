package com.gibong.web.model;
import java.io.Serializable;

public class Volun implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long volunSeq;
	private String volunDelFlag;
	private String userId;
	private String volunType;
	private String volunTitle;
	private String volunContent;
	private String regdate;
	private String endRegdate;
	private long volunPeople;
	private long volunTime;
	private String volunDate;
	private String volunDae;
	
	private long startRow;
	private long endRow;
	
	private VolunFile volunFile;
	
	public Volun()
	{
		volunSeq = 0;
		volunDelFlag = "";
		userId = "";
		volunType = "";
		volunTitle = "";
		volunContent = "";
		regdate = "";
		endRegdate = "";
		volunPeople = 0;
		volunTime = 0;
		volunDate = "";
		volunDae = "";
		
		startRow = 0;
		endRow = 0;
		
		volunFile = null;
	}
	
	

	public String getVolunDae() {
		return volunDae;
	}



	public void setVolunDae(String volunDae) {
		this.volunDae = volunDae;
	}



	public long getVolunPeople() {
		return volunPeople;
	}



	public void setVolunPeople(long volunPeople) {
		this.volunPeople = volunPeople;
	}



	public long getVolunTime() {
		return volunTime;
	}



	public void setVolunTime(long volunTime) {
		this.volunTime = volunTime;
	}



	public String getVolunDate() {
		return volunDate;
	}



	public void setVolunDate(String volunDate) {
		this.volunDate = volunDate;
	}



	public String getEndRegdate() {
		return endRegdate;
	}


	public void setEndRegdate(String endRegdate) {
		this.endRegdate = endRegdate;
	}


	public long getStartRow() {
		return startRow;
	}


	public void setStartRow(long startRow) {
		this.startRow = startRow;
	}


	public long getEndRow() {
		return endRow;
	}


	public void setEndRow(long endRow) {
		this.endRow = endRow;
	}


	public VolunFile getVolunFile() {
		return volunFile;
	}


	public void setVolunFile(VolunFile volunFile) {
		this.volunFile = volunFile;
	}


	public long getVolunSeq() {
		return volunSeq;
	}

	public void setVolunSeq(long volunSeq) {
		this.volunSeq = volunSeq;
	}

	public String getVolunDelFlag() {
		return volunDelFlag;
	}

	public void setVolunDelFlag(String volunDelFlag) {
		this.volunDelFlag = volunDelFlag;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getVolunType() {
		return volunType;
	}

	public void setVolunType(String volunType) {
		this.volunType = volunType;
	}

	public String getVolunTitle() {
		return volunTitle;
	}

	public void setVolunTitle(String volunTitle) {
		this.volunTitle = volunTitle;
	}

	public String getVolunContent() {
		return volunContent;
	}

	public void setVolunContent(String volunContent) {
		this.volunContent = volunContent;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
}
