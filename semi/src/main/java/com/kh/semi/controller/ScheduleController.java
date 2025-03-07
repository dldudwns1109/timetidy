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

import com.kh.semi.dao.MemberDao;
import com.kh.semi.dao.PageDao;
import com.kh.semi.dto.MemberDto;
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
	public String schedule(@AuthenticationPrincipal OAuth2User oAuth2User,
			Model model, HttpSession session) throws IOException {
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
}
