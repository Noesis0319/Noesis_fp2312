package com.noesis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.noesis.domain.Criteria;
import com.noesis.domain.ReplyVO;

public interface ReplyMapper{
	
	public int insert(ReplyVO vo);
	
	public ReplyVO read(Long rno);
	
	public int update(ReplyVO vo);
	
	public int delete(Long rno);
	
	public List<ReplyVO> getList(Long bno);
	
	public List<ReplyVO> getListWithPaging(@Param("bno") Long bno, @Param("criteria") Criteria criteria);
	
	public int getTotalCount(Long bno);
}
