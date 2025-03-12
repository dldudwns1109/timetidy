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
public class JobDto {
	private int jobId;
	private int jobPageId;
	private String jobTitle;
	private int jobHostId;
	private Integer jobParticipant1Id;
	private Integer jobParticipant2Id;
	private Integer jobParticipant3Id;
	private Timestamp jobStartTime;
	private Timestamp jobEndTime;
	private String jobPlace;
	private String jobDescription;
}
