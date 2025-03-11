package com.kh.semi.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SocialDto {
	private int socialId;
	private int socialSelfId;
	private int socialRelativeId;
	private String socialName;
	private String socialProfile;
	private String socialEmail;
	private String socialPendingState;
}
