package com.noesis.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.noesis.domain.BookVO;
import com.noesis.domain.ImgBoardCriteria;
import com.noesis.domain.ImgBoardPageDTO;
import com.noesis.domain.ImgBoardVO;
import com.noesis.service.ImgBoardService;

import lombok.Setter;

@Controller
@RequestMapping("/imgBoard/*")
public class ImgBoardController {
	@Setter(onMethod_=@Autowired)
	private ImgBoardService imgBoardService;
	
	@GetMapping("/board")
	public String viewListImgBoard1(ImgBoardCriteria criteria, Model model) {
		List<ImgBoardVO> articlesList = imgBoardService.getListWithPaging(criteria);
		model.addAttribute("articlesList", articlesList);
		int total = imgBoardService.getTotalCount(criteria);
		model.addAttribute("pageDTO", new ImgBoardPageDTO(criteria, total));
		return "/imgBoard/imgBoard";
	}
	
	@GetMapping("/registImgBoard")
	public String getRegistImgBoard() {
		return "/imgBoard/imgBoardRegistForm";
	}
	
	@PostMapping("/registImgBoard")
	public String registImgBoard(@ModelAttribute ImgBoardVO imgBoardVO, RedirectAttributes rttr ) {
		imgBoardService.register(imgBoardVO);
		return "redirect:/imgBoard/board";
	}
	
	@GetMapping(value = "/getAttachListOnList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<String> getAttachListOnList(@RequestParam(value="list[]") List<Long> list){
		JsonObject jObj = new JsonObject();
		for(Long bno : list) {
			ImgBoardVO imgBoardVO = imgBoardService.read(bno);
			String voJson = new Gson().toJson(imgBoardVO);
			jObj.addProperty(String.valueOf(bno), voJson);
		}
		return new ResponseEntity<>(jObj.toString(), HttpStatus.OK);
	}
}
