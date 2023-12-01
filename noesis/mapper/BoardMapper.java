package com.noesis.mapper;

import java.util.List;

import com.noesis.domain.BoardVO;
import com.noesis.domain.Criteria;

public interface BoardMapper {
	
//	Board1
	public void insert(BoardVO boardVO);
	public BoardVO read(Long bno);
	public int updateArticle(BoardVO board);
	public int deleteArticle(Long bno);
	public List<BoardVO> getList();
	public List<BoardVO> getListWithPaging(Criteria criteria);
	public int getTotalCount(Criteria criteria);
	
//	Board2
	public void insert2(BoardVO boardVO);
	public BoardVO read2(Long bno);
	public int updateArticle2(BoardVO board);
	public void deleteArticle2(Long bno);
	public List<BoardVO> getList2();
	public List<BoardVO> getListWithpPaging2(Criteria criteria);
	public int getTotalCount2(Criteria criteria);

//	Board3
	public void insert3(BoardVO boardVO);
	public BoardVO read3(Long bno);
	public int updateArticle3(BoardVO board);
	public void deleteArticle3(Long bno);
	public List<BoardVO> getList3();
	public List<BoardVO> getListWithpPaging3(Criteria criteria);
	public int getTotalCount3(Criteria criteria);
	
//	AdminBoard1
	public void adminArticleInsert(BoardVO boardVO);
	public BoardVO readAdmin(Long bno);
	public int updateAdminArticle(BoardVO board);
	public void deleteAdminArticle(Long bno);
	public List<BoardVO> getAdminAritlceList();
	public List<BoardVO> getListWithpPaging4(Criteria criteria);
	public int getTotalCount4(Criteria criteria);

//	AdminBoard2
	public void adminArticleInsert2(BoardVO boardVO);
	public BoardVO readAdmin2(Long bno);
	public int updateAdminArticle2(BoardVO board);
	public void deleteAdminArticle2(Long bno);
	public List<BoardVO> getAdminAritlceList2();
	public List<BoardVO> getListWithpPaging5(Criteria criteria);
	public int getTotalCount5(Criteria criteria);

	
//	AdminBoard3
	public void adminArticleInsert3(BoardVO boardVO);
	public BoardVO readAdmin3(Long bno);
	public int updateAdminArticle3(BoardVO board);
	public void deleteAdminArticle3(Long bno);
	public List<BoardVO> getAdminAritlceList3();
	public List<BoardVO> getListWithpPaging6(Criteria criteria);
	public int getTotalCount6(Criteria criteria);
}
