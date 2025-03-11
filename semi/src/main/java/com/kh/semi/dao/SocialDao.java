package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.MemberSocialDto;
import com.kh.semi.dto.SocialDto;
import com.kh.semi.mapper.MemberSocialMapper;

@Repository
public class SocialDao {
	
	@Autowired
	private MemberSocialMapper memberSocialMapper;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public int sequence() {
		String sql = "select social_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	public void insert(SocialDto socialDto) {
		String sql = "insert into social ("
				+ "social_id, social_self_id, social_relative_id, "
				+ "social_name, social_profile, social_email, social_pending_state"
				+ ") values(?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {
				socialDto.getSocialId(),
				socialDto.getSocialSelfId(),
				socialDto.getSocialRelativeId(),
				socialDto.getSocialName(),
				socialDto.getSocialProfile(),
				socialDto.getSocialEmail(),
				socialDto.getSocialPendingState()
		};
		jdbcTemplate.update(sql, data);
	}
	
	public boolean update(int senderId) {
		String sql = "update social "
				+ "set social_pending_state = 'n'"
				+ "where social_self_id = ?";
		Object[] data = {senderId};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	public boolean delete(int senderId) {
		String sql = "delete social "
				+ "where social_self_id = ?";
		Object[] data = {senderId};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	public List<MemberSocialDto> searchMemberList(MemberSocialDto memberSocialDto) {
		String sql = "select * from member_social "
				+ "where instr(member_name, ?) > 0 "
				+ "and social_self_id = ? "
				+ "and (social_pending_state is null "
				+ "or social_pending_state = 'y')";
		Object[] data = {
				memberSocialDto.getMemberName(),
				memberSocialDto.getSocialSelfId()
		};
		return jdbcTemplate.query(sql, memberSocialMapper, data);
	}
}
