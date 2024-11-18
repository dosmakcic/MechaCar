package com.dosmakcic.mechanear.controllers;

import com.dosmakcic.mechanear.services.*;

import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;



@RestController
@RequestMapping("/auth")
@CrossOrigin
public class AuthController {


    @Autowired
    private AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<?> login (@RequestBody Map<String, String> credentials){
        String email = credentials.get("email");
        String password = credentials.get("password");

        Map<String, Object> result = authService.login(email, password);
        if (result == null) {
            return ResponseEntity.status(401).body("Invalid email or password");
        }

        return ResponseEntity.ok(result);
    }

    

}
