package com.kh.semi.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.JobDao;
import com.kh.semi.dao.MemberDao;
import com.kh.semi.dao.NotificationDao;
import com.kh.semi.dao.SocialDao;
import com.kh.semi.dto.JobDto;
import com.kh.semi.dto.MemberDto;
import com.kh.semi.dto.NotificationDto;
import com.kh.semi.dto.SocialDto;
import com.kh.semi.service.NotificationService;
import com.kh.semi.service.SocialService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/rest/notification")
public class NotificationRestController {
	
	@Autowired
	private NotificationDao notificationDao;
	
	@Autowired
	private SocialDao socialDao;
	
	@Autowired
	private JobDao jobDao;
	
	@Autowired
	private NotificationService notificationService;
	
	@Autowired
	private SocialService socialService;
	
	@PostMapping("/add")
	public void add(@RequestParam int receiverId, HttpSession session) {
		int selfId = (int) session.getAttribute("id");
		NotificationDto notificationDto = new NotificationDto();
		notificationDto.setNotificationId(notificationDao.sequence());
		notificationDto.setNotificationJobId(null);
		notificationDto.setNotificationSenderId(selfId);
		notificationDto.setNotificationReceiverId(receiverId);
		notificationDto.setNotificationMessage("님이 친구 추가를 요청하셨습니다. 수락하시겠습니까?");
		notificationDao.insert(notificationDto);
		
		socialService.addSocial(selfId, receiverId, true);
	}
	
	@PostMapping("/accept")
	public void accept(@RequestParam int senderId, HttpSession session) {
		int selfId = (int) session.getAttribute("id");
		notificationService.deleteNotification(senderId, selfId);
		notificationService.deleteNotification(selfId, senderId);
		
		socialDao.update(senderId);
		socialService.addSocial(selfId, senderId, false);
	}
	
	@PostMapping("/accept-date")
	public void acceptDate(@RequestParam int senderId,
							@RequestParam int jobId, HttpSession session) {
		int selfId = (int) session.getAttribute("id");
		NotificationDto notificationDto = new NotificationDto();
		notificationDto.setNotificationJobId(jobId);
		notificationDto.setNotificationSenderId(senderId);
		notificationDto.setNotificationReceiverId(selfId);
		notificationDao.deleteJob(notificationDto);
		
		SocialDto socialDto = new SocialDto();
		socialDto.setSocialSelfId(senderId);
		socialDto.setSocialRelativeId(selfId);
		SocialDto findSocialDto = socialDao.findSocialDetail(socialDto);
		for (int i = 1; i <= 3; i++) {
			if (jobDao.existParticiapantId(jobId, i) == null) {
				JobDto jobDto = new JobDto();
				jobDto.setJobId(jobId);
				jobDto.setJobParticipant1Id((Integer) findSocialDto.getSocialId());
				jobDao.updateParticipantId(jobDto, i);
				break;
			}
		}
	}
	
	@PostMapping("/reject")
	public void reject(@RequestParam int senderId, HttpSession session) {
		NotificationDto notificationDto = new NotificationDto();
		notificationDto.setNotificationSenderId(senderId);
		notificationDto.setNotificationReceiverId((int) session.getAttribute("id"));
		notificationDao.delete(notificationDto);
		
		socialDao.delete(senderId);
	}
	
	@GetMapping("/list")
	public List<NotificationDto> list(HttpSession session) {
		return notificationDao.list((int) session.getAttribute("id"));
	}
}
