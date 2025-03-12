package com.kh.semi.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
@ConfigurationProperties(prefix = "kakaomap")
public class KakaomapAppkeyProperties {
	private String appkey;
}
