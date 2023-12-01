package com.noesis.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.noesis.domain.BoardAttachVO;
import com.noesis.domain.BoardVO;
import com.noesis.domain.Criteria;
import com.noesis.mapper.BoardAttachMapper;
import com.noesis.mapper.BoardMapper;

import lombok.Setter;

@Service
public class BoardService {
	
	@Setter(onMethod_=@Autowired)
	private BoardMapper boardMapper;
	
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachMapper;
	
//	Board1
//	A + B를 하나로 묶음, @Transactional이 없을땐 A실행, B실패인 경우가 생기지만, 있을땐 A,B 둘 다 실행되거나 롤백된다
	@Transactional
	public void register(BoardVO boardVO) {
		boardMapper.insert(boardVO);
		List<BoardAttachVO>voList = boardVO.getAttachList();
		if(voList == null || voList.isEmpty()) {
			return;
		}
		for(BoardAttachVO attachVO : voList) {
			attachVO.setBno(boardVO.getBno());
			attachMapper.insert(attachVO);
		}
	}
	
	public BoardVO read(Long bno) {
		return boardMapper.read(bno);
	}
	
	@Transactional
	public boolean deleteArticle(Long bno) {
		attachMapper.deleteAll(bno);
		return boardMapper.deleteArticle(bno) == 1;
	}
	
	public List<BoardVO> getList() {
		List<BoardVO> boardList = boardMapper.getList();
		return boardList;

	}
	
	public List<BoardVO> getList(Criteria criteria) {
		List<BoardVO> boardList = boardMapper.getListWithPaging(criteria);
		return boardList;
	}
	
	public int getTotal(Criteria criteria) {
		return boardMapper.getTotalCount(criteria);
	}
	
	public void updateArticle(BoardVO boardVO) {
		boardMapper.updateArticle(boardVO);
	}
	
	public List<BoardAttachVO> getAttachList(Long bno) {
		return attachMapper.findByBno(bno);
	}
	
//	Board2
	public void register2(BoardVO boardVO) {
		boardMapper.insert2(boardVO);
	}
	
	public BoardVO read2(Long bno) {
		return boardMapper.read2(bno);
	}
	
	public void deleteArticle2(Long bno) {
		boardMapper.deleteArticle2(bno);
	}
	
	public List<BoardVO> getList2() {
		List<BoardVO> boardList2 = boardMapper.getList2();
		return boardList2;
	}
	
	public List<BoardVO> getList2(Criteria criteria) {
		List<BoardVO> boardList = boardMapper.getListWithpPaging2(criteria);
		return boardList;
	}
	
	public int getTotal2(Criteria criteria) {
		return boardMapper.getTotalCount2(criteria);
	}
	
	public void updateArticle2(BoardVO boardVO) {
		boardMapper.updateArticle2(boardVO);
	}
//	Board3
	public void register3(BoardVO boardVO) {
		boardMapper.insert3(boardVO);
	}
	
	public BoardVO read3(Long bno) {
		return boardMapper.read3(bno);
	}
	
	public void deleteArticle3(Long bno) {
		boardMapper.deleteArticle3(bno);
	}
	
	public List<BoardVO> getList3() {
		List<BoardVO> boardList3 = boardMapper.getList3();
		return boardList3;
	}
	
	public List<BoardVO> getList3(Criteria criteria) {
		List<BoardVO> boardList = boardMapper.getListWithpPaging3(criteria);
		return boardList;
	}
	
	public int getTotal3(Criteria criteria) {
		return boardMapper.getTotalCount3(criteria);
	}
	
	public void updateArticle3(BoardVO boardVO) {
		boardMapper.updateArticle3(boardVO);
	}
	
//	AdminBoard1
	public void adminArticleInsert(BoardVO boardVO) {
		boardMapper.adminArticleInsert(boardVO);
	}
	
	public BoardVO readAdmin(Long bno) {
		return boardMapper.readAdmin(bno);
	}
	
	public void deleteAdminArticle(Long bno) {
		boardMapper.deleteAdminArticle(bno);
	}
	
	public List<BoardVO> getAdminArticleList() {
		List<BoardVO> adminArticleList = boardMapper.getAdminAritlceList();
		return adminArticleList;
	}
	
	public List<BoardVO> getAdminArticleList(Criteria criteria) {
		List<BoardVO> adminArticleList = boardMapper.getListWithpPaging4(criteria);
		return adminArticleList;
	}
	
	public int getTotal4(Criteria criteria) {
		return boardMapper.getTotalCount4(criteria);
	}
	
	public void updateAdminArticle(BoardVO boardVO) {
		boardMapper.updateAdminArticle(boardVO);
	}
	
//	AdminBoard2
	public void adminArticleInsert2(BoardVO boardVO) {
		boardMapper.adminArticleInsert2(boardVO);
	}
	
	public BoardVO readAdmin2(Long bno) {
		return boardMapper.readAdmin2(bno);
	}
	
	public void deleteAdminArticle2(Long bno) {
		boardMapper.deleteAdminArticle2(bno);
	}
	
	public List<BoardVO> getAdminArticleList2() {
		List<BoardVO> adminArticleList2 = boardMapper.getAdminAritlceList2();
		return adminArticleList2;
	}
	
	public List<BoardVO> getAdminArticleList2(Criteria criteria) {
		List<BoardVO> adminArticleList2 = boardMapper.getListWithpPaging5(criteria);
		return adminArticleList2;
	}
	
	public int getTotal5(Criteria criteria) {
		return boardMapper.getTotalCount5(criteria);
	}
	
	public void updateAdminArticle2(BoardVO boardVO) {
		boardMapper.updateAdminArticle2(boardVO);
	}
//	AdminBoard3
	public void adminArticleInsert3(BoardVO boardVO) {
		boardMapper.adminArticleInsert3(boardVO);
	}
	
	public BoardVO readAdmin3(Long bno) {
		return boardMapper.readAdmin3(bno);
	}

	public void deleteAdminArticle3(Long bno) {
		boardMapper.deleteAdminArticle3(bno);
	}
	
	public List<BoardVO> getAdminArticleList3() {
		List<BoardVO> adminArticleList3 = boardMapper.getAdminAritlceList3();
		return adminArticleList3;
	}
	
	public List<BoardVO> getAdminArticleList3(Criteria criteria) {
		List<BoardVO> adminArticleList3 = boardMapper.getListWithpPaging6(criteria);
		return adminArticleList3;
	}
	
	public int getTotal6(Criteria criteria) {
		return boardMapper.getTotalCount6(criteria);
	}

	public void updateAdminArticle3(BoardVO boardVO) {
		boardMapper.updateAdminArticle3(boardVO);
	}
	
	@Transactional
	public boolean modify(BoardVO boardVO) {
		attachMapper.deleteAll(boardVO.getBno());
		boolean modifyResult = boardMapper.updateArticle(boardVO) == 1; //수정된 갯수
		List<BoardAttachVO> list = boardVO.getAttachList();
		if(modifyResult && list != null) {
			for(BoardAttachVO vo : list) {
				vo.setBno(boardVO.getBno());
				attachMapper.insert(vo);
			}
		}
		return modifyResult;
	}
}
