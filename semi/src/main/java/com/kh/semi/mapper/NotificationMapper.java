package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.dto.NotificationDto;

@Component
public class NotificationMapper implements RowMapper<NotificationDto> {

	@Override
	public NotificationDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return NotificationDto.builder()
				.notificationId(rs.getInt("notification_id"))
				.notificationJobId(rs.getObject("notification_job_id") != null ? 
                        			rs.getInt("notification_job_id") : null)
				.notificationSenderId(rs.getInt("notification_sender_id"))
				.notificationReceiverId(rs.getInt("notification_receiver_id"))
				.notificationMessage(rs.getString("notification_message"))
				.notificationCreatedTime(rs.getTimestamp("notification_created_time"))
				.build();
	}
}
