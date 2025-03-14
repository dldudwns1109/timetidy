package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.SearchHistoryDto;
import com.kh.semi.mapper.SearchHistoryMapper;

@Repository
public class SearchHistoryDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private SearchHistoryMapper searchHistoryMapper;
	
	public int sequence() {
		String sql = "select search_history_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	public void insert(SearchHistoryDto searchHistoryDto) {
		String sql = "insert into search_history ("
				+ "search_history_id, search_history_member_id, "
				+ "search_history_keyword"
				+ ") values(?, ?, ?)";
		Object[] data = {
				searchHistoryDto.getSearchHistoryId(),
				searchHistoryDto.getSearchHistoryMemberId(),
				searchHistoryDto.getSearchHistoryKeyword()
		};
		jdbcTemplate.update(sql, data);
	}
	
	public boolean updateCreatedTime(SearchHistoryDto searchHistoryDto) {
		String sql = "update search_history "
				+ "set search_history_created_time = systimestamp "
				+ "where search_history_keyword = ? "
				+ "and search_history_member_id = ?";
		Object[] data = {
				searchHistoryDto.getSearchHistoryKeyword(),
				searchHistoryDto.getSearchHistoryMemberId()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	public boolean delete(SearchHistoryDto searchHistoryDto) {
		String sql = "delete search_history "
				+ "where search_history_keyword = ? "
				+ "and search_history_member_id = ?";
		Object[] data = {
				searchHistoryDto.getSearchHistoryKeyword(),
				searchHistoryDto.getSearchHistoryMemberId()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	public SearchHistoryDto detail(SearchHistoryDto searchHistoryDto) {
		String sql = "select * from search_history "
				+ "where search_history_keyword = ? "
				+ "and search_history_member_id = ?";
		Object[] data = {
				searchHistoryDto.getSearchHistoryKeyword(),
				searchHistoryDto.getSearchHistoryMemberId()
		};
		List<SearchHistoryDto> list = jdbcTemplate.query(sql, searchHistoryMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	public List<SearchHistoryDto> list(int memberId) {
		String sql = "select * from search_history "
				+ "where search_history_member_id = ? "
				+ "order by search_history_created_time desc";
		Object[] data = {memberId};
		return jdbcTemplate.query(sql, searchHistoryMapper, data);
	}
}
