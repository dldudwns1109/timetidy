package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.MemberDto;
import com.kh.semi.mapper.MemberMapper;

@Repository
public class MemberDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private MemberMapper memberMapper;
	
	public int sequence() {
		String sql = "select member_seq.nextval from member";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	public void insert(MemberDto memberDto) {
		String sql = "insert into member ("
				+ "member_id, member_name, "
				+ "member_profile, member_email"
				+ ") values(?, ?, ?, ?)";
		Object[] data = {
				memberDto.getMemberId(),
				memberDto.getMemberName(),
				memberDto.getMemberProfile(),
				memberDto.getMemberEmail()
		};
		jdbcTemplate.update(sql, data);
	}
	
	public MemberDto checkMember(String memberEmail) {
		String sql = "select * from member "
				+ "where member_email = ?";
		Object[] data = {memberEmail};
		List<MemberDto> findMember = jdbcTemplate.query(sql, memberMapper, data);
		return findMember.isEmpty() ? null : findMember.get(0);
	}
}
