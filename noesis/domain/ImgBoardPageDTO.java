package com.noesis.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ImgBoardPageDTO {
	private static final int ppl = 10;
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private ImgBoardCriteria criteria;
	
	public ImgBoardPageDTO(ImgBoardCriteria criteria, int total) {
		this.criteria = criteria;
		this.total = total;
		
		this.endPage = (int) (Math.ceil(criteria.getPageNum()/(float)(ppl*1.0))) * ppl;
		this.startPage = this.endPage - (ppl - 1);
		int realEnd = (int) (Math.ceil((total * 1.0) /  criteria.getAmount()));
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
}
