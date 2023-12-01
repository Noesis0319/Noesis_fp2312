package com.noesis.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AttachFileDTO {
	private String filename;
	private String uploadpath;
	private String uuid;
	private boolean image;
}
