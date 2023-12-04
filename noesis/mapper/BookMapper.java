package com.noesis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.noesis.domain.BookCriteria;
import com.noesis.domain.BookVO;

public interface BookMapper {

	public List<BookVO> searchBook(BookCriteria bookCri);
	
	public BookVO getBook(BookVO bookVO);
	
	public void rental(@Param("bookName")String bookName, @Param("userId")String userId);
	
	public void returnBook(String bookName);
	
	public void bookReservation(@Param("bookName")String bookName, @Param("userId")String userId);
	
	public String checkBookReservation(@Param("bookName")String bookName, @Param("userId")String userId);
	
	public void bookReserve(String bookName);
}
