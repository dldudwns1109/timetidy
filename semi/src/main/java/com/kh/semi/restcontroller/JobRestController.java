package com.kh.semi.restcontroller;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dto.JobDto;

@RestController
@RequestMapping("/rest/job")
public class JobRestController {
	
	@PostMapping("/add")
	public JobDto add(@ModelAttribute JobDto jobDto) {
		System.out.println("jobDto = " + jobDto);
		return jobDto;
	}
}
