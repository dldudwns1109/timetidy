package com.kh.semi.service;

import java.util.Enumeration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.semi.dao.MemberDao;
import com.kh.semi.dto.MemberDto;

import jakarta.servlet.http.HttpSession;

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
	
	public void disconnectSession(HttpSession session) {
		Enumeration<String> attributeNames = session.getAttributeNames();

        while (attributeNames.hasMoreElements()) {
            String attributeName = attributeNames.nextElement();
            session.removeAttribute(attributeName);
        }
	}
}
