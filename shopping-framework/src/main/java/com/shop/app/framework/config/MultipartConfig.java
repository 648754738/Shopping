package com.shop.app.framework.config;

import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.unit.DataSize;

import javax.servlet.MultipartConfigElement;

/**
 * 文件上传配置
 * 
 * @author ruoyi
 */
@Configuration
public class MultipartConfig {

    @Bean
    public MultipartConfigElement multipartConfigElement() {
        MultipartConfigFactory factory = new MultipartConfigFactory();
        // 单个文件大小限制
        factory.setMaxFileSize(DataSize.ofMegabytes(50));
        // 总上传文件大小限制
        factory.setMaxRequestSize(DataSize.ofMegabytes(100));
        // 设置文件数量限制（如果支持）
        try {
            // 注意：Spring Boot 2.5.x可能不支持这个属性
            // factory.setMaxFileCount(100);
        } catch (Exception e) {
            // 忽略不支持的属性
        }
        return factory.createMultipartConfig();
    }
}