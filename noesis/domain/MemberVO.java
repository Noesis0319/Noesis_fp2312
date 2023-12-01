package com.noesis.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class MemberVO {
	private String userId;
	private String userPw;
	private String userName;
	private String location;
	private String gender;
	private Timestamp regDate;
	private Timestamp updateDate;
}
