package com.kh.semi.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.SocialDao;
import com.kh.semi.dto.MemberSocialDto;
import com.kh.semi.dto.SocialDto;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/rest/social")
public class SocialRestController {
	
	@Autowired
	private SocialDao socialDao;
	
	@GetMapping("/delete")
	public int delete(@RequestParam int relativeId, HttpSession session) {
		SocialDto socialDto = new SocialDto();
		socialDto.setSocialSelfId((int) session.getAttribute("id"));
		socialDto.setSocialRelativeId(relativeId);
		socialDao.deleteRelative(socialDto);
		socialDto.setSocialSelfId(relativeId);
		socialDto.setSocialRelativeId((int) session.getAttribute("id"));
		socialDao.deleteRelative(socialDto);
		return relativeId;
	}
	
	@GetMapping("/list")
	public List<SocialDto> list(HttpSession session) {
		return socialDao.socialList((int) session.getAttribute("id"));
	}
	
	@GetMapping("/search-list")
	public List<SocialDto> searchList(@RequestParam String keyword, HttpSession session) {
		SocialDto socialDto = new SocialDto();
		socialDto.setSocialName(keyword);
		socialDto.setSocialSelfId((int) session.getAttribute("id"));
		return socialDao.socialSearchList(socialDto);
	}
	
	@GetMapping("/member-list")
	public List<MemberSocialDto> memberList(@RequestParam String keyword, 
			HttpSession session) {
		MemberSocialDto memberSocialDto = new MemberSocialDto();
		memberSocialDto.setMemberName(keyword);
		memberSocialDto.setSocialSelfId((int) session.getAttribute("id"));
		return socialDao.searchMemberList(memberSocialDto);
	}
}
