package com.noesis.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.noesis.domain.Criteria;
import com.noesis.domain.ReplyPageDTO;
import com.noesis.domain.ReplyVO;
import com.noesis.mapper.ReplyMapper;

import lombok.Setter;

@Service
public class ReplyService{
	
	@Setter(onMethod_ = @Autowired)
	private	ReplyMapper	mapper;

	public int register(ReplyVO vo){
		return mapper.insert(vo);
	}

	public ReplyVO get(Long rno){
		return mapper.read(rno);
	}

	public int modify(ReplyVO vo){
		return mapper.update(vo);
	}

	public int remove(Long rno){
		return mapper.delete(rno);
	}

	public List<ReplyVO> getList(Long bno){
		return mapper.getList(bno);
	}

	public ReplyPageDTO getListWithPaging(Long bno, Criteria criteria){
		return new ReplyPageDTO(mapper.getTotalCount(bno), mapper.getListWithPaging(bno, criteria));
	}

	public int getTotal(Long bno){
		return mapper.getTotalCount(bno);
	}
}
