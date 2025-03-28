package com.kh.semi.configuration;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.semi.interceptor.MemberLoginInterceptor;
import com.kh.semi.interceptor.PageReadInterceptor;

@Configuration
public class InterceptorConfig implements WebMvcConfigurer {
	
	@Autowired
	private MemberLoginInterceptor memberLoginInterceptor;
	
	@Autowired
	private PageReadInterceptor pageReadInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(memberLoginInterceptor)
				.addPathPatterns(List.of(
						"/schedule/**"
				));
		
		registry.addInterceptor(pageReadInterceptor)
				.addPathPatterns("/schedule/{pageId:[0-9]+}");
	}
}
