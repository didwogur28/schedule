package com.schedule.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

@Configuration
public class ApplicationConfig extends WebMvcConfigurationSupport {

	@Override
	public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
		configurer.ignoreUnknownPathExtensions(false).defaultContentType(MediaType.TEXT_HTML);
		
		configurer
			.defaultContentType(MediaType.APPLICATION_JSON)
			.mediaType("html", MediaType.TEXT_HTML)
			.mediaType("json", MediaType.APPLICATION_JSON)
			.mediaType("xml", MediaType.APPLICATION_XML);
		super.configureContentNegotiation(configurer);
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry
			.addResourceHandler("/resources/**")
	      	.addResourceLocations("/resources/");

		registry
			.addResourceHandler("/plugins/**")
			.addResourceLocations("/resources/plugins/");

		registry
			.addResourceHandler("/dist/**")
			.addResourceLocations("/resources/dist/");
	}
	
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		MappingJackson2JsonView jsonView = new MappingJackson2JsonView();
		jsonView.setPrettyPrint(true);
		registry.enableContentNegotiation(jsonView);
		registry.jsp("/WEB-INF/views/", ".jsp");
	}

}
