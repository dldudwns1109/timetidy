package com.kh.semi.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.semi.dao.NotificationDao;
import com.kh.semi.dto.NotificationDto;

@Service
public class NotificationService {

	@Autowired
	private NotificationDao notificationDao;
	
	public void deleteNotification(int senderId, int receiverId) {
		NotificationDto notificationDto = new NotificationDto();
		notificationDto.setNotificationSenderId(senderId);
		notificationDto.setNotificationReceiverId(receiverId);
		notificationDao.delete(notificationDto);
	}
}
