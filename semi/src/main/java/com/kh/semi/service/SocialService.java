package com.kh.semi.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.semi.dao.MemberDao;
import com.kh.semi.dao.SocialDao;
import com.kh.semi.dto.MemberDto;
import com.kh.semi.dto.SocialDto;

@Service
public class SocialService {

	@Autowired
	private SocialDao socialDao;
	
	@Autowired
	private MemberDao memberDao;
	
	public void addSocial(int selfId, int relativeId, boolean pendingState) {
		MemberDto memberDto = memberDao.findMember(relativeId);
		SocialDto socialDto = new SocialDto();
		socialDto.setSocialId(socialDao.sequence());
		socialDto.setSocialSelfId(selfId);
		socialDto.setSocialRelativeId(relativeId);
		socialDto.setSocialName(memberDto.getMemberName());
		socialDto.setSocialProfile(memberDto.getMemberProfile());
		socialDto.setSocialEmail(memberDto.getMemberEmail());
		socialDto.setSocialPendingState(pendingState ? "y" : "n");
		socialDao.insert(socialDto);
	}
	
	public void deleteSocial(int selfId, int relativeId) {
		SocialDto socialDto = new SocialDto();
		socialDto.setSocialSelfId(selfId);
		socialDto.setSocialRelativeId(relativeId);
		socialDao.deleteRelative(socialDto);
	}
}
