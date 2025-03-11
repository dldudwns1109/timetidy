package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.kh.semi.dto.SocialDto;

public class SocialMapper implements RowMapper<SocialDto> {

	@Override
	public SocialDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return SocialDto.builder()
				.socialId(rs.getInt("social_id"))
				.socialSelfId(rs.getInt("social_self_id"))
				.socialRelativeId(rs.getInt("social_relative_id"))
				.socialName(rs.getString("social_name"))
				.socialProfile(rs.getString("social_profile"))
				.socialEmail(rs.getString("social_email"))
				.socialPendingState(rs.getString("social_pending_state"))
				.build();
	}
}
