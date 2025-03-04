package com.kh.semi.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
@ConfigurationProperties(prefix = "spring.security.oauth2.client.registration.google")
public class GoogleOAuthProperties {
	private String clientId;
	private String clientSecret;
	private String redirectUri;
	private String scope;
}
