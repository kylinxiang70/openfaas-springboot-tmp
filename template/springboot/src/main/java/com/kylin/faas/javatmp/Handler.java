package com.kylin.faas.javatmp;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Handler {
    @GetMapping("/**")
    public ResponseEntity<String> print() {

        return ResponseEntity.ok("aaaa");
    }
}
