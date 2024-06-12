package com.gibong.web.model;
import java.io.Serializable;

public class ReviewReply implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private String userId;
	private String userName;
	private long reviewReplySeq;
	private long reviewSeq;
	private String replyDelFlag;
	private String reviewReplyContent;
	private long reviewReplyGroup;
	private long reviewReplyOrder;
	private long reviewReplyIndent;
	private String regdate;
	
	public ReviewReply()
	{
		userId = "";
		userName = "";
		reviewReplySeq = 0;
		reviewSeq = 0;
		replyDelFlag = "";
		reviewReplyContent = "";
		reviewReplyGroup = 0;
		reviewReplyOrder = 0;
		reviewReplyIndent = 0;
		regdate = "";
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public long getReviewReplySeq() {
		return reviewReplySeq;
	}

	public void setReviewReplySeq(long reviewReplySeq) {
		this.reviewReplySeq = reviewReplySeq;
	}

	public long getReviewSeq() {
		return reviewSeq;
	}

	public void setReviewSeq(long reviewSeq) {
		this.reviewSeq = reviewSeq;
	}

	public String getReplyDelFlag() {
		return replyDelFlag;
	}

	public void setReplyDelFlag(String replyDelFlag) {
		this.replyDelFlag = replyDelFlag;
	}

	public String getReviewReplyContent() {
		return reviewReplyContent;
	}

	public void setReviewReplyContent(String reviewReplyContent) {
		this.reviewReplyContent = reviewReplyContent;
	}

	public long getReviewReplyGroup() {
		return reviewReplyGroup;
	}

	public void setReviewReplyGroup(long reviewReplyGroup) {
		this.reviewReplyGroup = reviewReplyGroup;
	}

	public long getReviewReplyOrder() {
		return reviewReplyOrder;
	}

	public void setReviewReplyOrder(long reviewReplyOrder) {
		this.reviewReplyOrder = reviewReplyOrder;
	}

	public long getReviewReplyIndent() {
		return reviewReplyIndent;
	}

	public void setReviewReplyIndent(long reviewReplyIndent) {
		this.reviewReplyIndent = reviewReplyIndent;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
}
