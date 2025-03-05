package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.dto.MemberDto;

@Component
public class MemberMapper implements RowMapper<MemberDto> {
	
	@Override
	public MemberDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return MemberDto.builder()
				.memberId(rs.getInt("member_id"))
				.memberName(rs.getString("member_name"))
				.memberProfile(rs.getString("member_profile"))
				.memberEmail(rs.getString("member_email"))
				.build();
	}
}
