package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.dto.JobDto;

@Component
public class JobMapper implements RowMapper<JobDto> {
	
	@Override
	public JobDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return JobDto.builder()
				.jobId(rs.getInt("job_id"))
				.jobPageId(rs.getInt("job_page_id"))
				.jobTitle(rs.getString("job_title"))
				.jobHostId(rs.getInt("job_host_id"))
				.jobParticipant1Id((Integer) rs.getObject("job_participant1_id"))
				.jobParticipant2Id((Integer) rs.getObject("job_participant2_id"))
				.jobParticipant3Id((Integer) rs.getObject("job_participant3_id"))
				.jobStartTime(rs.getTimestamp("job_start_time"))
				.jobEndTime(rs.getTimestamp("job_end_time"))
				.jobPlace(rs.getString("job_place"))
				.jobDescription(rs.getString("job_description"))
				.build();
	}
}
