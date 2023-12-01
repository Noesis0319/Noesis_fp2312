package com.noesis.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.noesis.domain.BookVO;
import com.noesis.mapper.BookMapper;

import lombok.Setter;

@Service
public class BookService {
	@Setter(onMethod_=@Autowired)
	private BookMapper bookMapper;
	
	public List<BookVO> searchBook(String searchBook) {
		return bookMapper.searchBook(searchBook);
	}
	
	public void rental(String bookName, String userId) {
		bookMapper.rental(bookName, userId);
	}
	
	public void returnBook(String bookName) {
		bookMapper.returnBook(bookName);
	}
	
	public void bookReservation(String bookName, String userId) {
		bookMapper.bookReservation(bookName, userId);
	}
	
	public String checkBookReservation(String bookName, String userId) {
		return bookMapper.checkBookReservation(bookName, userId);
	}
	
	public void bookReserve(String bookName) {
		bookMapper.bookReserve(bookName);
	}
}
