package com.noesis.controller;

import java.util.List;

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
import com.noesis.domain.MemberVO;
import com.noesis.domain.MessageVO;
import com.noesis.service.MemberService;

import lombok.Setter;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	private AuthVO authVO;
	
	@Setter(onMethod_=@Autowired)
	private MemberService memberService;

	@GetMapping("/")
	public String viewMemeber(Model model, HttpSession session) {
		authVO = (AuthVO)session.getAttribute("auth");
		if(authVO.getUserId().equals("admin")) {
			List<MemberVO>memberList = memberService.getMemberList();
			model.addAttribute("memberList", memberList);
			return  "/member/listMembers";
		}else {
			return "redirect:/";
		}
	}
	
	@GetMapping("/signup")
	public String signupForm() {
		return "/member/signupForm";
	}

	@PostMapping("/signup")
	public String signupSubmit(@ModelAttribute MemberVO memberVO, HttpSession session, RedirectAttributes rttr) {
		String userPw = memberVO.getUserPw();
		memberService.signup(memberVO);
		try {
			memberVO.setUserPw(userPw);
			authVO = memberService.authenticate(memberVO);
			session.setAttribute("auth", authVO);
		} catch (Exception e) {}
		return "redirect:/";
	}

	@GetMapping("/login")
	public String loginForm() {
		return "/member/loginForm";
	}

	@PostMapping("/login")
	public String requestLogin(@ModelAttribute MemberVO memberVO, HttpSession session, RedirectAttributes rttr, Model model) {
		try {
			authVO = memberService.authenticate(memberVO);
			session.setAttribute("auth", authVO);
			String userURI = (String)session.getAttribute("userURI");
			if(userURI != null) {
				session.removeAttribute(userURI);
				return "redirect:" + userURI;
			}
			return "redirect:/";
		} catch (Exception e) {
			rttr.addFlashAttribute("error", e.getMessage());
			rttr.addFlashAttribute("memberVO", memberVO);
			return "redirect:/member/login"; 
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		session.removeAttribute("auth");
		return "redirect:/";
	}

	@GetMapping("/userInfo")
	public String viewUserInfo(Model model, @RequestParam("userId") String userId) {
		if(userId != null && memberService.getRentalList(userId) != null) {
			model.addAttribute("rentalList", memberService.getRentalList(userId));
			model.addAttribute("userInfo", memberService.userInfo(userId));
		}
		return "/member/userInfo";
	}
	@GetMapping("/modMyInfo")
	public String modMyInfo(HttpSession session, Model model) {
		authVO = (AuthVO)session.getAttribute("auth");
		MemberVO memberVO = memberService.userInfo(authVO.getUserId());
		model.addAttribute("memberVO", memberVO);
		return "/member/modMyInfo";
	}

	@PostMapping("/modMyInfo")
	public String modMyInfo2(@ModelAttribute MemberVO memberVO, RedirectAttributes rttr) {
		memberService.modMyInfo(memberVO);
		rttr.addFlashAttribute("rentalList", memberService.getRentalList(memberVO.getUserId()));
		rttr.addFlashAttribute("userInfo", memberService.userInfo(memberVO.getUserId()));
		return "redirect:/member/userInfo?userId=" + memberVO.getUserId();
	}
	
	@GetMapping("/findUserId")
	public String findUserId() {
		return "/member/findUserId";
	}

	@PostMapping("/findUserId")
	public String postFindUserId(@RequestParam("userName")String userName,RedirectAttributes rttr) {
		rttr.addFlashAttribute("userId", memberService.findByUserName(userName));
		return "redirect:/member/login";
	}
	
	@GetMapping("/findUserPw")
	public String findUserPw() {
		return "/member/findUserPw";
	}

	@PostMapping("/findUserPw")
	public String postFindUserPw(@RequestParam("userId")String userId,@RequestParam("userPw")String userPw, RedirectAttributes rttr) {
		memberService.modUserPw(userId, userPw);
		return "redirect:/member/login";
	}
	@GetMapping("/sendMSG")
	public String sendMSG(@RequestParam("receiver")String receiver, Model model) {
		model.addAttribute("receiver", receiver);
		return "/member/sendMSG";

	}
	@PostMapping("/sendMSG")
	public String postSendMSG(@ModelAttribute MessageVO msgVO, RedirectAttributes rttr) {
		memberService.sendMSG(msgVO);
		rttr.addAttribute("userId", msgVO.getReceiver());
		rttr.addFlashAttribute("sendResult", "메세지가 전송되었습니다");
		return "redirect:/member/userInfo";
	}
	
	@GetMapping("/readMessage")
	public String readMessage(@RequestParam("userId")String userId, Model model) {
		List<MessageVO> msgVO = memberService.readMessage(userId);
		model.addAttribute("msgVO", msgVO);
		return "/member/readMessage";
	}
	
	@PostMapping("/delMSG")
	public String delMSG(@RequestParam("mno")List<Long>mnoList,@RequestParam("userId")String userId, Model model) {
		memberService.delMSG(mnoList);
		model.addAttribute("delResult", "메세지가 삭제되었습니다");
		model.addAttribute("userId", userId);
		return "redirect:/member/readMessage";
	}
}
