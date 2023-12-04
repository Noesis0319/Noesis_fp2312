package com.noesis.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.noesis.domain.AuthVO;
import com.noesis.domain.BookCriteria;
import com.noesis.domain.BookVO;
import com.noesis.service.BookService;

import lombok.Setter;

@Controller
@RequestMapping("/book/*")
public class BookController {

	@Setter(onMethod_=@Autowired)
	private BookService bookService;

	@GetMapping("/bookBoard")
	public String bookBoard() {
		return "/bookBoard/bookBoard";

	}

	@GetMapping("/bookRental")
	public String getBookRental(@ModelAttribute BookVO bookVO, BookCriteria bookCri, Model model) {
		return "/bookBoard/bookRental";
	}
	
	@PostMapping("/bookRental")
	public String postBookRental(@ModelAttribute BookVO bookVO, BookCriteria bookCri, RedirectAttributes rttr) {
		rttr.addFlashAttribute("bookList", bookService.searchBook(bookCri));
		rttr.addFlashAttribute("bookCri", bookCri);
		return "redirect:/book/bookRental";
	}
	
	@GetMapping("/viewBook")
	public String viewBook(@RequestParam("bookName") String bookName,String searchBookType, String bookKeyword, Model model) {
		BookCriteria bookCri = new BookCriteria();
		bookCri.setBookKeyword(bookKeyword);
		bookCri.setSearchBookType(searchBookType);
		BookVO bookVO = new BookVO();
		bookVO.setBookName(bookName);
		System.out.println("bookname " + bookVO.getBookName() );
		model.addAttribute("bookVO", bookService.getBook(bookVO));
		model.addAttribute("bookCri", bookCri);
		return "/bookBoard/viewBook";
	}
	
	@PostMapping("/rental")
	public String getBookRental(@ModelAttribute BookVO bookVO, BookCriteria bookCri,  RedirectAttributes rttr, HttpSession session) {
		AuthVO authVO = (AuthVO)session.getAttribute("auth");
		if(authVO != null) {
			String userId = authVO.getUserId();
			bookService.rental(bookVO.getBookName(), userId);
		}
		rttr.addFlashAttribute("bookList", bookService.searchBook(bookCri));
		rttr.addFlashAttribute("result", "대출완료");
		return "redirect:/book/bookRental";
	}

	@PostMapping("/returnBook")
	public String getBookReturn(@ModelAttribute BookVO bookVO, BookCriteria bookCri, RedirectAttributes rttr) {
		System.out.println("=====" + bookVO.getBookName());
		bookService.returnBook(bookVO.getBookName());
		rttr.addFlashAttribute("bookList", bookService.searchBook(bookCri));
		return "redirect:/book/bookRental";
	}
	
	@PostMapping("/bookReservation")
	public String bookReservation(@ModelAttribute BookVO bookVO, BookCriteria bookCri, @RequestParam("userId")String userId, RedirectAttributes rttr) {
		bookService.bookReservation(bookVO.getBookName(), userId);
		bookService.bookReserve(bookVO.getBookName());
		rttr.addFlashAttribute("bookList", bookService.searchBook(bookCri));
		rttr.addFlashAttribute("msg", "예약이 완료되었습니다");
		return "redirect:/book/bookRental";
	}
}

