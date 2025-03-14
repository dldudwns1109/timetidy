package com.kh.semi.dao;

import java.util.List;

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
	
	public Integer existParticiapantId(int jobId, int participantNum) {
		String sql = "select job_participant#1_id from job "
				+ "where job_id = ?";
		sql = sql.replace("#1", String.valueOf(participantNum));
		Object[] data = {jobId};
		return jdbcTemplate.queryForObject(sql, Integer.class, data);
	}
	
	public boolean updateParticipantId(JobDto jobDto, int participantNum) {
		String sql = "update job "
				+ "set job_participant#1_id = ? "
				+ "where job_id = ?";
		sql = sql.replace("#1", String.valueOf(participantNum));
		Object[] data = {
				jobDto.getJobParticipant1Id(),
				jobDto.getJobId()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	public List<JobDto> list(int pageId) {
		String sql = "select * from job "
				+ "where job_page_id = ?";
		Object[] data = {pageId};
		return jdbcTemplate.query(sql, jobMapper, data);
	}
	
	public List<JobDto> hostList(int hostId) {
		String sql = "select * from job "
				+ "where job_host_id = ?";
		Object[] data = {hostId};
		return jdbcTemplate.query(sql, jobMapper, data);
	}
	
	public List<JobDto> participantList(int socialId) {
		String sql = "select * from job "
				+ "where job_participant1_id = ? "
				+ "or job_participant2_id = ? "
				+ "or job_participant3_id = ?";
		Object[] data = {socialId, socialId, socialId};
		return jdbcTemplate.query(sql, jobMapper, data);
	}
}
