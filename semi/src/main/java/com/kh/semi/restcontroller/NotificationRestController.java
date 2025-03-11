package com.kh.semi.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.MemberDao;
import com.kh.semi.dao.NotificationDao;
import com.kh.semi.dao.SocialDao;
import com.kh.semi.dto.MemberDto;
import com.kh.semi.dto.NotificationDto;
import com.kh.semi.dto.SocialDto;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/rest/notification")
public class NotificationRestController {
	
	@Autowired
	private NotificationDao notificationDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private SocialDao socialDao;
	
	@PostMapping("/add")
	public void add(@RequestParam int receiverId, HttpSession session) {
		NotificationDto notificationDto = new NotificationDto();
		notificationDto.setNotificationId(notificationDao.sequence());
		notificationDto.setNotificationSenderId((int) session.getAttribute("id"));
		notificationDto.setNotificationReceiverId(receiverId);
		notificationDto.setNotificationMessage("님이 친구 추가를 요청하셨습니다. 수락하시겠습니까?");
		notificationDao.insert(notificationDto);
		
		MemberDto memberDto = memberDao.findMember(receiverId);
		SocialDto socialDto = new SocialDto();
		socialDto.setSocialId(socialDao.sequence());
		socialDto.setSocialSelfId((int) session.getAttribute("id"));
		socialDto.setSocialRelativeId(receiverId);
		socialDto.setSocialName(memberDto.getMemberName());
		socialDto.setSocialProfile(memberDto.getMemberProfile());
		socialDto.setSocialEmail(memberDto.getMemberEmail());
		socialDto.setSocialPendingState("y");
		socialDao.insert(socialDto);
	}
}
