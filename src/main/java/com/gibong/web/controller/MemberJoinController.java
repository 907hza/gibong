package com.gibong.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gibong.common.util.StringUtil;
import com.gibong.web.model.User;
import com.gibong.web.service.MailSendService;
import com.gibong.web.service.UserService;
import com.gibong.web.util.HttpUtil;

@Controller("memberJoinController")
public class MemberJoinController 
{
	@Autowired
	MailSendService mailSendService;
	
	@Autowired
	private UserService userService;
	
	// 이메일 인증, 이메일 인증번호
	@RequestMapping(value="/email/mailAuth")
	@ResponseBody
	public String mailAuth(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String mail = HttpUtil.get(request, "mail"); 
		
		String authKey = mailSendService.sendAuthMail(mail);
		// 사용자가 입력한 해당 메일 주소로 메일을 보낸다
		
		return authKey;
	}
	
	// 임시 비밀번호를 보내줌
	@RequestMapping(value="/email/mailAuthPwd")
	@ResponseBody
	public String mailAuthPwd(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String userId = HttpUtil.get(request, "userId");
		String mail = HttpUtil.get(request, "mail"); 
		
		String authKey = "";
		
		if(!StringUtil.isEmpty(userId))
		{
			User user = userService.userSelect(userId);
			
			if(user != null)
			{
				authKey = mailSendService.sendAuthPwdMail(mail);
				// 사용자가 입력한 해당 메일 주소로 메일을 보낸다
				
				user.setUserPwd(authKey);
				
				userService.userUpdate(user);
			}
		}
		
		return authKey;
	}
	
}
