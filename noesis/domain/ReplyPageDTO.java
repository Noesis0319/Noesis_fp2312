package com.noesis.domain;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ReplyPageDTO{
	private	int replyCnt;
	private	List<ReplyVO> list;
	
	public ReplyPageDTO(int replyCnt, List<ReplyVO> list){
		this.replyCnt = replyCnt;
		this.list = list;
	}
}
