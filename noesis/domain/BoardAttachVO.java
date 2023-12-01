package com.noesis.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class BoardAttachVO {
	private String uuid;
	private String uploadpath;
	private String filename;
	private String filetype;
	private Long bno;
	
	
}
