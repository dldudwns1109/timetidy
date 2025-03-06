package com.kh.semi.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	public int add(HttpSession session) {
		int pageId = pageDao.sequence();
		int memberId = (int) session.getAttribute("id");
		
		PageDto pageDto = new PageDto();
		pageDto.setPageId(pageId);
		pageDto.setPageMemberId(memberId);
		pageDao.insert(pageDto);
		
		return pageId;
	}
}
