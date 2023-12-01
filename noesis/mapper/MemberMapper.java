package com.noesis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.noesis.domain.MessageVO;
import com.noesis.domain.MemberVO;

public interface MemberMapper {
	
	public void insert(MemberVO memberVO) ;
	
	public void delete(String userId);
	
	public MemberVO selectMemberByUserId(String userId);
	
	public List<MemberVO> getMemberList();
	
	public MemberVO userInfo(String userId);
	
	public List<String> getRentalList(String userId);
	
	public void modMyInfo(MemberVO memberVO);
	
	public String findByUserName(String userName);
	
	public void modUserPw(@Param("userId")String userId, @Param("userPw")String userPw);
	
	public void sendMSG(MessageVO msgVO);
	
	public List<MessageVO> readMessage(String userId);
	
	public void delMSG(Long msg);
}
