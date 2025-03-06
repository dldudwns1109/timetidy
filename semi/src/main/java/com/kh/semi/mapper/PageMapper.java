package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.dto.PageDto;

@Component
public class PageMapper implements RowMapper<PageDto> {
	
	@Override
	public PageDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return PageDto.builder()
				.pageId(rs.getInt("page_id"))
				.pageMemberId(rs.getInt("page_member_id"))
				.pageTitle(rs.getString("page_title"))
				.pageCreatedTime(rs.getTimestamp("page_created_time"))
				.build();
	}
}
