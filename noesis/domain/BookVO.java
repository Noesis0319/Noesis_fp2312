package com.noesis.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class BookVO {
	private String bookName;
	private String authors;
	private String publisher;
	private String thumbnail;
	private String rental;
	private String userId;
	private String reservation;
}
