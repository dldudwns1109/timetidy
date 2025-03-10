package com.kh.semi.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semi.dao.PageDao;
import com.kh.semi.service.MemberService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private PageDao pageDao;
	
	@GetMapping("")
	public String schedule(Model model, HttpSession session) throws IOException {
		model.addAttribute("name", memberService.loadSession(session)
											.getMemberName());
		model.addAttribute("picture", memberService.loadSession(session)
											.getMemberProfile());
		return "/WEB-INF/views/schedule/main.jsp";
	}
	
	@GetMapping("/{pageId}")
	public String detail(@PathVariable int pageId,
			Model model, HttpSession session) throws IOException {
		model.addAttribute("name", memberService.loadSession(session)
											.getMemberName());
		model.addAttribute("picture", memberService.loadSession(session)
											.getMemberProfile());
		model.addAttribute("pageDto", pageDao.detail(pageId));
		return "/WEB-INF/views/schedule/detail.jsp";
	}
	
	@GetMapping("/search")
	public String search(@RequestParam String query,
			Model model, HttpSession session) {
		model.addAttribute("name", memberService.loadSession(session)
				.getMemberName());
		model.addAttribute("picture", memberService.loadSession(session)
				.getMemberProfile());
		model.addAttribute("query", query);
		return "/WEB-INF/views/schedule/search.jsp";
	}
	
	@GetMapping("/social/list")
	public String socialList(Model model, HttpSession session) {
		model.addAttribute("name", memberService.loadSession(session)
				.getMemberName());
		model.addAttribute("picture", memberService.loadSession(session)
				.getMemberProfile());
		return "/WEB-INF/views/schedule/social/list.jsp";
	}
	
	@GetMapping("/social/add")
	public String socialAdd(Model model, HttpSession session) {
		model.addAttribute("name", memberService.loadSession(session)
				.getMemberName());
		model.addAttribute("picture", memberService.loadSession(session)
				.getMemberProfile());
		return "/WEB-INF/views/schedule/social/add.jsp";
	}
}
