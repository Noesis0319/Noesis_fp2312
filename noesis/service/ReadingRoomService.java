package com.noesis.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.noesis.domain.ReadingRoomVO;
import com.noesis.mapper.ReadingRoomMapper;

import lombok.Setter;

@Service
public class ReadingRoomService {
	
	@Setter(onMethod_=@Autowired)
	private ReadingRoomMapper readingRoomMapper;
	
	public void reserve(ReadingRoomVO readingRoomVO) {
		readingRoomMapper.reserve(readingRoomVO);
	}
	
	public List<ReadingRoomVO> getBySno(int sno){
		return readingRoomMapper.getBySno(sno);
	}

	public List<ReadingRoomVO> getByDate(Date resDate){
		return readingRoomMapper.getByDate(resDate);
	}
	
	public void resCancel(ReadingRoomVO roomVO) {
		readingRoomMapper.resCancel(roomVO);
	}
}
