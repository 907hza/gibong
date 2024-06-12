package com.gibong.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.gibong.common.util.StringUtil;
import com.gibong.web.model.KakaoPayApprove;
import com.gibong.web.model.KakaoPayOrder;
import com.gibong.web.model.kakaoPayReady;
import com.gibong.web.model.Response;
import com.gibong.web.service.KakaoPayService;
import com.gibong.web.util.CookieUtil;
import com.gibong.web.util.HttpUtil;

@Controller("kakaoPayController")
public class KakaoPayController 
{	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	private static Logger logger = LoggerFactory.getLogger(KakaoPayController.class);
	
	@Autowired
	private KakaoPayService kakaoPayService;
	
	@RequestMapping(value="/kakao/pay")
	public String pay(HttpServletRequest request, HttpServletResponse response)
	{
		return "/kakao/pay"; // 넘기는 값 없이 화면만 보여줄 것
	}
	
	@RequestMapping(value="/kakao/payReady", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> payReady(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String orderId = StringUtil.uniqueValue(); //  유효한 아이디값을 가지고온다 UUID
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		String itemCode = HttpUtil.get(request, "itemCode","");
		String itemName = HttpUtil.get(request, "itemName","");
		int quantity = HttpUtil.get(request, "quantity", 0);
		int totalAmount = HttpUtil.get(request, "totalAmount", 0);
		int taxFreeAmount = HttpUtil.get(request, "taxFreeAmount", 0);
		int vatAmount = HttpUtil.get(request, "vatAmount", 0);
		
		KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();
		
		kakaoPayOrder.setPartnerOrderId(orderId);
		kakaoPayOrder.setPartnerUserId(userId);
		
		kakaoPayOrder.setItemCode(itemCode);
		kakaoPayOrder.setItemName(itemName);
		kakaoPayOrder.setQuantity(quantity);
		kakaoPayOrder.setTotalAmount(totalAmount);
		kakaoPayOrder.setTaxFreeAmount(taxFreeAmount);
		kakaoPayOrder.setVatAmount(vatAmount);
		
		kakaoPayReady kakaoPayReady = kakaoPayService.kakaoPayReady(kakaoPayOrder);
		
		if(kakaoPayReady != null)
		{
			logger.debug("[KakaoPayController] payReady : " + kakaoPayReady);
			
			kakaoPayOrder.setTid(kakaoPayReady.getTid()); // kakaoPayService 에서 kakaoPayReady 함수와 동일한 로직이 중복 발생
			
			JsonObject json = new JsonObject();
			json.addProperty("orderId", orderId);
			json.addProperty("tId", kakaoPayOrder.getTid());
			json.addProperty("appUrl", kakaoPayReady.getNext_redirect_app_url());
			json.addProperty("mobileUrl", kakaoPayReady.getNext_redirect_mobile_url());
			json.addProperty("pcUrl", kakaoPayReady.getNext_redirect_pc_url());
			
			ajaxResponse.setResponse(0, "success", json);
			
		}
		else
		{
			ajaxResponse.setResponse(-1, "fail", null);
		}
		
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/kakao/payPopUp", method=RequestMethod.POST)
	public String payPopUp(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		String pcUrl = HttpUtil.get(request, "pcUrl");
		String orderId = HttpUtil.get(request, "orderId");
		String tId = HttpUtil.get(request, "tId");
		
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		modelMap.addAttribute("pcUrl",pcUrl);
		modelMap.addAttribute("orderId", orderId);
		modelMap.addAttribute("tId", tId);
		modelMap.addAttribute("userId", userId);
		
		logger.debug("=================");
		logger.debug("pcUrl : " + pcUrl);
		logger.debug("=================");
		
		return "/kakao/payPopUp";
	}
	
	@RequestMapping(value="/kakao/paySuccess")
	public String paySuccess(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		String pgToken = HttpUtil.get(request, "pg_token",""); // 얘는 카톡에서 보내주는 거라 이름을 맞춰줘야한다
		
		modelMap.addAttribute("pgToken", pgToken);
		
		return "/kakao/paySuccess";
	}
	
	@RequestMapping(value="/kakao/payResult")
	public String payResult(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		KakaoPayApprove kakaoPayApprove = null;
		
		String tId = HttpUtil.get(request, "tId","");
		String orderId = HttpUtil.get(request, "orderId","");
		String pgToken = HttpUtil.get(request, "pgToken","");
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		KakaoPayOrder kakaoPayOrder  = new KakaoPayOrder();
		
		kakaoPayOrder.setPartnerOrderId(orderId);
		kakaoPayOrder.setPartnerUserId(userId);
		kakaoPayOrder.setTid(tId);
		kakaoPayOrder.setPgToken(pgToken);
		
		kakaoPayApprove = kakaoPayService.kakaoPayApprove(kakaoPayOrder);
		modelMap.addAttribute("kakaoPayApprove", kakaoPayApprove);
		
		return "/kakao/payResult";
	}
	
	@RequestMapping(value="/kakao/payCancle")
	public String payCancle(HttpServletRequest request, HttpServletResponse response)
	{
		return "/kakao/payCancle";
	}
	
	@RequestMapping(value="/kakao/payFail")
	public String payFail(HttpServletRequest request, HttpServletResponse response)
	{
		return "/kakao/payFail";
	}
}
