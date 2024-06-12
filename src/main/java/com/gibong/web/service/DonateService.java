package com.gibong.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.gibong.web.dao.DonateDao;
import com.gibong.web.model.Donate;
import com.gibong.web.model.DonateFile;

@Service("donateService")
public class DonateService 
{
	private static Logger logger = LoggerFactory.getLogger(DonateService.class);
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Autowired
	private DonateDao donateDao;
	
	// 후원 게시물 갯수
	public long donateCnt(Donate donate)
	{
		long count = 0;
		
		try
		{
			count = donateDao.donateCnt(donate);
		}
		catch(Exception e)
		{
			logger.error("[DonateService] donateCnt Exception", e);
		}
		
		return count;
	}
	
	// 후원 글 조회
	public Donate donateWhere(long donateSeq)
	{
		Donate donate = null;
		
		try
		{
			donate = donateDao.donateWhere(donateSeq);
		}
		catch(Exception e)
		{
			logger.error("[DonateService] donateWhere Exception", e);
		}
		
		return donate;
	}
	
	// 후원 첨부파일 조회
	public DonateFile donateFileSelect(long donateSeq)
	{
		DonateFile donateFile = null;
		
		try
		{
			donateFile = donateDao.donateFileSelect(donateSeq);
		}
		catch(Exception e)
		{
			logger.error("[DonateService] donateFileSelect Exception", e);
		}
		
		return donateFile;
	}
	
	// 첨부파일이랑 글 같이 조회
	public Donate donateView(long donateSeq)
	{
		Donate donate = null;
		DonateFile donateFile = null;
		
		try
		{
			donate = donateDao.donateWhere(donateSeq);
			
			if(donate != null)
			{
				donateFile = donateDao.donateFileSelect(donateSeq);
				
				if(donateFile != null)
				{
					donate.setDonateFile(donateFile);
				}
			}
		}
		catch(Exception e)
		{
			logger.error("[DonateService] donateView Exception", e);
		}
		
		return donate;
	}
	
	// 후원 페이지 리스트
	public List<Donate> donateSelect(Donate donate)
	{
		List<Donate> list = null;
		
		try
		{
			list = donateDao.donateSelect(donate);
		}
		catch(Exception e)
		{
			logger.error("[DonateService] donateSelect Exception", e);
		}
		
		return list;
	}
	
	// 후원 상세보기
	public Donate donateViewSelect(long donateSeq)
	{
		Donate donate = null;
		
		try
		{
			donate = donateDao.donateViewSelect(donateSeq);
		}
		catch(Exception e)
		{
			logger.error("[DonateService] donateViewSelect Exception", e);
		}
		
		return donate;
	}
}
