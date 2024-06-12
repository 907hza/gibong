package com.gibong.web.service;

import java.io.UnsupportedEncodingException;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

@Service("mailSendService")
public class MailSendService 
{
	@Autowired // root-context 에서 빈 등록했기 때문에 import 가능
	private JavaMailSenderImpl mailSender; 
	// 메일센더에 의해 실제로 파라미터에 입력받은 메일 주소로 이메일이 전달된다
	
	private String getKey(int size)
	{
		Random random = new Random();
		String key = "";
		
		for(int i=0 ; i<6 ; i++)
		{
			int get = random.nextInt(10);
					
			key += String.valueOf(get);
		}
		
		return key;
	}
	
	// 	실제 메일이 전달되는 함수 **
	public String sendAuthMail(String mail) throws MessagingException
	{
		String authKey = getKey(6);
		MimeMessage mailMessage = mailSender.createMimeMessage();
		
		String mailContent = " 인증번호는 " + authKey + " 입니다.";
		
		mailMessage.setSubject(" 맨발의 기봉이 이메일 인증번호 입니다.","utf-8");
		mailMessage.setText(mailContent, "utf-8");
		mailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(mail));
		mailSender.send(mailMessage);
		
		return authKey;
	}
	
	// 	임시 비밀번호 메일이 전달되는 함수 **
	public String sendAuthPwdMail(String mail) throws MessagingException
	{
		String authKey = getKey(6);
		MimeMessage mailMessage = mailSender.createMimeMessage();
		
		String mailContent = " 임시 비밀번호는 " + authKey + " 입니다." + "\n" + "해당 비밀번호로 로그인 해주세요."
						   + "\n" + "\n" + "= = = = = = = = = = = = = = = "
						   + "\n" + "\n" + " 비밀번호 변경을 원하시는 경우"
				 		   + "\n" + " 마이페이지 > 회원정보수정 에서 변경 가능합니다.";
		
		mailMessage.setSubject("맨발의 기봉이 임시 비밀번호 입니다.","utf-8");
		mailMessage.setText(mailContent, "utf-8");
		mailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(mail));
		mailSender.send(mailMessage);
		
		return authKey;
	}
}
