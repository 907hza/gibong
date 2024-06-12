package com.gibong.web.model;
import java.io.Serializable;

public class KakaoPayOrder implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private String tid;	// 결제 고유 번호
	private String pgToken; // 결제 승인 요청을 인증하는 토큰
	
	private String partnerOrderId;	// String	O	가맹점 주문번호, 최대 100자
	private String partnerUserId;	// String	O	가맹점 회원 id, 최대 100자
	private String itemName;	// String	O	상품명, 최대 100자
	private String itemCode;
	private int quantity;	// Integer	O	상품 수량
	private int totalAmount;	// Integer	O	상품 총액
	private int taxFreeAmount;	// Integer	O	상품 비과세 금액
	private int vatAmount;
	
	public KakaoPayOrder() 
	{
		tid = "";
		pgToken = "";
		
		partnerOrderId = "";
		partnerUserId = "";
		itemName = "";
		itemCode = "";
		
		quantity = 0;
		totalAmount = 0;
		taxFreeAmount = 0;
		vatAmount = 0;
	}

	public int getVatAmount() {
		return vatAmount;
	}

	public void setVatAmount(int vatAmount) {
		this.vatAmount = vatAmount;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getPgToken() {
		return pgToken;
	}

	public void setPgToken(String pgToken) {
		this.pgToken = pgToken;
	}

	public String getPartnerOrderId() {
		return partnerOrderId;
	}

	public void setPartnerOrderId(String partnerOrderId) {
		this.partnerOrderId = partnerOrderId;
	}

	public String getPartnerUserId() {
		return partnerUserId;
	}

	public void setPartnerUserId(String partnerUserId) {
		this.partnerUserId = partnerUserId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(int totalAmount) {
		this.totalAmount = totalAmount;
	}

	public int getTaxFreeAmount() {
		return taxFreeAmount;
	}

	public void setTaxFreeAmount(int taxFreeAmount) {
		this.taxFreeAmount = taxFreeAmount;
	}
}
