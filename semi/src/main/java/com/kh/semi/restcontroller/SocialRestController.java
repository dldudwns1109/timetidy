package com.kh.semi.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.SocialDao;
import com.kh.semi.dto.MemberSocialDto;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/rest/social")
public class SocialRestController {
	
	@Autowired
	private SocialDao socialDao;
	
	@GetMapping("/member-list")
	public List<MemberSocialDto> memberList(@RequestParam String keyword, 
			HttpSession session) {
		MemberSocialDto memberSocialDto = new MemberSocialDto();
		memberSocialDto.setMemberName(keyword);
		memberSocialDto.setSocialSelfId((int) session.getAttribute("id"));
		return socialDao.searchMemberList(memberSocialDto);
	}
}
