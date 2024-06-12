package com.gibong.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.gibong.web.dao.VolunDao;
import com.gibong.web.model.Volun;
import com.gibong.web.model.VolunFile;

@Service("volunService")
public class VolunService 
{
	private static Logger logger = LoggerFactory.getLogger(VolunService.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Autowired
	private VolunDao volunDao;
	
	// 봉사 글 갯수
	public long volunTotalCnt(Volun volun)
	{
		long totalCount = 0;
		
		try
		{
			totalCount = volunDao.volunTotalCnt(volun);
		}
		catch(Exception e)
		{
			logger.error("[VolunService] volunTotalCnt Exception", e);
		}
		
		return totalCount;
	}
	
	// 봉사 리스트
	public List<Volun> volunList(Volun volun)
	{
		List<Volun> list = null;
		
		try
		{
			list = volunDao.volunList(volun);
		}
		catch(Exception e)
		{
			logger.error("[VolunService] volunList Exception", e);
		}
		
		return list;
	}
	
	// 봉사 모집 중 리스트
	public List<Volun> volunMoList(Volun volun)
	{
		List<Volun> list = null;
		
		try
		{
			list = volunDao.volunMoList(volun);
		}
		catch(Exception e)
		{
			logger.error("[VolunService] volunMoList Exception", e);
		}
		
		return list;
	}
	
	// 봉사 글 마감 플래그 값 변경
	public int delFlagUpdate(String endRegdate)
	{
		int count = 0;
		
		try
		{
			count = volunDao.delFlagUpdate(endRegdate);
		}
		catch(Exception e)
		{
			logger.error("[VolunService] delFlagUpdate Exception", e);
		}
		
		return count;
	}
	
	// 글 조회
	public Volun volunSelect(long volunSeq)
	{
		Volun volun = null;
		
		try
		{
			volun = volunDao.volunSelect(volunSeq);
		}
		catch(Exception e)
		{
			logger.error("[VolunService] volunSelect Exception", e);
		}
		
		return volun;
	}
	
	// 첨부파일 조회하기
	public VolunFile volunFileSelect(long volunSeq)
	{
		VolunFile volunFile = null;
		
		try
		{
			volunFile = volunDao.volunFileSelect(volunSeq);
		}
		catch(Exception e)
		{
			logger.error("[VolunService] volunFileSelect Exception", e);
		}
		
		return volunFile;
	}
	
	// 글 등록하기
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int volunInsert(Volun volun) throws Exception
	{
		int count = volunDao.volunInsert(volun);
		
		if(count > 0 && volun.getVolunFile() != null)
		{
			VolunFile volunFile = new VolunFile();
			
			volunFile.setFileSeq(volun.getVolunFile().getFileSeq());
			volunFile.setVolunSeq(volun.getVolunSeq());
			
			volunDao.volunFileInsert(volunFile);
		}
		
		return count;
	}
	
	
}
