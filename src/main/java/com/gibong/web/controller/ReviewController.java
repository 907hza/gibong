package com.gibong.web.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gibong.common.model.FileData;
import com.gibong.common.util.StringUtil;
import com.gibong.web.model.Paging;
import com.gibong.web.model.Response;
import com.gibong.web.model.Review;
import com.gibong.web.model.ReviewFile;
import com.gibong.web.model.ReviewReply;
import com.gibong.web.service.ReviewService;
import com.gibong.web.util.CookieUtil;
import com.gibong.web.util.HttpUtil;

@Controller("reviewController")
public class ReviewController 
{
	private static Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	private static final int PAGE_NUM = 6; // 한 페이지에 몇개 나올거냐
	private static final int BTN_NUM = 3; // 한 페이지에 버튼 몇개 나오냐
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Value("#{env['upload.review.save.dir']}")
	private String UPLOAD_REVIEW_DIR;
	
	@Autowired
	private ReviewService reviewService;		
	
	// 봉사 후기 리스트 화면 보여주는 
	@RequestMapping(value="/review/reviewList")
	public String reviewList(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{		
		String searchType = HttpUtil.get(request, "searchType");
		String searchValue = HttpUtil.get(request, "searchValue");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		String viewFlag = HttpUtil.get(request, "viewFlag");
		
		List<Review> list = null;
		Review review = new Review();
		
		Paging paging = null;
		long totalCount = 0;
				
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			review.setSearchType(searchType);
			review.setSearchValue(searchValue);
		}
		
		if(!StringUtil.isEmpty(viewFlag))
		{
			review.setViewFlag(viewFlag);
		}
		
		totalCount = reviewService.totalCount(review);
		
		if(totalCount > 0)
		{
			paging = new Paging("/review/reviewList", totalCount, PAGE_NUM, BTN_NUM, curPage, "curPage");
			
			review.setStartRow(paging.getStartRow());
			review.setEndRow(paging.getEndRow());
			
			list = reviewService.recentReview(review);
		}
		
		modelMap.addAttribute("list", list);
		modelMap.addAttribute("paging", paging);
		modelMap.addAttribute("searchType", searchType);
		modelMap.addAttribute("searchValue", searchValue);
		modelMap.addAttribute("curPage", curPage);
		
		return "/review/reviewList";
	}
	
	// 봉사 후기 글 상세 화면
	@RequestMapping(value="/review/reviewView")
	public String reviewView(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		String searchType = HttpUtil.get(request, "searchType","");
		String searchValue = HttpUtil.get(request, "searchValue","");
		long reviewSeq = HttpUtil.get(request, "reviewSeq", (long)0);
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		List<Review> list = null;
		Review review2 = new Review();
		Paging paging = null;
		long totalCount = 0;
		
		Review review = null;
		
		if(reviewSeq > 0)
		{			
			review = reviewService.reviewViewAndFile(reviewSeq);
			
			if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
			{
				review.setSearchType(searchType);
				review.setSearchValue(searchValue);
			}
			
			totalCount = reviewService.totalCount(review2);
			
			if(totalCount > 0)
			{
				paging = new Paging("/review/reviewList", totalCount, PAGE_NUM, BTN_NUM, curPage, "curPage");
				
				review.setStartRow(paging.getStartRow());
				review.setEndRow(paging.getEndRow());
				
				list = reviewService.recentReview(review);
			}
			
			
			reviewService.readCnt(reviewSeq);			
		}
		
		modelMap.addAttribute("list", list);
		modelMap.addAttribute("cookieUserId", cookieUserId);
		modelMap.addAttribute("review", review);
		modelMap.addAttribute("searchType", searchType);
		modelMap.addAttribute("searchValue", searchValue);
		modelMap.addAttribute("reviewSeq", reviewSeq);
		modelMap.addAttribute("curPage", curPage);
		
		return "/review/reviewView";
	}
	
	// 글 작성하는 화면
	@RequestMapping(value="/review/reviewWrite")
	public String reviewWrite(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		String searchType = HttpUtil.get(request, "searchType","");
		String searchValue = HttpUtil.get(request, "searchValue","");
		long reviewSeq = HttpUtil.get(request, "reviewSeq", (long)0);
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		modelMap.addAttribute("searchType", searchType);
		modelMap.addAttribute("searchValue", searchValue);
		modelMap.addAttribute("reviewSeq", reviewSeq);
		modelMap.addAttribute("curPage", curPage);
		
		return "/review/reviewWrite";
	}
	
	// 글 등록
	@RequestMapping(value="/review/reviewWriteProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> reviewWriteProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
				
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String reviewTitle = HttpUtil.get(request, "reviewTitle");
		String reviewContent = HttpUtil.get(request, "reviewContent");
		
		// 다중 첨부파일
		List<FileData> fileData = new ArrayList<FileData>();
				
		// 첨부파일을 하나도 하지 않았을 경우 null 컬럼이 들어가는걸 방지
		if(request.getFiles("reviewFiles").get(0).getSize() != 0)
		{
			fileData = HttpUtil.getFiles(request, "reviewFiles", UPLOAD_REVIEW_DIR);
		}
		
		logger.debug("+++++++++++++++++++++++++++++++++++++++++++++++");
		logger.debug("request.getFiles('reviewFiles').get(0).getSize() : " + request.getFiles("reviewFiles").get(0).getSize());
		logger.debug("+++++++++++++++++++++++++++++++++++++++++++++++");
		
		if(!StringUtil.isEmpty(reviewTitle) && !StringUtil.isEmpty(reviewContent))
		{
			Review review = new Review();
			
			review.setUserId(userId);
			review.setReviewTitle(reviewTitle);
			review.setReviewContent(reviewContent);
			
			
			if(!StringUtil.isEmpty(fileData) && fileData != null && fileData.size() > 0)
			{
				List<ReviewFile> reviewFile = new ArrayList<ReviewFile>();
				
				for(int i=0 ; i<fileData.size(); i++)
				{
					ReviewFile reviewFile2 = new ReviewFile();
					
					reviewFile2.setFileName(fileData.get(i).getFileName());
					reviewFile2.setFileOrgName(fileData.get(i).getFileOrgName());
					reviewFile2.setFileExt(fileData.get(i).getFileExt());
					reviewFile2.setFileSize(fileData.get(i).getFileSize());
					
					reviewFile.add(reviewFile2);
				}
				
				review.setReviewFile(reviewFile);
			}
			
			try
			{
				if(reviewService.reviewInsert(review) > 0)
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else
				{
					ajaxResponse.setResponse(400, "Server error try");
				}
			}
			catch(Exception e)
			{
				ajaxResponse.setResponse(400, "Server error catch");
			}
		}
		else
		{
			ajaxResponse.setResponse(404, "Parameter Exception");
		}
		
		return ajaxResponse;
	}
	
	// 글 수정 화면
	@RequestMapping(value="/review/reviewUpdate")
	public String reviewUpdate(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		long reviewSeq = HttpUtil.get(request, "reviewSeq",(long)0);
		String searchType = HttpUtil.get(request, "searchType");
		String searchValue = HttpUtil.get(request, "searchValue");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		Review review = null;
		
		if(reviewSeq > 0)
		{
			review = reviewService.reviewViewAndFile(reviewSeq);
		}
		
		modelMap.addAttribute("review", review);
		modelMap.addAttribute("searchType", searchType);
		modelMap.addAttribute("searchValue", searchValue);
		modelMap.addAttribute("reviewSeq", reviewSeq);
		modelMap.addAttribute("curPage", curPage);
		
		return "/review/reviewUpdate";
	}
	
	// 글 수정 등록 ajax
	@RequestMapping(value="/review/reviewUpdateProc")
	@ResponseBody
	public Response<Object> reviewUpdateProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long reviewSeq = HttpUtil.get(request, "reviewSeq", (long)0);
		String reviewTitle = HttpUtil.get(request, "reviewTitle");
		String reviewContent = HttpUtil.get(request, "reviewContent");
		
		
		// 다중 첨부파일
		List<FileData> fileData = new ArrayList<FileData>();
				
		// 첨부파일을 하나도 하지 않았을 경우 null 값이 들어가는걸 방지
		if(request.getFiles("reviewFiles").get(0).getSize() != 0)
		{
			fileData = HttpUtil.getFiles(request, "reviewFiles", UPLOAD_REVIEW_DIR);
		}
		
		if(reviewSeq > 0 && !StringUtil.isEmpty(reviewTitle) && !StringUtil.isEmpty(reviewContent))
		{
			Review review = reviewService.reviewSelect(reviewSeq); // 기존에 있던 첨부파일
					
			if(review != null)
			{
				if(StringUtil.equals(userId, review.getUserId()))
				{
					review.setReviewTitle(reviewTitle);
					review.setReviewContent(reviewContent);
										
					if(fileData != null && fileData.size() > 0)
					{
						List<ReviewFile> reviewFile = new ArrayList<ReviewFile>();
						
						for(int i=0 ; i<fileData.size(); i++)
						{
							ReviewFile reviewFile2 = new ReviewFile();
							
							reviewFile2.setFileName(fileData.get(i).getFileName());
							reviewFile2.setFileOrgName(fileData.get(i).getFileOrgName());
							reviewFile2.setFileExt(fileData.get(i).getFileExt());
							reviewFile2.setFileSize(fileData.get(i).getFileSize());
							
							reviewFile.add(reviewFile2);
						}
						
						review.setReviewFile(reviewFile);
					}
					
					try
					{
						if(reviewService.reviewUpdate(review) > 0)
						{
							ajaxResponse.setResponse(0, "Success");
						}
						else
						{
							ajaxResponse.setResponse(510, "Server error try");
						}
					}
					catch(Exception e)
					{
						logger.error("[ReviewController] reviewUpdateProc Exception", e);
					}
				}
				else
				{
					ajaxResponse.setResponse(410, "Not equals write Id");
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
	
	// 글 삭제 플래그 값 변경
	@RequestMapping(value="/review/reviewDeleteProc")
	@ResponseBody
	public Response<Object> reviewDeleteProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		long reviewSeq = HttpUtil.get(request, "reviewSeq", (long)0);
		
		if(reviewSeq > 0)
		{
			Review review = reviewService.reviewSelect(reviewSeq);
			
			if(review != null)
			{
				if(StringUtil.equals(review.getUserId(), userId))
				{
					try
					{
						if(reviewService.reviewDelete(reviewSeq) > 0)
						{
							ajaxResponse.setResponse(0, "Success");
						}
						else
						{
							ajaxResponse.setResponse(450, "Server error try");
						}
					}
					catch(Exception e)
					{
						logger.error("[ReviewController] reviewDeleteProc Exception", e);
						ajaxResponse.setResponse(450, "Server error catch");
					}
				}
				else
				{
					ajaxResponse.setResponse(410, "Not equals Id");
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
	
	// 댓글 삭제 플래그 값 변경
	@RequestMapping(value="/review/replyDelete")
	@ResponseBody
	public Response<Object> replyDelete(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long reviewReplySeq = HttpUtil.get(request, "reviewReplySeq", (long)0);
		long reviewSeq = HttpUtil.get(request, "reviewSeq", (long)0);
		
		Review review = reviewService.reviewSelect(reviewSeq);
		
		logger.debug("====================================");
		logger.debug("reviewSeq : " + reviewSeq);
		logger.debug("reviewReplySeq : " + reviewReplySeq);
		logger.debug("====================================");
		
		if(review != null)
		{	
			List<ReviewReply> reviewReply = reviewService.replySelect(reviewSeq);
			
			if(reviewReply != null)
			{
				if(reviewService.replyDelete(reviewReplySeq) > 0)
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
				ajaxResponse.setResponse(405, "Not fount reply");
			}
		}
		else
		{
			ajaxResponse.setResponse(404, "Not found review");
		}
		
		return ajaxResponse;
	}
	
	// Indent 0 댓글 작성
	@RequestMapping(value="/review/replyProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> replyProc(HttpServletRequest request, HttpServletResponse response)
	{
		Response<Object> ajaxResponse = new Response<Object>();
		
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String comment = HttpUtil.get(request, "comment");
		long reviewSeq = HttpUtil.get(request, "reviewSeq", (long)0);
		
		String searchType = HttpUtil.get(request, "searchType");
		String searchValue = HttpUtil.get(request, "searchValue");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		if(userId != null && !StringUtil.isEmpty(comment) && reviewSeq >0)
		{
			Review review = reviewService.reviewSelect(reviewSeq);
			
			if(review != null)
			{
				ReviewReply reviewReply = new ReviewReply();
				
				reviewReply.setUserId(userId);
				reviewReply.setReviewSeq(reviewSeq);
				reviewReply.setReviewReplyContent(comment);
				reviewReply.setReviewReplyGroup(reviewSeq);
				reviewReply.setReviewReplyOrder(0);
				reviewReply.setReviewReplyIndent(0);
				
				if(reviewService.replyInsert(reviewReply) > 0)
				{
					ajaxResponse.setResponse(0, "Success");
				}
				else
				{
					ajaxResponse.setResponse(450, "Server error");
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not found review");
			}
		}	
		else
		{
			ajaxResponse.setResponse(400, "Parameter Exception");
		}
		
		return ajaxResponse;
	}
}
