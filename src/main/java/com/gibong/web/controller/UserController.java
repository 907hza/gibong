package com.gibong.web.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gibong.common.util.StringUtil;
import com.gibong.web.model.Response;
import com.gibong.web.model.Review;
import com.gibong.web.model.User;
import com.gibong.web.service.ReviewService;
import com.gibong.web.service.UserService;
import com.gibong.web.util.CookieUtil;
import com.gibong.web.util.HttpUtil;

@Controller("userController")
public class UserController 
{
	private static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	// 로그인 화면
	@RequestMapping(value="/user/login")
	public String userLogin(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/login";
	}
	
	// 로그인 버튼을 클릭
	@RequestMapping(value="/user/loginProc")
	@ResponseBody
	public Response<Object> loginProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String userId = HttpUtil.get(request, "userId");
		String userPwd = HttpUtil.get(request, "userPwd");
		
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd))
		{
			User user = userService.userSelect(userId);
			
			if(user != null)
			{
				if(StringUtil.equals(userPwd, user.getUserPwd()))
				{
					if(StringUtil.equals(user.getStatus(), "Y"))
					{
						// 완료되면 쿠키 저장
						CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NAME, CookieUtil.stringToHex(userId));

						ajaxResponse.setResponse(0, "Success");
					}
					else
					{
						ajaxResponse.setResponse(430, "stop status");
					}
				}
				else
				{
					ajaxResponse.setResponse(410, "Password Exception");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "parameter Exception");
		}
		
		return ajaxResponse;
	}
	
	// 아이디 찾기 클릭했을 시 띄워줄 화면
	@RequestMapping(value="/user/findId")
	public String findId(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/findId";
	}
	
	// 아이디 찾기 들어가서 값 입력하고 조회 버튼 클릭했을 시
	@RequestMapping(value="/user/findIdProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> findIdProc(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		User user = null;
		
		String userName = HttpUtil.get(request, "userName", "");
		String userEmail = HttpUtil.get(request, "userEmail", "");
		
		if(!StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail))
		{
			user = userService.userIdSelect(userName);

			if(user != null)
			{
				
			logger.debug("=========================");
			logger.debug("userId : " + user.getUserId());
			logger.debug("userEmail : " + user.getUserEmail());
			logger.debug("=========================");

				if(StringUtil.equals(userEmail, user.getUserEmail()))
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else
				{
					ajaxResponse.setResponse(400, "Value Exception");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not found");
			}
		}
		else
		{
			ajaxResponse.setResponse(410, "Parameter Exception");
		}
		
		modelMap.addAttribute("user", user);
		
		return ajaxResponse;
	}
	
	// 아이디 찾기 완료했을 시 띄워줄 화면
	@RequestMapping(value="/user/findIdSuccess")
	public String findIdSuccess(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		String userName = HttpUtil.get(request, "userName", "");
		String userEmail = HttpUtil.get(request, "userEmail", "");

		if(!StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail))
		{
			User user = new User();
			user = userService.userIdSelect(userName);
			
			if(user != null)
			{
				modelMap.addAttribute("userId", user.getUserId());
			}
		}
		
		return "/user/findIdSuccess";
	}
	
	// 비밀번호 찾기 클릭했을 시 띄워줄 화면
	@RequestMapping(value="/user/findPwd")
	public String findPwd(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/findPwd";
	}
	
	// 회원 비밀번호 찾기시 해당 아이디와 비밀번호가 존재하는지에 대해 확인
	@RequestMapping(value="/user/idEmailCheck")
	@ResponseBody
	public Response<Object> idEmailCheck(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String userId = HttpUtil.get(request, "userId");
		String userEmail = HttpUtil.get(request, "userEmail");
		
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userEmail))
		{
			User user = userService.userSelect(userId);
			
			if(user != null)
			{
				if(StringUtil.equals(userEmail, user.getUserEmail()))
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else
				{
					ajaxResponse.setResponse(410, "Email Exception");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Parameter Exception");
		}
		
		return ajaxResponse;
	}
	
	// 로그아웃 클릭시
	@RequestMapping(value="/user/logOut")
	public String logOut(HttpServletRequest request, HttpServletResponse response)
	{
		if(CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null)
		{
			// 쿠키 삭제
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
		}
		
		return "/main";
	}
	
	// 회원가입 클릭시 화면
	@RequestMapping(value="/user/join")
	public String join(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/join";
	}
	
	// 회원 아이디 중복 체크
	@RequestMapping(value="/user/idDouble")
	@ResponseBody
	public Response<Object> idDouble(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String userId = HttpUtil.get(request, "userId","");
		
		if(!StringUtil.isEmpty(userId))
		{
			long count = userService.idDouble(userId);
			
			if(count <= 0)
			{
				ajaxResponse.setResponse(0, "Success");
			}
			else
			{
				ajaxResponse.setResponse(403, "disabled");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "parameter Exception");
		}
		
		return ajaxResponse;
	}
	
	// 회원 이메일 중복 체크
	@RequestMapping(value="/user/emailDouble")
	@ResponseBody
	public Response<Object> emailDouble(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String userEmail = HttpUtil.get(request, "userEmail");
		
		if(!StringUtil.isEmpty(userEmail))
		{
			long count = userService.emailDouble(userEmail);
			
			if(count <= 0)
			{
				ajaxResponse.setResponse(0, "Success");
			}
			else
			{
				ajaxResponse.setResponse(403, "Double email");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Parameter Exception");
		}
		
		return ajaxResponse;
	}
	
	// 회원가입 버튼 클릭
	@RequestMapping(value="/user/joinUser")
	@ResponseBody
	public Response<Object> joinUser(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String userId = HttpUtil.get(request, "userId");
		String userPwd = HttpUtil.get(request, "userPwd");
		String userPhone = HttpUtil.get(request, "userPhone");
		String userEmail = HttpUtil.get(request, "userEmail");
		String userName = HttpUtil.get(request, "userName");
		String userFlag = HttpUtil.get(request, "userFlag");
		String userZipcode = HttpUtil.get(request, "userZipcode");
		String userAddr1 = HttpUtil.get(request, "userAddr1");
		String userAddr2 = HttpUtil.get(request, "userAddr2");
		
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userPhone) &&
		   !StringUtil.isEmpty(userEmail) && !StringUtil.isEmpty(userName) &&!StringUtil.isEmpty(userFlag) &&
		   !StringUtil.isEmpty(userZipcode) && !StringUtil.isEmpty(userAddr1) && !StringUtil.isEmpty(userAddr2))
		{
			User user = new User();
			
			user.setUserId(userId);
			user.setUserPwd(userPwd);
			user.setUserPhone(userPhone);
			user.setUserEmail(userEmail);
			user.setUserName(userName);
			user.setUserFlag(userFlag);
			user.setStatus("Y");
			user.setUserZipcode(userZipcode);
			user.setUserAddr1(userAddr1);
			user.setUserAddr2(userAddr2);
			
			if(userService.userInsert(user) > 0)
			{
				ajaxResponse.setResponse(0, "Success");
			}
			else
			{
				ajaxResponse.setResponse(410, "Server error");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Parameter Exception");
		}
		
		return ajaxResponse;
	}
	
	// 나의 정보 클릭시 화면
	@RequestMapping(value="/user/infoList")
	public String infoList(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(!StringUtil.isEmpty(userId))
		{
			User user = userService.userSelect(userId);
			
			modelMap.addAttribute("user", user);
		}
		
		return "/user/infoList";
	}
	
	// 회원정보 수정 클릭시 화면
	@RequestMapping(value="/user/infoUpdate")
	public String userUpdate(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(!StringUtil.isEmpty(userId))
		{
			User user = userService.userSelect(userId);
			
			modelMap.addAttribute("user", user);
		}
		
		return "/user/infoUpdate";
	}
	
	// 회원 정보 수정시 등록
	@RequestMapping(value="/user/userUpdate")
	@ResponseBody
	public Response<Object> userUpdate(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String userId = HttpUtil.get(request, "userId");
		String userPwd = HttpUtil.get(request, "userPwd");
		String userPhone = HttpUtil.get(request, "userPhone");
		String userEmail = HttpUtil.get(request, "userEmail");
		String userName = HttpUtil.get(request, "userName");
		String userFlag = HttpUtil.get(request, "userFlag");
		String userZipcode = HttpUtil.get(request, "userZipcode");
		String userAddr1 = HttpUtil.get(request, "userAddr1");
		String userAddr2 = HttpUtil.get(request, "userAddr2");
		
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userPhone) &&
		   !StringUtil.isEmpty(userEmail) && !StringUtil.isEmpty(userName) &&!StringUtil.isEmpty(userFlag) &&
		   !StringUtil.isEmpty(userZipcode) && !StringUtil.isEmpty(userAddr1) && !StringUtil.isEmpty(userAddr2))
		{
			User user = new User();
			
			user.setUserId(userId);
			user.setUserPwd(userPwd);
			user.setUserPhone(userPhone);
			user.setUserEmail(userEmail);
			user.setUserName(userName);
			user.setUserFlag(userFlag);
			user.setStatus("Y");
			user.setUserZipcode(userZipcode);
			user.setUserAddr1(userAddr1);
			user.setUserAddr2(userAddr2);
			
			if(userService.userUpdate(user) > 0)
			{
				ajaxResponse.setResponse(0, "Success");
			}
			else
			{
				ajaxResponse.setResponse(410, "Server error");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Parameter Exception");
		}
		
		return ajaxResponse;
	}
	
	// 회원 탈퇴...
	@RequestMapping(value="/user/statusUpdate")
	@ResponseBody
	public Response<Object> statusUpdate(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(!StringUtil.isEmpty(userId))
		{
			User user = userService.userSelect(userId);
			
			if(user != null)
			{
				user.setStatus("N"); // 상태만 변경하고 테이블에서 삭제하지는 않는다
				
				if(userService.userUpdate(user) > 0)
				{
					ajaxResponse.setResponse(0, "Success");
					CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME); // 쿠키 삭제
				}
				else
				{
					ajaxResponse.setResponse(410, "Server error");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not found");
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Parameter Exception");
		}
		
		return ajaxResponse;
	}
	
	
	//////////////////////////////////// 마이페이지 ////////////////////////////////////
	@RequestMapping(value="/user/myPage")
	public String userMyPage(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long volunNum = 0;
		long reviewNum = 0;
		long payNum = 0;
		
		if(!StringUtil.isEmpty(userId))
		{
			volunNum = userService.myVolunCnt(userId);
			reviewNum = userService.myReviewCnt(userId);
			payNum = userService.myPayCnt(userId);
		}
		
		modelMap.addAttribute("volunNum", volunNum);
		modelMap.addAttribute("reviewNum", reviewNum);
		modelMap.addAttribute("payNum", payNum);
		
		return "/user/myPage";
	}
	
	// 마이 페이지 나의 봉사후기
	@RequestMapping(value="/user/myPage/myReview")
	public String myReview(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		User user = null;
		List<Review> list = null;
		long totalCount = 0;
		
		if(!StringUtil.isEmpty(userId))
		{
			user = userService.userSelect(userId);
			
			if(StringUtil.equals(user.getStatus(), "Y"))
			{								
				totalCount = userService.myReviewCnt(userId);
				
				if(totalCount > 0)
				{
					list = reviewService.myReview(userId);
				}
			}
		}
		
		modelMap.addAttribute("totalCount", totalCount);
		modelMap.addAttribute("list", list);
		modelMap.addAttribute("userId", userId);
		
		return "/user/myPage/myReview";
	}

}
