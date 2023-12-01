package com.noesis.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.noesis.service.ImgBoardService;

import lombok.Setter;

@Controller
@RequestMapping("/imgBoard/*")
public class ImgBoardController {
	@Setter(onMethod_=@Autowired)
	private ImgBoardService imgBoardService;
}
