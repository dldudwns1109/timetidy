package com.kh.semi.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.semi.dao.PageDao;
import com.kh.semi.dto.PageDto;
import com.kh.semi.exception.NoAuthorizationException;
import com.kh.semi.exception.NotFoundException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class PageReadInterceptor implements HandlerInterceptor {

	@Autowired
	private PageDao pageDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String requestURI = request.getRequestURI();
		
		String[] parts = requestURI.split("/");
		if (parts.length > 2) {
			int currPageId = Integer.parseInt(parts[2]);
			int memberId = (int) request.getSession()
											.getAttribute("id");
			
			if (pageDao.detail(currPageId) == null) {
				throw new NotFoundException();
			}
			
			for (PageDto pageDto : pageDao.list(memberId)) {
				if (pageDto.getPageId() == currPageId) {
					return true;
				}
			}
		}
		
		throw new NoAuthorizationException();
	}
}
