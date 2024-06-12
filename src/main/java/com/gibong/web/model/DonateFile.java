package com.gibong.web.model;
import java.io.Serializable;

public class DonateFile implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long donateSeq;
	private long fileSeq;
	private String fileOrgName;
	private String fileName;
	private String fileExt;
	private long fileSize;
	private String regdate;
	
	public DonateFile()
	{
		donateSeq = 0;
		fileSeq = 0;
		fileOrgName = "";
		fileName = "";
		fileExt = "";
		fileSize = 0;
		regdate = "";
	}

	public long getDonateSeq() {
		return donateSeq;
	}

	public void setDonateSeq(long donateSeq) {
		this.donateSeq = donateSeq;
	}

	public long getFileSeq() {
		return fileSeq;
	}

	public void setFileSeq(long fileSeq) {
		this.fileSeq = fileSeq;
	}

	public String getFileOrgName() {
		return fileOrgName;
	}

	public void setFileOrgName(String fileOrgName) {
		this.fileOrgName = fileOrgName;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileExt() {
		return fileExt;
	}

	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
}
