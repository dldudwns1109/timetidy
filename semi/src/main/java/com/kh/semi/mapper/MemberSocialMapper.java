package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.dto.MemberSocialDto;

@Component
public class MemberSocialMapper implements RowMapper<MemberSocialDto> {
	
	@Override
	public MemberSocialDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return MemberSocialDto.builder()
				.memberId(rs.getInt("member_id"))
				.memberName(rs.getString("member_name"))
				.memberProfile(rs.getString("member_profile"))
				.memberEmail(rs.getString("member_email"))
				.socialSelfId(rs.getInt("social_self_id"))
				.socialPendingState(rs.getString("social_pending_state"))
				.build();
	}
}
