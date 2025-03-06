package com.kh.semi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	
	@GetMapping("/")
	public String main() {
		return "/WEB-INF/views/main.jsp";
	}
	
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/login.jsp";
	}
	
	@GetMapping("/loading")
	public String loading() {
		return "/WEB-INF/views/loading.jsp";
	}
}
