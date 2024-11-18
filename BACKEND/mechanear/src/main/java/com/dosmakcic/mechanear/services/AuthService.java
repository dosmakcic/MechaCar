package com.dosmakcic.mechanear.services;

import java.util.*;
import org.springframework.aop.aspectj.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dosmakcic.mechanear.models.*;
import com.dosmakcic.mechanear.repositories.DriverRepository;
import com.dosmakcic.mechanear.repositories.MechanicRepository;

@Service
public class AuthService{
    
    @Autowired
    private DriverRepository driverRepository;

    @Autowired
    private MechanicRepository mechanicRepository;

    public Map<String,Object> login(String email, String password){
        var mechanic= mechanicRepository.findByEmail(email);
        if(mechanic.isPresent() && mechanic.get().getPassword().equals(password)){
            Map<String,Object> response = new HashMap<>();
            response.put("type","mechanic");
            response.put("user", mechanic.get());
            response.put("id",mechanic.get().getId());
            return response;
        }
        var driver = driverRepository.findByEmail(email);
        if (driver.isPresent() && driver.get().getPassword().equals(password)) {
            Map<String, Object> response = new HashMap<>();
            response.put("type", "driver");
            response.put("user", driver.get());
            response.put("id", driver.get().getId());
            return response;
        }
        return null;
    }
}