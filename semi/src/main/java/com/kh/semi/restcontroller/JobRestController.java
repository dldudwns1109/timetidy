package com.kh.semi.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.JobDao;
import com.kh.semi.dao.NotificationDao;
import com.kh.semi.dto.JobDto;
import com.kh.semi.dto.NotificationDto;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/rest/job")
public class JobRestController {
	
	@Autowired
	private NotificationDao notificationDao;
	
	@Autowired
	private JobDao jobDao;
	
	@PostMapping("/add")
	public JobDto add(@ModelAttribute JobDto jobDto, HttpSession session) {
		List<Integer> jobParticipantsId = List.of(
				jobDto.getJobParticipant1Id() == null 
					? -1 : jobDto.getJobParticipant1Id(),
				jobDto.getJobParticipant2Id() == null 
					? -1 : jobDto.getJobParticipant2Id(),
				jobDto.getJobParticipant3Id() == null 
					? -1 : jobDto.getJobParticipant3Id()
		);
		int jobId = jobDao.sequence();
		jobDto.setJobId(jobId);
		jobDto.setJobHostId((int) session.getAttribute("id"));
		jobDto.setJobParticipant1Id(null);
		jobDto.setJobParticipant2Id(null);
		jobDto.setJobParticipant3Id(null);
		jobDao.insert(jobDto);
		
		for (Integer jobParticipantId : jobParticipantsId) {
			if (jobParticipantId < 0) break;
			NotificationDto notificationDto = new NotificationDto();
			notificationDto.setNotificationId(notificationDao.sequence());
			notificationDto.setNotificationJobId(Integer.valueOf(jobId));
			notificationDto.setNotificationSenderId((int) session.getAttribute("id"));
			notificationDto.setNotificationReceiverId(jobParticipantId);
			notificationDto.setNotificationMessage("님이 일정에 초대했습니다. 일정을 수락하시겠습니까?");
			notificationDao.insert(notificationDto);
		}
		
		return jobDto;
	}
	
	@GetMapping("/list")
	public List<JobDto> list(@RequestParam int pageId) {
		return jobDao.list(pageId);
	}
}
