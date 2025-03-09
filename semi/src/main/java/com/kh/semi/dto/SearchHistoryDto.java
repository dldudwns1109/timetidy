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
public class SearchHistoryDto {
	private int searchHistoryId;
	private int searchHistoryMemberId;
	private String searchHistoryKeyword;
	private Timestamp searchHistoryCreatedTime;
}
