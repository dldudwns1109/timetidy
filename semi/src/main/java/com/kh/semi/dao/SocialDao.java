package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.MemberSocialDto;
import com.kh.semi.mapper.MemberSocialMapper;

@Repository
public class SocialDao {
	
	@Autowired
	private MemberSocialMapper memberSocialMapper;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public List<MemberSocialDto> searchMemberList(MemberSocialDto memberSocialDto) {
		String sql = "select * from member_social "
				+ "where instr(member_name, ?) > 0 "
				+ "and social_self_id = ?";
		Object[] data = {
				memberSocialDto.getMemberName(),
				memberSocialDto.getSocialSelfId()
		};
		return jdbcTemplate.query(sql, memberSocialMapper, data);
	}
}
