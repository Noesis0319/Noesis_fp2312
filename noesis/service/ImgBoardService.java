package com.noesis.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.noesis.mapper.ImgBoardMapper;

import lombok.Setter;

@Service
public class ImgBoardService {
	@Setter(onMethod_=@Autowired)
	private ImgBoardMapper imgBoardMapper;
}
