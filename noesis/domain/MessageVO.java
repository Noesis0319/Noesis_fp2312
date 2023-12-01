package com.noesis.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class MessageVO {
	private Long mno;
	private String receiver;
	private String sender;
	private String content;
}
