package com.kh.semi.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.semi.exception.NoAuthorizationException;
import com.kh.semi.exception.NotFoundException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class MemberLoginInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String email = (String) request.getSession().getAttribute("email");
		if (email == null) {
			response.sendRedirect("/login");
			throw new NotFoundException();
		}

        return true;
	}
}
