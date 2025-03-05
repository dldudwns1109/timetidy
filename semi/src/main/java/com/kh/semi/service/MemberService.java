package com.kh.semi.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.semi.dao.MemberDao;
import com.kh.semi.dto.MemberDto;

@Service
public class MemberService {

	@Autowired
	private MemberDao memberDao;
	
	public int addMember(MemberDto memberDto) {
		MemberDto findMember = memberDao.checkMember(
				memberDto.getMemberEmail());
    	if (findMember == null) {
    		int memberId = memberDao.sequence();
    		memberDto.setMemberId(memberId);
    		memberDao.insert(memberDto);
    		return memberId;
    	}
    	
    	return findMember.getMemberId();
	}
}
