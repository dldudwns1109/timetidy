package com.kh.semi.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.PageDto;
import com.kh.semi.mapper.PageMapper;

@Repository
public class PageDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private PageMapper pageMapper;
	
	public int sequence() {
		String sql = "select page_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	public void insert(PageDto pageDto) {
		String sql = "insert into page ("
				+ "page_id, page_member_id"
				+ ") values (?, ?)";
		Object[] data = {
				pageDto.getPageId(),
				pageDto.getPageMemberId()
		};
		jdbcTemplate.update(sql, data);
	}
}
