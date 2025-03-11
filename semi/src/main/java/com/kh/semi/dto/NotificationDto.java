package com.kh.semi.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NotificationDto {
	private int notificationId;
	private Integer notificationJobId;
	private int notificationSenderId;
	private int notificationReceiverId;
	private String notificationMessage;
	private Timestamp notificationCreatedTime;
}
