package com.kh.semi.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.web.SecurityFilterChain;

import com.kh.semi.dto.MemberDto;
import com.kh.semi.service.MemberService;

import jakarta.servlet.http.HttpSession;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	
	@Autowired
	private MemberService memberService;

    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		http
        .authorizeHttpRequests(auth -> auth
            .requestMatchers("/**").permitAll()
            .anyRequest().authenticated()
        )
        .oauth2Login(oauth2 -> oauth2
            .loginPage("/login")
            .defaultSuccessUrl("/schedule", true)
            .successHandler((request, response, authentication) -> {
            	OAuth2AuthenticationToken oauthToken = (OAuth2AuthenticationToken) authentication;
            	
            	String name = oauthToken.getPrincipal().getAttribute("name");
            	String profile = oauthToken.getPrincipal().getAttribute("picture");
            	String email = oauthToken.getPrincipal().getAttribute("email");
            	
            	MemberDto memberDto = new MemberDto();
            	memberDto.setMemberName(name);
            	memberDto.setMemberProfile(profile);
            	memberDto.setMemberEmail(email);
            	int id = memberService.addMember(memberDto);
            	
            	HttpSession session = request.getSession();
            	session.setAttribute("id", id);
            	session.setAttribute("email", email);
            	
            	response.sendRedirect("/schedule");
            })
        )
        .logout(logout -> logout
            .logoutSuccessUrl("/login")
        );
		
		return http.build();
	}
}
