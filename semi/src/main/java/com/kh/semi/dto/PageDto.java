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
public class PageDto {
	private int pageId;
	private int pageMemberId;
	private String pageTitle;
	private Timestamp pageCreatedTime;
}
