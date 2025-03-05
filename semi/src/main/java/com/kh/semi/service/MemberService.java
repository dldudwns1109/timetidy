package com.kh.semi.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.semi.dao.MemberDao;
import com.kh.semi.dto.MemberDto;

@Service
public class MemberService {

	@Autowired
	private MemberDao memberDao;
	
	public void addMember(MemberDto memberDto) {
		MemberDto findMember = memberDao.checkMember(
				memberDto.getMemberEmail());
    	if (findMember == null) {
    		memberDao.insert(memberDto);            		
    	}
	}
}
