package com.noesis.mapper;

import java.util.Date;
import java.util.List;

import com.noesis.domain.ReadingRoomVO;

public interface ReadingRoomMapper {

	public void reserve(ReadingRoomVO readingRoomVO);
	
	public List<ReadingRoomVO> getBySno(int sno);
	
	public List<ReadingRoomVO> getByDate(Date resDate);
	
	public void resCancel(ReadingRoomVO roomVO);
}
