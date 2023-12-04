package com.noesis.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ImgBoardVO {
	private Long rn;
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Timestamp regDate;
	private Timestamp updateDate;
	private String uuid;
	private String uploadpath;
	private String filename;
	private String bookName;
	private String authors;
	
	private List<BoardAttachVO> attachList;
}
