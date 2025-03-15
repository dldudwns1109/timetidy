package com.kh.semi.interceptor;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.kh.semi.exception.NoAuthorizationException;
import com.kh.semi.exception.NotFoundException;

@ControllerAdvice(annotations = {Controller.class})
public class ExceptionControllerAdvice {
	
	@ExceptionHandler(NotFoundException.class)
	public String notFound(NotFoundException e) {
		return "/WEB-INF/views/exception/not-found.jsp";
	}
	
	@ExceptionHandler(NoAuthorizationException.class)
	public String noAuthorization(NoAuthorizationException e) {
		return "/WEB-INF/views/exception/no-authorization.jsp";
	}
}
