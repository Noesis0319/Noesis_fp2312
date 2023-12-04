package com.noesis.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ImgBoardCriteria {
	private static final int app = 15;
	private int pageNum;
	private int amount;
	private String type;
	private String keyword;
	private String dateType;
	
	public ImgBoardCriteria() {
		this(1, app);
	}
	
	public ImgBoardCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		return builder.toUriString();
	}
	
	public String[] getTypeArr() {
		return type == null? new String[] {}: type.split("");
	}
}
