package com.kh.semi.interceptor;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class MemberLoginInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
				OAuth2AuthenticationToken authenticationToken = 
		                (OAuth2AuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
		        
		        if (authenticationToken == null) {
		            response.sendRedirect("/login");
		            return false;
		        }
		        
		        OAuth2User oAuth2User = (OAuth2User) authenticationToken.getPrincipal();
		        
		        if (oAuth2User == null) {
		            response.sendRedirect("/login");
		            return false;
		        }
		        
		        HttpSession session = request.getSession();
		        session.setAttribute("email", oAuth2User.getAttribute("email"));
		        
		        String email = (String) session.getAttribute("email");
		        if (email == null) {
		            response.sendRedirect("/login");
		            return false;
		        }
		        
		        return true;
	}
}
