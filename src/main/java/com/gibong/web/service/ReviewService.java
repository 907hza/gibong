package com.gibong.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.gibong.common.util.FileUtil;
import com.gibong.web.dao.ReviewDao;
import com.gibong.web.model.Review;
import com.gibong.web.model.ReviewFile;
import com.gibong.web.model.ReviewReply;

@Service("reviewService")
public class ReviewService 
{
	private static Logger logger = LoggerFactory.getLogger(ReviewService.class);
	
	@Autowired
	private ReviewDao reviewDao;
	
	@Value("#{env['upload.review.save.dir']}")
	private String UPLOAD_REVIEW_DIR;
	
	// 글 갯수 조회
	public long totalCount(Review review)
	{
		long count = 0;
		
		try
		{
			count = reviewDao.totalCount(review);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] totalCount Exception", e);
		}
		
		return count;
	}
	
	// 리뷰 리스트 조회
	public List<Review> recentReview(Review review)
	{
		List<Review> recentList = null;
		
		try
		{
			recentList = reviewDao.list(review);
			
			if(recentList != null)
			{
					for(int i=0 ; i<recentList.size(); i++)
					{
						recentList.get(i).setReviewFile(reviewDao.reviewFileSelect(recentList.get(i).getReviewSeq()));
					}
			}
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] recentReview Exception", e);
		}
		
		return recentList;
	}
	
	// 글 조회
	public Review reviewSelect(long reviewSeq)
	{
		Review review = null;
		
		try
		{
			review = reviewDao.reviewSelect(reviewSeq);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] reviewSelect Exception", e);
		}
		
		return review;
	}
	
	// 첨부파일 조회
	public List<ReviewFile> reviewFileSelect(long reviewSeq)
	{
		List<ReviewFile> reviewFile = null;

		try
		{
			reviewFile = reviewDao.reviewFileSelect(reviewSeq);

		}
		catch(Exception e)
		{
			logger.error("[ReviewService] reviewFileSelect Exception", e);
		}
		
		return reviewFile;
	}
	
	// 댓글 조회
	public List<ReviewReply> replySelect(long reviewSeq)
	{
		List<ReviewReply> reply = null;
		
		try
		{
			reply = reviewDao.replySelect(reviewSeq);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] replySelect Exception", e);
		}
		
		return reply;
	}
	
	// 첨부파일과 글 조회가 함께 합니다잉 + 댓글
	public Review reviewViewAndFile(long reviewSeq)
	{
		Review review = null;
		List<ReviewFile> reviewFile = null;
		List<ReviewReply> reviewReply = null;
		
		try
		{
			review = reviewDao.reviewSelect(reviewSeq);
			
			if(review != null)
			{
				reviewDao.readCnt(reviewSeq);
				
				reviewFile = reviewDao.reviewFileSelect(reviewSeq);
				reviewReply = reviewDao.replySelect(reviewSeq);
								
				if(reviewFile != null)
				{
					review.setReviewFile(reviewFile);
					
					if(reviewReply != null)
					{
						review.setReviewReply(reviewReply);
					}
				}
			}
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] reviewViewAndFile Exception", e);
		}
		
		return review;
	}
	
	// 조회수
	public int readCnt(long reviewSeq)
	{
		int count = 0;
		
		try
		{
			count = reviewDao.readCnt(reviewSeq);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] readCnt Exception", e);
		}
		
		return count;
	}
	
	// 나의 봉사 후기 글 목록
	public List<Review> myReview(String userId)
	{
		List<Review> list = null;
		
		try
		{
			list = reviewDao.myReview(userId);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] myReview Exception", e);
		}
		
		return list;
	}
	
	// 나의 봉사 후기 글 등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int reviewInsert(Review review) throws Exception
	{
		int count = reviewDao.reviewInsert(review);
		
		if(count > 0 && review.getReviewFile() != null)
		{			
			for(int i=0 ; i<review.getReviewFile().size(); i++)
			{
				ReviewFile reviewFile2 = new ReviewFile();
				
				reviewFile2.setReviewSeq(review.getReviewSeq());
				reviewFile2.setFileSeq(review.getReviewFile().get(i).getFileSeq());
				
				reviewFile2.setFileName(review.getReviewFile().get(i).getFileName());
				reviewFile2.setFileOrgName(review.getReviewFile().get(i).getFileOrgName());
				reviewFile2.setFileExt(review.getReviewFile().get(i).getFileExt());
				reviewFile2.setFileSize(review.getReviewFile().get(i).getFileSize());
				
				logger.debug("=======================================");
				logger.debug("review.getReviewSeq() : " + review.getReviewSeq());
				logger.debug("=======================================");
				
				reviewDao.reviewFileInsert(reviewFile2);
			}
		}
		
		return count;
	}
	
	// 후기 수정
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int reviewUpdate(Review review) throws Exception
	{
		int count = reviewDao.reviewUpdate(review);
				
		if(count > 0 && review.getReviewFile() != null) // 여기있는 파일은 수정하며 추가된 파일
		{
			List<ReviewFile> reviewFile2 = reviewDao.reviewFileSelect(review.getReviewSeq());

			logger.debug("++++++++++++++++++++++++++++");
			logger.debug("reviewFile2.size() : " + reviewFile2.size());
			logger.debug("++++++++++++++++++++++++++++");
			
				for(int i=0 ; i<reviewFile2.size() ; i++)
				{
					
					FileUtil.deleteFile(UPLOAD_REVIEW_DIR
							+ FileUtil.getFileSeparator() + reviewFile2.get(i).getFileName());
					
					reviewDao.reviewFileDelete(review.getReviewSeq());
					
					logger.debug("reviewFile2().size() : " + reviewFile2.size());
				}
			
	
			if(review.getReviewFile() != null) // 파일 새로 추가
			{
				for(int i=0 ; i<review.getReviewFile().size(); i++)
				{
					ReviewFile reviewFile3 = new ReviewFile();
						
					reviewFile3.setReviewSeq(review.getReviewSeq());
					reviewFile3.setFileSeq(review.getReviewFile().get(i).getFileSeq());
						
					reviewFile3.setFileName(review.getReviewFile().get(i).getFileName());
					reviewFile3.setFileOrgName(review.getReviewFile().get(i).getFileOrgName());
					reviewFile3.setFileExt(review.getReviewFile().get(i).getFileExt());
					reviewFile3.setFileSize(review.getReviewFile().get(i).getFileSize());
						
					reviewDao.reviewFileInsert(reviewFile3);
				}
			}
				
			
		}
		
		
		return count;
	}
	
	// 글 삭제 플래그 값 변경
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int reviewDelete(long reviewSeq) throws Exception
	{
		int count = 0;
		
		Review review = reviewViewAndFile(reviewSeq);
		
		if(review != null)
		{
			count = reviewDao.reviewDelete(reviewSeq);
			
			if(count > 0)
			{
				List<ReviewFile> reviewFile = review.getReviewFile();
				
				if(reviewFile != null)
				{
					for(int i=0 ; i<reviewFile.size() ; i++)
					{
						reviewDao.reviewFileDelete(reviewSeq);
						count++;
					}
					
					if(count == reviewFile.size())
					{
						for(int i=0 ; i<reviewFile.size() ; i++)
						{
							FileUtil.deleteFile(UPLOAD_REVIEW_DIR + FileUtil.getFileSeparator()
							 + reviewFile.get(i).getFileName());
						}
					}
				}
			}
		}
		
		return count;
	}
	
	// 댓글 삭제 플래그 값 변경
	public int replyDelete(long reviewReplySeq)
	{
		int count = 0;
		
		try
		{
			count = reviewDao.replyDelete(reviewReplySeq);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] replyDelete Exception", e);
		}
		
		return count;
	}
	
	// 댓글 작성
	public int replyInsert(ReviewReply reviewReply)
	{
		int count = 0;
		
		try
		{
			count = reviewDao.replyInsert(reviewReply);
		}
		catch(Exception e)
		{
			logger.error("[ReviewService] replyInsert Exception", e);
		}
		
		return count;
	}
}
