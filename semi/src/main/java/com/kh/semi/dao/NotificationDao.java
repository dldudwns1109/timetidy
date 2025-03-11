package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.NotificationDto;
import com.kh.semi.mapper.NotificationMapper;

@Repository
public class NotificationDao {

	@Autowired
	private NotificationMapper notificationMapper;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public int sequence() {
		String sql = "select notification_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	public void insert(NotificationDto notificationDto) {
		String sql = "insert into notification ("
				+ "notification_id, notification_sender_id, "
				+ "notification_receiver_id, notification_message"
				+ ") values (?, ?, ?, ?)";
		Object[] data = {
				notificationDto.getNotificationId(),
				notificationDto.getNotificationSenderId(),
				notificationDto.getNotificationReceiverId(),
				notificationDto.getNotificationMessage()
		};
		jdbcTemplate.update(sql, data);
	}
	
	public List<NotificationDto> list(int receiverId) {
		String sql = "select * from notification "
				+ "where notification_receiver_id = ? "
				+ "order by notification_created_time desc";
		Object[] data = {receiverId};
		return jdbcTemplate.query(sql, notificationMapper, data);
	}
}
