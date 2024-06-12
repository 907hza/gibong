package com.gibong.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gibong.web.dao.UserDao;
import com.gibong.web.model.Review;
import com.gibong.web.model.User;

@Service("userService")
public class UserService 
{
	private static Logger logger = LoggerFactory.getLogger(UserService.class);
	
	@Autowired
	private UserDao userDao;
	
	// 유저 조회
	public User userSelect(String userId)
	{
		User user = null;
		
		try
		{
			user = userDao.userSelect(userId);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userSelect Exception", e);
		}
		
		return user;
	}
	
	// 유저 아이디 조회
	public User userIdSelect(String userName)
	{
		User user = null;
		
		try
		{
			user = userDao.userIdSelect(userName);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userIdSelect Exception", e);
		}
		
		return user;
	}
	
	// 유저 회원가입
	public int userInsert(User user)
	{
		int count = 0;
		
		try
		{
			count = userDao.userInsert(user);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userInsert Exception", e);
		}
		
		return count;
	}
	
	// 유저 아이디 중복 확인
	public long idDouble(String userId)
	{
		long count = 0;
		
		try
		{
			count = userDao.idDouble(userId);
		}
		catch(Exception e)
		{
			logger.error("[UserService] idDouble Exception", e);
		}
		
		return count;
	}
	
	// 유저 이메일 중복 확인
	public long emailDouble(String userEmail)
	{
		long count = 0;
		
		try
		{
			count = userDao.emailDouble(userEmail);
		}
		catch(Exception e)
		{
			logger.error("[UserService] emailDouble Exception", e);
		}
		
		return count;
	}
	
	// 유저 회원 정보 수정
	public int userUpdate(User user)
	{
		int count = 0;
		
		try
		{
			count = userDao.userUpdate(user);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userUpdate Exception", e);
		}
		
		return count;
	}
	
	// 마이페이지
	// 나의 활동
	public long myVolunCnt(String userId)
	{
		long count = 0;
		
		try
		{
			count = userDao.myVolunCnt(userId);
		}
		catch(Exception e)
		{
			logger.error("[UserService] myVolunCnt Exception", e);
		}
		
		return count;
	}
	
	// 나의 봉사후기
	public long myReviewCnt(String userId)
	{
		long count = 0;
		
		try
		{
			count = userDao.myReviewCnt(userId);
		}
		catch(Exception e)
		{
			logger.error("[UserService] myReviewCnt Exception", e);
		}
		
		return count;
	}

	
	// 나의 후원
	public long myPayCnt(String userId)
	{
		long count = 0;
		
		try
		{
			count = userDao.myPayCnt(userId);
		}
		catch(Exception e)
		{
			logger.error("[UserService] myPayCnt Exception", e);
		}
		
		return count;
	}
	
}
