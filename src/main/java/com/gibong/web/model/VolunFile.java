package com.gibong.web.model;
import java.io.Serializable;

public class VolunFile implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long volunSeq;
	private long fileSeq;
	private String fileOrgName;
	private String fileName;
	private String fileExt;
	private long fileSize;
	private String regdate;
	
	public VolunFile()
	{
		volunSeq = 0;
		fileSeq = 0;
		fileOrgName = "";
		fileName = "";
		fileExt = "";
		fileSize = 0;
		regdate = "";
	}

	public long getVolunSeq() {
		return volunSeq;
	}

	public void setVolunSeq(long volunSeq) {
		this.volunSeq = volunSeq;
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
