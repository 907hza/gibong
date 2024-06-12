package com.gibong.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gibong.web.model.Review;
import com.gibong.web.model.User;

@Repository("userDao")
public interface UserDao 
{
	// 유저 조회
	public User userSelect(String userId);
	
	// 유저 아이디 조회
	public User userIdSelect(String userName);
	
	// 유저 회원가입
	public int userInsert(User user);
	
	// 유저 아이디 중복 체크
	public long idDouble(String userId);
	
	// 유저 이메일 중복 체크
	public long emailDouble(String userEmail);
	
	// 유저 회원 정보 수정
	public int userUpdate(User user);
	
	// 마이페이지 //
	
	// 나의 활동
	public long myVolunCnt(String userId);
	// 나의 봉사후기 갯수
	public long myReviewCnt(String userId);
	
	// 나의 후원
	public long myPayCnt(String userId);
	
}
