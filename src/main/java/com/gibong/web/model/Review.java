package com.gibong.web.model;
import java.io.Serializable;
import java.util.List;

public class Review implements Serializable
{
	private static long serialVersionUID = 1L;
	
	private long reviewSeq;
	private String userId;
	
	private String userName;
	private String reviewTitle;
	private String reviewContent;
	private String reviewDelFlag;
	private long reviewReadCnt;
	private long reviewLikeCnt;
	private String regdate;
		
	private String searchType;
	private String searchValue;
	private long curPage;
	
	private long startRow;
	private long endRow;
	
	private List<ReviewFile> reviewFile;
	
	private List<ReviewReply> reviewReply;
	
	private String viewFlag;
	
	public Review()
	{
		reviewSeq = 0;
		userId = "";
		
		userName = "";
		reviewTitle = "";
		reviewContent = "";
		reviewDelFlag = "";
		reviewReadCnt = 0;
		reviewLikeCnt = 0;
		regdate = "";
				
		searchType = "";
		searchValue = "";
		curPage = 0;
		
		startRow = 0;
		endRow = 0;
		
		reviewFile = null;
		reviewReply = null;
		
		viewFlag = "";
	}



	public String getViewFlag() {
		return viewFlag;
	}



	public void setViewFlag(String viewFlag) {
		this.viewFlag = viewFlag;
	}



	public List<ReviewReply> getReviewReply() {
		return reviewReply;
	}



	public void setReviewReply(List<ReviewReply> reviewReply) {
		this.reviewReply = reviewReply;
	}



	public List<ReviewFile> getReviewFile() {
		return reviewFile;
	}



	public void setReviewFile(List<ReviewFile> reviewFile) {
		this.reviewFile = reviewFile;
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

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

	public long getCurPage() {
		return curPage;
	}

	public void setCurPage(long curPage) {
		this.curPage = curPage;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}



	public long getReviewSeq() {
		return reviewSeq;
	}

	public void setReviewSeq(long reviewSeq) {
		this.reviewSeq = reviewSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getReviewTitle() {
		return reviewTitle;
	}

	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public String getReviewDelFlag() {
		return reviewDelFlag;
	}

	public void setReviewDelFlag(String reviewDelFlag) {
		this.reviewDelFlag = reviewDelFlag;
	}

	public long getReviewReadCnt() {
		return reviewReadCnt;
	}

	public void setReviewReadCnt(long reviewReadCnt) {
		this.reviewReadCnt = reviewReadCnt;
	}

	public long getReviewLikeCnt() {
		return reviewLikeCnt;
	}

	public void setReviewLikeCnt(long reviewLikeCnt) {
		this.reviewLikeCnt = reviewLikeCnt;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
}
