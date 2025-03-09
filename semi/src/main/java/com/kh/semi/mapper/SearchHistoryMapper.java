package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.dto.SearchHistoryDto;

@Component
public class SearchHistoryMapper implements RowMapper<SearchHistoryDto> {
	
	@Override
	public SearchHistoryDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return SearchHistoryDto.builder()
				.searchHistoryId(rs.getInt("search_history_id"))
				.searchHistoryMemberId(rs.getInt("search_history_member_id"))
				.searchHistoryKeyword(rs.getString("search_history_keyword"))
				.searchHistoryCreatedTime(rs.getTimestamp("search_history_created_time"))
				.build();
	}
}
