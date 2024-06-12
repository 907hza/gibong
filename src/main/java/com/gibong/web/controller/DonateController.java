package com.gibong.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gibong.web.model.Donate;
import com.gibong.web.service.DonateService;
import com.gibong.web.util.CookieUtil;
import com.gibong.web.util.HttpUtil;

@Controller("donateController")
public class DonateController 
{
	private static Logger logger = LoggerFactory.getLogger(DonateController.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Value("#{env['upload.donate.save.dir']}")
	public String UPLOAD_DONATE_DIR;
	
	@Autowired
	private DonateService donateService;
	
	// 후원 리스트 보여주는 화면
	@RequestMapping(value="/donate/donateList")
	public String donateList(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{						
		List<Donate> list = null;
		Donate donate = new Donate();
				
		long totalCount = donateService.donateCnt(donate);
				
		if(totalCount > 0)
		{
			list = donateService.donateSelect(donate);
			
			if(list.size() > 0)
			{
				for(int i=0 ; i<list.size(); i++)
				{
					list.get(i).setDonateFile(donateService.donateFileSelect(list.get(i).getDonateSeq()));
				}
			}
		}
		
		modelMap.addAttribute("list", list);
		
		return "/donate/donateList"; 
	}
	
	// 후원 상세 화면 보여주기
	@RequestMapping(value="/donate/donateView")
	public String donateView(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long donateSeq = HttpUtil.get(request, "donateSeq", (long)0);
		
		Donate donate = null;
		
		if(donateSeq > 0)
		{
			donate = donateService.donateView(donateSeq);
		}
		
		modelMap.addAttribute("donate", donate);
		modelMap.addAttribute("cookieUserId", userId);
		
		return "/donate/donateView";
	}
	
}
