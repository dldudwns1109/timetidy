package com.kh.semi.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.PageDao;
import com.kh.semi.dto.PageDto;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/rest/page")
public class PageRestController {
	
	@Autowired
	private PageDao pageDao;

	@PostMapping("/add")
	public PageDto add(HttpSession session) {
		int pageId = pageDao.sequence();
		int memberId = (int) session.getAttribute("id");
		
		PageDto pageDto = new PageDto();
		pageDto.setPageId(pageId);
		pageDto.setPageMemberId(memberId);
		pageDto.setPageTitle("빈 페이지");
		pageDao.insert(pageDto);
		
		return pageDto;
	}
	
	@PostMapping("/updateTitle")
	public String updateTitle(@ModelAttribute PageDto pageDto) {
		pageDao.updateTitle(pageDto);
		return pageDto.getPageTitle();
	}
	
	@PostMapping("/delete")
	public int delete(@RequestParam int pageId) {
		pageDao.delete(pageId);
		return pageId;
	}
	
	@GetMapping("/list")
	public List<PageDto> list(HttpSession session) {
		int memberId = (int) session.getAttribute("id");
		return pageDao.list(memberId);
	}
}
