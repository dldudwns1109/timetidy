package com.kh.semi.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberSocialDto {
	private int memberId;
	private String memberName;
	private String memberProfile;
	private String memberEmail;
	private int socialSelfId;
	private String socialPendingState;
}
