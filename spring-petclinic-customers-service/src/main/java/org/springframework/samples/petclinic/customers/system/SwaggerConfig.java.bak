package org.springframework.samples.petclinic.customers.system;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Server;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Configuration
@EnableSwagger2
public class SwaggerConfig {
	
	@Bean
	public Docket api() {

		return new Docket(DocumentationType.OAS_30)
				.useDefaultResponseMessages(false)
				.select()
				.apis(RequestHandlerSelectors.basePackage("org.springframework.samples.petclinic"))
				.paths(PathSelectors.any())
				.build()
				.apiInfo(apiInfo());

	}

	private ApiInfo apiInfo() {
		String description = "Welcome PetClinic Swagger, https://github.com/euchungmsft/spring-petclinic-microservices";
		return new ApiInfoBuilder()
				.title("PetClinic Swagger")
				.description(description)
				.version("1.0")
				.build();
	}

}