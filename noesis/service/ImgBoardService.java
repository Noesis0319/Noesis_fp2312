package com.noesis.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.noesis.domain.ImgBoardCriteria;
import com.noesis.domain.ImgBoardVO;
import com.noesis.mapper.ImgBoardMapper;

import lombok.Setter;

@Service
public class ImgBoardService {
	
	@Setter(onMethod_=@Autowired)
	private ImgBoardMapper imgBoardMapper;

	public void register(ImgBoardVO imgBoardVO) {
		imgBoardMapper.register(imgBoardVO);
	}
	
	public List<ImgBoardVO> getList() {
		List<ImgBoardVO> boardList = imgBoardMapper.getList();
		return boardList;
	}

	public List<ImgBoardVO> getListWithPaging(ImgBoardCriteria criteria) {
		List<ImgBoardVO> boardList = imgBoardMapper.getListWithPaging(criteria);
		return boardList;
	}
	
	public int getTotalCount(ImgBoardCriteria criteria) {
		return imgBoardMapper.getTotalCount(criteria);
	}
	
	public ImgBoardVO read(Long bno) {
		return imgBoardMapper.read(bno);
	}
}
