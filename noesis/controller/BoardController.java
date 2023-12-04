package com.noesis.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.noesis.domain.BoardAttachVO;
import com.noesis.domain.BoardVO;
import com.noesis.domain.Criteria;
import com.noesis.domain.PageDTO;
import com.noesis.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/board/*")
public class BoardController {
	
	@Setter(onMethod_=@Autowired)
	private BoardService boardService;
	
	@GetMapping("/")
	public String viewArticles(Criteria criteria, Model model) {
		List<BoardVO>articlesList = boardService.getList(criteria);
		model.addAttribute("articlesList", articlesList);
		int total = boardService.getTotal(criteria);
		model.addAttribute("pageDTO", new PageDTO(criteria, total));
		return "/board/listArticles";
	}
	
	@GetMapping("/board2")
	public String viewArticles2(Criteria criteria,Model model) {
		List<BoardVO>articlesList = boardService.getList2();
		model.addAttribute("articlesList", articlesList);
		int total = boardService.getTotal2(criteria);
		model.addAttribute("pageDTO", new PageDTO(criteria, total));
		return "/board/listArticles2";
	}
	
	@GetMapping("/board3")
	public String viewArticles3(Criteria criteria,Model model) {
		List<BoardVO>articlesList = boardService.getList3();
		model.addAttribute("articlesList", articlesList);
		int total = boardService.getTotal3(criteria);
		model.addAttribute("pageDTO", new PageDTO(criteria, total));
		return "/board/listArticles3";
	}
	
	@GetMapping("/adminBoard")
	public String viewAdminArticles(Criteria criteria,Model model) {
		List<BoardVO>articlesList = boardService.getAdminArticleList();
		model.addAttribute("articlesList", articlesList);
		int total = boardService.getTotal4(criteria);
		model.addAttribute("pageDTO", new PageDTO(criteria, total));
		return "/board/adminArticleList";
	}
	
	@GetMapping("/adminBoard2")
	public String viewAdminArticles2(Criteria criteria,Model model) {
		List<BoardVO>articlesList = boardService.getAdminArticleList2();
		model.addAttribute("articlesList", articlesList);
		int total = boardService.getTotal5(criteria);
		model.addAttribute("pageDTO", new PageDTO(criteria, total));
		return "/board/adminArticleList2";
	}
	
	@GetMapping("/adminBoard3")
	public String viewAdminArticles3(Criteria criteria,Model model) {
		List<BoardVO>articlesList = boardService.getAdminArticleList3();
		model.addAttribute("articlesList", articlesList);
		int total = boardService.getTotal6(criteria);
		model.addAttribute("pageDTO", new PageDTO(criteria, total));
		return "/board/adminArticleList3";
	}
	
	@GetMapping("/articleRegister")
	public String articleForm() {
		return "/board/articleRegistForm";
	}

	@PostMapping("/articleRegister")
	public String articleRegister(@ModelAttribute BoardVO boardVO, RedirectAttributes rttr) {
		String boardPath="";
		switch(boardVO.getBoardName()) {
		
		case "tbl_board" :
			boardPath = "";
			boardService.register(boardVO);
			break;
			
		case "tbl_board2" :
			boardPath = "board2";
			boardService.register2(boardVO);
			break;
			
		case "tbl_board3" :
			boardPath = "board3";
			boardService.register3(boardVO);
			break;
			
		case "tbl_admin_board" :
			boardPath = "adminBoard";
			boardService.adminArticleInsert(boardVO);
			break;
			
		case "tbl_admin_board2" :
			boardPath = "adminBoard2";
			boardService.adminArticleInsert2(boardVO);
			break;
			
		case "tbl_admin_board3" :
			boardPath = "adminBoard3";
			boardService.adminArticleInsert3(boardVO);
			break;
		}
		
		rttr.addFlashAttribute("result", boardVO.getBno());
		rttr.addFlashAttribute("boardName", boardVO.getBoardName());
		return "redirect:/board/" + boardPath;
	}
	
	@GetMapping("/read")
	public String read(@RequestParam Long bno, String boardName,Criteria criteria, Model model) {
		String path = "";
		switch(boardName.toUpperCase()) {
		
		case "TBL_BOARD" :
			path ="viewArticle";
			model.addAttribute("article", boardService.read(bno));
			break;
			
		case "TBL_BOARD2" :
			path ="viewArticle2";
			model.addAttribute("article", boardService.read2(bno));
			break;
			
		case "TBL_BOARD3" :
			path ="viewArticle3";
			model.addAttribute("article", boardService.read3(bno));
			break;
			
		case "TBL_ADMIN_BOARD" :
			path ="viewAdminArticle";
			model.addAttribute("article", boardService.readAdmin(bno));
			break;
			
		case "TBL_ADMIN_BOARD2" :
			path ="viewAdminArticle2";
			model.addAttribute("article", boardService.readAdmin2(bno));
			break;
			
		case "TBL_ADMIN_BOARD3" :
			path ="viewAdminArticle3";
			model.addAttribute("article", boardService.readAdmin3(bno));
			break;
		}
		return "/board/" + path;
	}
	
	@GetMapping("/modify")
	public String modify(@ModelAttribute BoardVO boardVO, Criteria criteria, Model model) {
		long bno = boardVO.getBno();
		switch((boardVO.getBoardName()).toUpperCase()) {
		
		case "TBL_BOARD" :
			model.addAttribute("article", boardService.read(bno));
			break;
			
		case "TBL_BOARD2" :
			model.addAttribute("article", boardService.read2(bno));
			break;
			
		case "TBL_BOARD3" :
			model.addAttribute("article", boardService.read3(bno));
			break;
			
		case "TBL_ADMIN_BOARD" :
			model.addAttribute("article", boardService.readAdmin(bno));
			break;
			
		case "TBL_ADMIN_BOARD2" :
			model.addAttribute("article", boardService.readAdmin2(bno));
			break;
			
		case "TBL_ADMIN_BOARD3" :
			model.addAttribute("article", boardService.readAdmin3(bno));
			break;
			
		}
		model.addAttribute("criteria", criteria);
		return "/board/modify";
	}
	
	@PostMapping("/modify")
	public String requestModify(@ModelAttribute BoardVO boardVO, Criteria criteria, RedirectAttributes rttr) {
		switch(boardVO.getBoardName().toUpperCase()) {
		
		case "TBL_BOARD" :
			boardService.modify(boardVO);
			break;
			
		case "TBL_BOARD2" :
			boardService.updateArticle2(boardVO);
			break;
			
		case "TBL_BOARD3" :
			boardService.updateArticle3(boardVO);
			break;
			
		case "TBL_ADMIN_BOARD" :
			boardService.updateAdminArticle(boardVO);
			break;
			
		case "TBL_ADMIN_BOARD2" :
			boardService.updateAdminArticle2(boardVO);
			break;
			
		case "TBL_ADMIN_BOARD3" :
			boardService.updateAdminArticle3(boardVO);
			break;
		}
		rttr.addAttribute("pageNum", criteria.getPageNum());
		rttr.addAttribute("amount", criteria.getAmount());
		rttr.addAttribute("bno", boardVO.getBno());
		rttr.addAttribute("boardName", boardVO.getBoardName());
		return "redirect:/board/read" + criteria.getListLink();
	}
	@GetMapping("/delete")
	public String deleteArticle(@RequestParam("boardName") String boardName, @RequestParam("bno") Long bno, Criteria criteria, RedirectAttributes rttr) {
		String path = "";
		List<BoardAttachVO> attachList = boardService.getAttachList(bno);
		
		switch(boardName) {
		
		case "TBL_BOARD" :
			boardService.deleteArticle(bno);
			if(boardService.deleteArticle(bno)) {
				deleteFiles(attachList);
//				rttr.addFlashAttribute("result", "삭제되었습니다");
			}
			path ="";
			break;
		case "TBL_BOARD2" :
			path ="board2";
			boardService.deleteArticle2(bno);
			break;
		case "TBL_BOARD3" :
			path ="board3";
			boardService.deleteArticle3(bno);
			break;
		case "TBL_ADMIN_BOARD" :
			path ="adminBoard";
			boardService.deleteAdminArticle(bno);
			break;
		case "TBL_ADMIN_BOARD2" :
			path ="adminBoard2";
			boardService.deleteAdminArticle2(bno);
			break;
		case "TBL_ADMINBOARD3" :
			path ="adminBoard3";
			boardService.deleteAdminArticle3(bno);
			break;
		}
		rttr.addAttribute("pageNum", criteria.getPageNum());
		rttr.addAttribute("amount", criteria.getAmount());
		return "redirect:/board/" + path + criteria.getListLink();
	}
	
	@GetMapping(value = "/getAttachList/{bno}", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(@PathVariable("bno") Long bno){
		return new ResponseEntity<>(boardService.getAttachList(bno), HttpStatus.OK);
	}
	
	@GetMapping(value = "/getAttachListOnList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<String> getAttachListOnList(@RequestParam(value="list[]") List<Long> list){
		
//		Way 1 :
//		Map<Long, List<BoardAttachVO>> map = new HashMap<Long, List<BoardAttachVO>>();
//		for(Long bno : list) {
//			map.put(bno, boardService.getAttachList(bno));
//		}
//		String gson = new Gson().toJson(map, HashMap.class);
//		return new ResponseEntity<>(gson, HttpStatus.OK);
		
//		Way 2 :
		JsonObject jObj = new JsonObject();
		for(Long bno : list) {
			if(!boardService.getAttachList(bno).isEmpty()) {
				BoardAttachVO attachVO = boardService.getAttachList(bno).get(0);
				String voJson = new Gson().toJson(attachVO);
				jObj.addProperty(String.valueOf(bno), voJson);
			}
		}
		return new ResponseEntity<>(jObj.toString(), HttpStatus.OK);
	}
	
//	==========
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		for (BoardAttachVO attachVO : attachList) {
			try {
				Path file = Paths.get("C:\\upload\\" + attachVO.getUploadpath() + "\\" + attachVO.getUuid() + "_" + attachVO.getFilename());
				Files.deleteIfExists(file);
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\" + attachVO.getUploadpath() + "\\s_" + attachVO.getUuid() + "_" + attachVO.getFilename());
					Files.delete(thumbNail);
				}
			} catch (Exception e) {
				log.error("파일 삭제 오류 : " + e.getMessage());
			}
		}
	}
}	



