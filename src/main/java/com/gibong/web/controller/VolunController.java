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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gibong.common.model.FileData;
import com.gibong.common.util.StringUtil;
import com.gibong.web.model.Paging;
import com.gibong.web.model.Response;
import com.gibong.web.model.User;
import com.gibong.web.model.Volun;
import com.gibong.web.service.UserService;
import com.gibong.web.service.VolunService;
import com.gibong.web.util.CookieUtil;
import com.gibong.web.util.HttpUtil;

@Controller("volunController")
public class VolunController 
{
	private static Logger logger = LoggerFactory.getLogger(VolunController.class);
	
	private static final int PAGE_NUM = 6; // 한 페이지당 나올 글 수
	private static final int BTN_NUM = 3; // 한 페이지당 페이징 버튼 수
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Value("#{env['upload.volun.save.dir']}")
	private String UPLOAD_VOLUN_DIR;
	
	@Autowired
	private VolunService volunService;
	
	@Autowired
	private UserService userService;
	
	
	// 마이페이지 > 나의 봉사활동 화면
	@RequestMapping(value="/user/myPage/myVolun")
	public String myVolun(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/myPage/myVolun";
	}
	
	// 봉사활동 리스트
	@RequestMapping(value="/volun/volunList")
	public String volunList(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		long curPage = HttpUtil.get(request, "curPage",(long)1);
		
		User user = userService.userSelect(userId);
		
		List<Volun> list = null;
		
		Volun volun = new Volun();
		
		Paging paging = null;
		long totalCount = volunService.volunTotalCnt(volun);
		
		if(totalCount > 0)
		{
			paging = new Paging("/volun/volunList", totalCount, PAGE_NUM, BTN_NUM, curPage, "curPage");
			
			volun.setEndRow(paging.getEndRow());
			volun.setStartRow(paging.getStartRow());
			
			list = volunService.volunList(volun);
						
			if(list.size() > 0)
			{
				for(int i=0 ; i<list.size(); i++)
				{
					list.get(i).setVolunFile(volunService.volunFileSelect(list.get(i).getVolunSeq()));
				}
			}
		}
		
		modelMap.addAttribute("user", user);
		
		modelMap.addAttribute("paging", paging);
		modelMap.addAttribute("list", list);
		modelMap.addAttribute("curPage", curPage);
		
		return "/volun/volunList";
	}
	
	// 봉사 모집 중 리스트
	@RequestMapping(value="/volun/volunMoList")
	public String volunMoList(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		long curPage = HttpUtil.get(request, "curPage",(long)1);
		
		User user = userService.userSelect(userId);
		
		List<Volun> list = null;
		
		Volun volun = new Volun();
		
		Paging paging = null;
		long totalCount = volunService.volunTotalCnt(volun);
		
		if(totalCount > 0)
		{
			paging = new Paging("/volun/volunList", totalCount, PAGE_NUM, BTN_NUM, curPage, "curPage");
			
			volun.setEndRow(paging.getEndRow());
			volun.setStartRow(paging.getStartRow());
			
			list = volunService.volunMoList(volun);
						
			if(list.size() > 0)
			{
				for(int i=0 ; i<list.size(); i++)
				{
					list.get(i).setVolunFile(volunService.volunFileSelect(list.get(i).getVolunSeq()));
				}
			}
		}
		
		modelMap.addAttribute("user", user);
		
		modelMap.addAttribute("paging", paging);
		modelMap.addAttribute("list", list);
		modelMap.addAttribute("curPage", curPage);
		
		return "/volun/volunList";
	}
	
	// 봉사활동 글 작성
	@RequestMapping(value="/volun/volunWrite")
	public String volunWrite(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		long curPage = HttpUtil.get(request, "curPage",(long)1);
		
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		User user = userService.userSelect(userId);
		
		modelMap.addAttribute("user", user);
		modelMap.addAttribute("curPage", curPage);
		
		return "/volun/volunWrite";
	}
	
	// 글 상세조회
	@RequestMapping(value="/volun/volunView")
	public String volunView(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		long volunSeq = HttpUtil.get(request, "volunSeq", (long)0);
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		User user = null;
		
		User writer = null;
		
		Volun volun = null;
		
		if(volunSeq > 0)
		{
			volun = volunService.volunSelect(volunSeq);
			
			if(volun != null)
			{
				volun.setVolunFile(volunService.volunFileSelect(volunSeq));
			}
			
			user = userService.userSelect(userId);
			writer = userService.userSelect(volun.getUserId());
		}
		
		modelMap.addAttribute("writer", writer);
		modelMap.addAttribute("user", user);
		modelMap.addAttribute("volun", volun);
		modelMap.addAttribute("cookieUserId", userId);
		
		return "/volun/volunView";
	}
	
	@GetMapping("/address") 
	public String address() {
		System.out.println("map");
		
		return "address";
	}
}
