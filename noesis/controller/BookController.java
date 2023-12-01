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
import com.noesis.domain.BookVO;
import com.noesis.service.BookService;

import lombok.Setter;

@Controller
@RequestMapping("/book/*")
public class BookController {
	@Setter(onMethod_=@Autowired)
	private BookService bookService;
	
	@GetMapping("/bookBoard")
	public String bookBoard(Model model) {
		return "/resourcesBoard/bookBoard";
	}

	@GetMapping("/bookRental")
	public String getBookRental(Model model) {
		return "/resourcesBoard/bookRental";
	}

	@PostMapping("/bookRental")
	public String postBookRental(@ModelAttribute BookVO bookVO, RedirectAttributes rttr) {
		rttr.addFlashAttribute("searchBook", bookService.searchBook(bookVO.getBookName()));
		return "redirect:/book/bookRental";
	}
	
	@GetMapping("/bookRental/rental")
	public String getBookRental(@RequestParam("bookName") String bookName,  RedirectAttributes rttr, HttpSession session) {
		AuthVO authVO = (AuthVO)session.getAttribute("auth");
		if(authVO != null) {
			String userId = authVO.getUserId();
			bookService.rental(bookName, userId);
		}
		rttr.addFlashAttribute("bookInfo", bookService.searchBook(bookName));
		rttr.addFlashAttribute("result", "대출완료");
		return "redirect:/book/bookRental";
	}

	@GetMapping("/bookRental/returnBook")
	public String getBookReturn(@RequestParam String bookName,  RedirectAttributes rttr) {
		bookService.returnBook(bookName);
		rttr.addFlashAttribute("bookInfo", bookService.searchBook(bookName));
		return "redirect:/book/bookRental";
	}
	
	@GetMapping("/bookReservation")
	public String bookReservation(@RequestParam("bookName") String bookName,@RequestParam("userId") String userId,  RedirectAttributes rttr) {
		bookService.bookReservation(bookName, userId);
		bookService.bookReserve(bookName);
		rttr.addFlashAttribute("msg", "예약이 완료되었습니다");
		return "redirect:/book/bookRental";
	}
}

