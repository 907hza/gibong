package com.gibong.web.service;

import java.net.URI;
import java.net.URISyntaxException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.gibong.web.model.KakaoPayApprove;
import com.gibong.web.model.KakaoPayOrder;
import com.gibong.web.model.kakaoPayReady;

@Service("kakaoPayService")
public class KakaoPayService 
{
	private static Logger logger = LoggerFactory.getLogger(KakaoPayService.class);
	
	@Value("#{env['kakao.pay.host']}") // 카카오페이 호스트 
	private String KAKAO_PAY_HOST;
	
	@Value("#{env['kakao.pay.admin.key']}") // 카카오페이 관리자 키 
	private String KAKAO_PAY_ADMIN_KEY;
	
	@Value("#{env['kakao.pay.cid']}") // 카카오페이 가맹점 코드, 10자 
	private String KAKAO_PAY_CID;
	
	@Value("#{env['kakao.pay.ready.url']}") // 카카오페이 결제 url
	private String KAKAO_PAY_READY_URL;
	
	@Value("#{env['kakao.pay.approve.url']}") // 카카오페이 결제 요청 url
	private String KAKAO_PAY_APPROVE_URL;
	
	@Value("#{env['kakao.pay.success.url']}") // 카카오페이 결제 성공 url
	private String KAKAO_PAY_SUCCESS_URL;
	
	@Value("#{env['kakao.pay.cancle.url']}") // 카카오페이 결제 취소 url
	private String KAKAO_PAY_CANCLE_URL;
	
	@Value("#{env['kakao.pay.fail.url']}") // 카카오페이 결제 실패 url
	private String KAKAO_PAY_FAIL_URL;
	
	// 결제 준비하는 비즈니스 로직
	public kakaoPayReady kakaoPayReady(KakaoPayOrder kakaoPayOrder)
	{	
		kakaoPayReady kakaoPayReady = new kakaoPayReady();
		
		if(kakaoPayOrder != null)
		{
			// 스프링에서 지원하는 객체로 간편하게 rest 방식 API 를 호출할 수 있는 스프링 내장 클래스
			RestTemplate restTemplate = new RestTemplate();
			
			// 서버로 요청할 헤더 를 담는 스프링 내장 클래스
			HttpHeaders headers = new HttpHeaders();
			
			headers.add("Authorization", "KakaoAK " + KAKAO_PAY_ADMIN_KEY);
	         //Content-type: application/x-www-form-urlencoded;charset=utf-8
	         //              application/x-www-form-urlencoded 우리가 한 건 이렇게 나오게 돼서 뒤에 ; charset 만 붙여주면 된당
			headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + "; charset=UTF-8"); 

			// 서버 (카카오) 로 요청할 바디 // 리스트 형태로 받아온디
			MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
			
			// request body payload 필수 항목들을 세팅해준다
			params.add("cid", KAKAO_PAY_CID);
			params.add("partner_order_id", kakaoPayOrder.getPartnerOrderId());	
			params.add("partner_user_id", kakaoPayOrder.getPartnerUserId());	
			
			params.add("item_name", kakaoPayOrder.getItemName());		
			params.add("item_code", kakaoPayOrder.getItemCode());		
			params.add("quantity", String.valueOf(kakaoPayOrder.getQuantity()));
			params.add("total_amount", String.valueOf(kakaoPayOrder.getTotalAmount()));		
			params.add("tax_free_amount", String.valueOf(kakaoPayOrder.getTaxFreeAmount()));
			
			params.add("approval_url", KAKAO_PAY_SUCCESS_URL);		
			params.add("cancel_url", KAKAO_PAY_CANCLE_URL);		
			params.add("fail_url", KAKAO_PAY_FAIL_URL);	
			
			// 요청을 하기 위해서 헤더와 바디 합치기 
			// 스프링 프레임워크에서 제공해주는 httpEntity 클래스에 헤더와 바디합치기
			HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
			// 여기 class 에 카카오페이가 값을 담아보내준다
			
			try
			{
				// postForObject 메소드는 POST  요청을 보내고 객체로 결과를 반환
				kakaoPayReady = restTemplate.postForObject(new URI(KAKAO_PAY_HOST + KAKAO_PAY_READY_URL), body, kakaoPayReady.class);
				
				if(kakaoPayReady != null)
				{
					kakaoPayOrder.setTid(kakaoPayReady.getTid());
				}
			}
			catch(URISyntaxException e)
			{
				logger.error("[KakaoPayService] kakaoPayReady URISynTaxException", e);
			}
		}
		else
		{
			logger.error("[KakaoPayService] kakaoPayReady kakaoPayOrder is null");
		}
		
		return kakaoPayReady;
	}
	
	// 승인 요청
	public KakaoPayApprove kakaoPayApprove(KakaoPayOrder kakaoPayOrder)
	{
		KakaoPayApprove kakaoPayApprove = null;
		
		if(kakaoPayOrder != null)
		{
			RestTemplate restTemplate = new RestTemplate();
			
			// 서버로 요청할 헤더
			HttpHeaders headers = new HttpHeaders();
			headers.add("Authorization", "KakaoAK " + KAKAO_PAY_ADMIN_KEY);
	         //Content-type: application/x-www-form-urlencoded;charset=utf-8
	         //              application/x-www-form-urlencoded 우리가 한 건 이렇게 나오게 돼서 뒤에 ; charset 만 붙여주면 된당
			
			headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + "; charset=UTF-8"); 

			// 서버로 요청할 바디
			MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
			
			params.add("cid", KAKAO_PAY_CID);	// 가맹점 코드, 10자
			params.add("tid", kakaoPayOrder.getTid());	// 결제 고유번호, 결제 준비 API 응답에 포함
			params.add("partner_order_id", kakaoPayOrder.getPartnerOrderId()); 	// 가맹점 주문번호, 결제 준비 API 요청과 일치해야 함
			params.add("partner_user_id", kakaoPayOrder.getPartnerUserId()); 	// 가맹점 회원 id, 결제 준비 API 요청과 일치해야 함
			params.add("pg_token", kakaoPayOrder.getPgToken()); 	// 결제승인 요청을 인증하는 토큰
			            // 사용자 결제 수단 선택 완료 시, approval_url로 redirection해줄 때 pg_token을 query string으로 전달
			
			
			// 헤더랑 바디 합치기
			HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
			
			try
			{
				// 요청보내기
				kakaoPayApprove = restTemplate.postForObject
						(new URI(KAKAO_PAY_HOST + KAKAO_PAY_APPROVE_URL), body, KakaoPayApprove.class);
			
				if(kakaoPayApprove != null)
				{
					logger.debug("=======================================================");
					logger.debug("[KakaoPayService] kakaoPAyApprove : " + kakaoPayApprove);
					logger.debug("=======================================================");
				}
			}
			catch(URISyntaxException e)
			{
				logger.error("[KakaoPayService] kakaoPayApprove URISyntaxException", e);
			}
		}
		else
		{
			logger.error("[KakaoPayService] kakaoPayApprove kakaoPayOrder is null");
		}
		
		return kakaoPayApprove;
	}
}
