package com.noesis.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.JsonObject;
import com.noesis.domain.Criteria;
import com.noesis.domain.ReplyPageDTO;
import com.noesis.domain.ReplyVO;
import com.noesis.service.ReplyService;

import lombok.AllArgsConstructor;

@RestController
@RequestMapping("/replies/*")
@AllArgsConstructor
public class ReplyController{
	private	ReplyService service;
	
	@GetMapping(value = "/pages/{bno}", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public	ResponseEntity<List<ReplyVO>> getList(@PathVariable("bno") Long bno){
		List<ReplyVO> list = service.getList(bno);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public	ResponseEntity<String> register(@RequestBody ReplyVO vo){
		int	registerCount = service.register(vo);
		return registerCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/{rno}", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public	ResponseEntity<ReplyVO>	get(@PathVariable("rno") Long rno){
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	@PatchMapping(value = "/{rno}", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public	ResponseEntity<String> modify(@PathVariable("rno") Long rno, @RequestBody ReplyVO vo){
		int	modifyCount = service.modify(vo);
		return modifyCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping(value = "/{rno}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public	ResponseEntity<String> remove(@PathVariable("rno") Long rno){
		int	removeCount = service.remove(rno);
		return removeCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/pages/{bno}/{page}", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public	ResponseEntity<ReplyPageDTO> getListWithPaging
	(@PathVariable("bno") Long bno, @PathVariable("page") int page){
		Criteria criteria = new Criteria(page, 10);
		ReplyPageDTO dto = service.getListWithPaging(bno, criteria);
		return new ResponseEntity<>(dto, HttpStatus.OK);
	}

	@GetMapping(value = "/cnt", produces= {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<String> getReplyCnt(@RequestParam(value="list[]") List<Long> list){
		JsonObject jObj = new JsonObject();
		for(Long bno : list) {
			jObj.addProperty(String.valueOf(bno), service.getTotal(bno));
		}
		return new ResponseEntity<>(jObj.toString(), HttpStatus.OK);
	}
}
