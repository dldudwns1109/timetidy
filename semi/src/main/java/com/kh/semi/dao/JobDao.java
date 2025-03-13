package com.kh.semi.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.JobDto;
import com.kh.semi.mapper.JobMapper;

@Repository
public class JobDao {

	@Autowired
	private JobMapper jobMapper;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public int sequence() {
		String sql = "select job_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	public void insert(JobDto jobDto) {
		String sql = "insert into job ("
				+ "job_id, job_page_id, "
				+ "job_title, job_host_id, "
				+ "job_start_time, job_end_time,"
				+ "job_place, job_description"
				+ ") values(?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {
				jobDto.getJobId(),
				jobDto.getJobPageId(),
				jobDto.getJobTitle(),
				jobDto.getJobHostId(),
				jobDto.getJobStartTime(),
				jobDto.getJobEndTime(),
				jobDto.getJobPlace(),
				jobDto.getJobDescription()
		};
		jdbcTemplate.update(sql, data);
	}
}
