package com.gibong.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gibong.web.model.Volun;
import com.gibong.web.model.VolunFile;

@Repository("volunDao")
public interface VolunDao 
{
	// 봉사 목록 리스트
	public List<Volun> volunList(Volun volun);
	
	// 모집 중인 글만 리스트
	public List<Volun> volunMoList(Volun volun);
	
	// 봉사 글 갯수
	public long volunTotalCnt(Volun volun);
	
	// 모집 마감 플래그 값 변경
	public int delFlagUpdate(String endRegdate);
	
	// 글 상세 조회
	public Volun volunSelect(long volunSeq);
	
	// 첨부파일 조회
	public VolunFile volunFileSelect(long volunSeq);
	
	// 글 등록
	public int volunInsert(Volun volun);
	
	// 첨부파일 등록
	public int volunFileInsert(VolunFile volunFile);
}
