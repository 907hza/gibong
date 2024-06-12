package com.gibong.web.model;
import java.io.Serializable;

public class PayLog implements Serializable // 후원 내역을 저장하는 곳
{
	private static final long serialVersionUID = 1L;
	
	private long payLogSeq; // 후원내역 seq
	private long donateSeq; // 후원글 seq
	private String userId; // 유저 아이디
	private String payCode; // 결제코드(카카오)
	private String payFlag; // 결제flag(결제취소/결제완료)
	private String regdate; // 결제일
	private long payMoney; // 결제금액
	
	public PayLog()
	{
		payLogSeq = 0;
		donateSeq = 0;
		userId = "";
		payCode = "";
		payFlag = "";
		regdate = "";
		payMoney = 0;
	}

	public long getPayLogSeq() {
		return payLogSeq;
	}

	public void setPayLogSeq(long payLogSeq) {
		this.payLogSeq = payLogSeq;
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

	public String getPayCode() {
		return payCode;
	}

	public void setPayCode(String payCode) {
		this.payCode = payCode;
	}

	public String getPayFlag() {
		return payFlag;
	}

	public void setPayFlag(String payFlag) {
		this.payFlag = payFlag;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public long getPayMoney() {
		return payMoney;
	}

	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
	}
}
