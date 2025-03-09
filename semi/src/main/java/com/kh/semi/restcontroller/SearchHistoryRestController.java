package com.kh.semi.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.SearchHistoryDao;
import com.kh.semi.dto.SearchHistoryDto;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/rest/search")
public class SearchHistoryRestController {
	
	@Autowired
	private SearchHistoryDao searchHistoryDao;
	
	@PostMapping("/add")
	public String add(@RequestParam String keyword, HttpSession session) {
		SearchHistoryDto searchHistoryDto = new SearchHistoryDto();
		searchHistoryDto.setSearchHistoryId(searchHistoryDao.sequence());
		searchHistoryDto.setSearchHistoryMemberId((int) session.getAttribute("id"));
		searchHistoryDto.setSearchHistoryKeyword(keyword);
		if (searchHistoryDao.detail(searchHistoryDto) == null) {
			searchHistoryDao.insert(searchHistoryDto);			
		} else {
			searchHistoryDao.updateCreatedTime(searchHistoryDto);
		}
		return keyword;
	}
	
	@PostMapping("/delete")
	public String delete(@RequestParam String keyword, HttpSession session) {
		SearchHistoryDto searchHistoryDto = new SearchHistoryDto();
		searchHistoryDto.setSearchHistoryMemberId((int) session.getAttribute("id"));
		searchHistoryDto.setSearchHistoryKeyword(keyword);
		searchHistoryDao.delete(searchHistoryDto);
		return keyword;
	}
	
	@GetMapping("/list")
	public List<SearchHistoryDto> list(HttpSession session) {
		return searchHistoryDao.list(
				(int) session.getAttribute("id"));
	}
}
