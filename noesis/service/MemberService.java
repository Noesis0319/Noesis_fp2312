package com.noesis.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.noesis.domain.AuthVO;
import com.noesis.domain.MemberVO;
import com.noesis.domain.MessageVO;
import com.noesis.mapper.MemberMapper;

import lombok.Setter;

@Service
public class MemberService {
	
	@Setter(onMethod_=@Autowired)
	private MemberMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private PasswordEncoder pwEncoder;
	
	public List<MemberVO> getMemberList() {
		return mapper.getMemberList();
	}
	
	public void signup(MemberVO memberVO) {
		memberVO.setUserPw(pwEncoder.encode(memberVO.getUserPw()));
		mapper.insert(memberVO);
	}
	
	public MemberVO viewUserInfo(String userId) {
		MemberVO selectVO = mapper.selectMemberByUserId(userId);
		return selectVO;
	}
	
	public AuthVO authenticate(MemberVO memberVO) throws Exception {
		AuthVO authVO = new AuthVO();
		String userId = memberVO.getUserId();
		MemberVO selectVO = mapper.selectMemberByUserId(userId);
		if(selectVO == null) {
			throw new Exception("noneUser");
		}	
		if(!pwEncoder.matches(memberVO.getUserPw(), selectVO.getUserPw())) {
			throw new Exception("noMatch");
		}
		authVO.setUserId(userId);
		authVO.setUserName(selectVO.getUserName());
		return authVO;
	}
	
	public MemberVO userInfo(String userId) {
		return mapper.userInfo(userId);
	}
	
	public List<String> getRentalList(String userId){
		return mapper.getRentalList(userId);
	}
	
	public void modMyInfo(MemberVO memberVO) {
		memberVO.setUserPw(pwEncoder.encode(memberVO.getUserPw()));
		mapper.modMyInfo(memberVO);
	}
	
	public String findByUserName(String userName) {
		return mapper.findByUserName(userName);
	}
	
	public void modUserPw(String userId, String userPw) {
		userPw = pwEncoder.encode(userPw);
		mapper.modUserPw(userId, userPw);
	}
	
	public void sendMSG(MessageVO msgVO) {
		mapper.sendMSG(msgVO);
	}
	
	public List<MessageVO> readMessage(String userId) {
		return mapper.readMessage(userId);
	}
	
	public void delMSG(List<Long> mnoList) {
		for(Long mno : mnoList) {
			mapper.delMSG(mno);
		}
	}
}
