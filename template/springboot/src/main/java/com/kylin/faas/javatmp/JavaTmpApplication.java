package com.kylin.faas.javatmp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@SpringBootApplication
public class JavaTmpApplication {
    @GetMapping("/**")
    public ResponseEntity<String> print() {

        return ResponseEntity.ok("aaaa");
    }

    public static void main(String[] args) {
        SpringApplication.run(JavaTmpApplication.class, args);
    }

}
