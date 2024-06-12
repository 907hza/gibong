package com.gibong.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gibong.web.model.Review;
import com.gibong.web.model.ReviewFile;
import com.gibong.web.model.ReviewReply;

@Repository("reviewDao")
public interface ReviewDao 
{
	// 후기 글 갯수 조회
	public long totalCount(Review review);
	
	// 후기 최신순 글 조회
	public List<Review> list(Review review);
	
	// 후기 글 상세보기
	public Review reviewSelect(long reviewSeq);
	
	// 후기 첨부파일 조회
	public List<ReviewFile> reviewFileSelect(long reviewSeq);
	
	// 후기 조회수
	public int readCnt(long reviewSeq);
	
	// 나의 봉사 후기 글 목록
	public List<Review> myReview(String userId);
	
	// 나의 봉사 후기 글 댓글 갯수
	public long reviewReplyCnt(long reviewSeq);
	
	// 나의 봉사 후기 글 등록
	public int reviewInsert(Review review);
	
	// 나의 봉사 후기 첨부파일 등록
	public int reviewFileInsert(ReviewFile reviewFile);
	
	// 첨부파일 삭제
	public int reviewFileDelete(long reviewSeq);
	
	// 후기 수정
	public int reviewUpdate(Review review);
	
	// 후기 댓글 수
	public long replyCnt(long reviewSeq);
	
	// 글 삭제 플래그 변경
	public int reviewDelete(long reviewSeq);
	
	// 댓글 작성
	public int replyInsert(ReviewReply reviewReply);
	
	// 댓글 삭제 플래그 변경
	public int replyDelete(long reviewReplySeq);

	// 댓글 조회
	public List<ReviewReply> replySelect(long reviewSeq);
	
	// 애기 오더 조회
	// public long replyOrderNum(long reviewSeq);
	
	// 애기 댓글 조회
	// public int replyInsertBB(ReviewReply reviewReply);
}
