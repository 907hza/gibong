package com.gibong.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gibong.web.model.Donate;
import com.gibong.web.model.DonateFile;

@Repository("donateDao")
public interface DonateDao 
{
	// 후원 페이지 리스트
	public List<Donate> donateSelect(Donate donate);
	
	// 후원 글 조회
	public Donate donateWhere(long donateSeq);
	
	// 후원 첨부파일 조회
	public DonateFile donateFileSelect(long donateSeq);
	
	// 후원 게시물 갯수
	public long donateCnt(Donate donate);
	
	// 후원 상세보기
	public Donate donateViewSelect(long donateSeq);
}
