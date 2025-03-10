package com.kh.semi.restcontroller;

import java.io.IOException;
import java.util.Enumeration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.MemberDao;
import com.kh.semi.dto.MemberDto;
import com.kh.semi.service.MemberService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/rest/member")
public class MemberRestController {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private MemberService memberService;
	
	@PostMapping("/edit")
	public String edit(@RequestParam String memberName,
			HttpSession session) {
		int id = (int) session.getAttribute("id");
		
		MemberDto memberDto = new MemberDto();
		memberDto.setMemberId(id);
		memberDto.setMemberName(memberName);
		memberDao.update(memberDto);
		return memberName;
	}
	
	@GetMapping("/logout")
	public void logout(HttpSession session) throws IOException {
        memberService.disconnectSession(session);
	}
	
	@GetMapping("/delete")
	public void delete(HttpSession session) {
		int id = (int) session.getAttribute("id");
		memberDao.delete(id);
		memberService.disconnectSession(session);
	}
}
