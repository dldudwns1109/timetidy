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
	
	public boolean update(MemberDto memberDto) {
		String sql = "update member "
				+ "set member_name = ? "
				+ "where member_id = ? ";
		Object[] data = {
				memberDto.getMemberName(),
				memberDto.getMemberId()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	public boolean delete(int memberId) {
		String sql = "delete member where member_id = ?";
		Object[] data = {memberId};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	public MemberDto checkMember(String memberEmail) {
		String sql = "select * from member "
				+ "where member_email = ?";
		Object[] data = {memberEmail};
		List<MemberDto> findMember = jdbcTemplate.query(sql, memberMapper, data);
		return findMember.isEmpty() ? null : findMember.get(0);
	}
	
	public MemberDto findMember(String memberId) {
		String sql = "select * from member "
				+ "where member_id = ?";
		Object[] data = {memberId};
		List<MemberDto> findMember = jdbcTemplate.query(sql, memberMapper, data);
		return findMember.isEmpty() ? null : findMember.get(0);
	}
}
