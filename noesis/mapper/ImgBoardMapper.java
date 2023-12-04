package com.noesis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.noesis.domain.ImgBoardCriteria;
import com.noesis.domain.ImgBoardVO;

public interface ImgBoardMapper {
	
	public void register( @Param("imgBoardVO")ImgBoardVO imgBoardVO);
	
	public List<ImgBoardVO> getList();
	
	public ImgBoardVO read(Long bno);
	
	public int getTotalCount(ImgBoardCriteria criteria);
	
	public List<ImgBoardVO> getListWithPaging(ImgBoardCriteria criteria);
}
