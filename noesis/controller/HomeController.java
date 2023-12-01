package com.noesis.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.noesis.domain.AuthVO;
import com.noesis.domain.BoardVO;
import com.noesis.domain.MemberVO;
import com.noesis.service.BoardService;
import com.noesis.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class HomeController {
	
	@Setter(onMethod_=@Autowired)
	private MemberService memberService;
	
	@Setter(onMethod_=@Autowired)
	private BoardService boardService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) {
		AuthVO authVO = (AuthVO)session.getAttribute("auth");
		if(authVO == null) {
			log.info("=====날씨정보 출력을 위해서 로그인 필요");
		}else {
			MemberVO selectVO = memberService.viewUserInfo(authVO.getUserId());
			model.addAttribute("location",selectVO.getLocation());
		}
		List<BoardVO>articlesList = boardService.getAdminArticleList();
		model.addAttribute("articlesList", articlesList);
		
		List<BoardVO>articlesList2 = boardService.getAdminArticleList2();
		model.addAttribute("articlesList2", articlesList2);
		
		List<BoardVO>articlesList3 = boardService.getAdminArticleList3();
		model.addAttribute("articlesList3", articlesList3);
		
		List<BoardVO>articlesList4 = boardService.getList();
		model.addAttribute("articlesList4", articlesList4);
		
		List<BoardVO>articlesList5 = boardService.getList2();
		model.addAttribute("articlesList5", articlesList5);
		
		List<BoardVO>articlesList6 = boardService.getList3();
		model.addAttribute("articlesList6", articlesList6);
		return "home";
	}
	
}
