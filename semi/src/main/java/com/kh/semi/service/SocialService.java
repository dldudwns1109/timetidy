package com.kh.semi.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.semi.dao.SocialDao;
import com.kh.semi.dto.SocialDto;

@Service
public class SocialService {

	@Autowired
	private SocialDao socialDao;
	
	public void deleteSocial(int selfId, int relativeId) {
		SocialDto socialDto = new SocialDto();
		socialDto.setSocialSelfId(selfId);
		socialDto.setSocialRelativeId(relativeId);
		socialDao.deleteRelative(socialDto);
	}
}
