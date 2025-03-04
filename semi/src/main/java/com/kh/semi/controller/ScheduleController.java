package com.kh.semi.controller;

import java.io.IOException;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {
	
	@GetMapping("")
	public String schedule(@AuthenticationPrincipal OAuth2User oAuth2User,
			Model model, HttpSession session) throws IOException {
		model.addAttribute("name", oAuth2User.getAttribute("name"));
		model.addAttribute("email", oAuth2User.getAttribute("email"));
		model.addAttribute("picture", oAuth2User.getAttribute("picture"));
		return "/WEB-INF/views/schedule/main.jsp";
	}
}
