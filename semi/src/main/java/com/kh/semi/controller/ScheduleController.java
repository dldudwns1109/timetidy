package com.kh.semi.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.semi.dao.MemberDao;
import com.kh.semi.dto.MemberDto;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {
	
	@Autowired
	private MemberDao memberDao;
	
	@GetMapping("")
	public String schedule(@AuthenticationPrincipal OAuth2User oAuth2User,
			Model model, HttpSession session) throws IOException {
		String email = (String) session.getAttribute("email");
		MemberDto findMember = memberDao.checkMember(email);
		model.addAttribute("name", findMember.getMemberName());
		model.addAttribute("picture", findMember.getMemberProfile());
		return "/WEB-INF/views/schedule/main.jsp";
	}
}
