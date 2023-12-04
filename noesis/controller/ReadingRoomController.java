package com.noesis.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.noesis.domain.ReadingRoomVO;
import com.noesis.service.ReadingRoomService;

import lombok.Setter;

@Controller
@RequestMapping("/readingRoom/*")
public class ReadingRoomController {
	
	@Setter(onMethod_=@Autowired)
	private ReadingRoomService readingRoomService;
	
	@GetMapping("/")
	public String getReservation(){
		 return "/readingRoom/readingRoom";
	}

	@PostMapping("/")
	public String postReservation(@RequestParam("onlyDate")String onlyDate, RedirectAttributes rttr){
		if(onlyDate.length() == 1) {
			onlyDate = "0" + onlyDate;
		}
		String resDate = "23/12/" + onlyDate;

        SimpleDateFormat dateFormat = new SimpleDateFormat("yy/MM/dd");
        Date date = new Date();
        try {
            date = dateFormat.parse(resDate);
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<ReadingRoomVO> voList = readingRoomService.getByDate(date);
        if(!voList.isEmpty()) {
        	rttr.addFlashAttribute("resDate", voList.get(0).getResDate());
        }
        rttr.addFlashAttribute("voList", voList);
        rttr.addFlashAttribute("onlyDate", onlyDate);
		return "redirect:/readingRoom/";
	}

	@PostMapping("/reservation")
	public String reserve(@ModelAttribute ReadingRoomVO roomVO,@RequestParam("onlyDate")String onlyDate, RedirectAttributes rttr) {
        readingRoomService.reserve(roomVO);
        
        List<ReadingRoomVO> voList = readingRoomService.getByDate(roomVO.getResDate());
        rttr.addFlashAttribute("resDate", voList.get(0).getResDate());
        rttr.addFlashAttribute("sno", voList.get(0).getSno());
        rttr.addFlashAttribute("voList", voList);
        rttr.addFlashAttribute("onlyDate", onlyDate);
        rttr.addFlashAttribute("result", "예약 되었습니다");
		return "redirect:/readingRoom/";
	}

	@PostMapping("/cancel")
	public String cancel(@ModelAttribute ReadingRoomVO roomVO,@RequestParam("onlyDate")String onlyDate, RedirectAttributes rttr) {
		readingRoomService.resCancel(roomVO);
		
		List<ReadingRoomVO> voList = readingRoomService.getByDate(roomVO.getResDate());
		rttr.addFlashAttribute("resDate", voList.get(0).getResDate());
		rttr.addFlashAttribute("sno", voList.get(0).getSno());
		rttr.addFlashAttribute("voList", voList);
		rttr.addFlashAttribute("onlyDate", onlyDate);
		rttr.addFlashAttribute("result", "예약이 취소되었습니다");
		return "redirect:/readingRoom/";
	}
}
