package org.ivanzamanov.microstarter;

import org.springframework.boot.SpringApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

public class MicrostarterExample {

    @RequestMapping("/")
    @ResponseBody
    public String hello() {
        return "hello";
    }

    public static void main(String[] args) {
        SpringApplication.run(MicrostarterExample.class, args);
    }
}
