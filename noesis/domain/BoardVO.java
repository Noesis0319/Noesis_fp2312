package com.noesis.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class BoardVO {
	private Long rn;
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private String boardName;
	private String subject;
	private Timestamp regDate;
	private Timestamp updateDate;
	
	private List<BoardAttachVO> attachList;
	
	@Override
	public String toString() {
		return "rn: " + this.rn + " bno: " + this.bno + " title: " + this.title + " content: " + this.content 
				+ " writer: " + this.writer + " boardName: " + this.boardName + " subject: " + this.subject;
	}
}
