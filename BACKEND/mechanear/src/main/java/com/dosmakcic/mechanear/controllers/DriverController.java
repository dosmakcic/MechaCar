package com.dosmakcic.mechanear.controllers;

import org.springframework.web.bind.annotation.*;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;

import com.dosmakcic.mechanear.models.Driver;
import com.dosmakcic.mechanear.services.DriverService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;



@RestController
@RequestMapping("/driver")
@CrossOrigin
public class DriverController {

    @Autowired
    private DriverService driverService;

    @PostMapping("/register")
    public ResponseEntity<String> registerDriver(@RequestBody Driver driver) {
        if(driverService.emailExists(driver.getEmail())){
            return ResponseEntity.status(409).body("Email already exists");
        }
        driverService.saveDriver(driver);
        return ResponseEntity.ok("Driver registered successfully");
    }

    @GetMapping("/{id}")
    public Driver getDriver(@PathVariable Long id) {
        return driverService.getDriverById(id).orElse(null);
    }

    @GetMapping
    public List<Driver> getDrivers() {
        return driverService.getAllDrivers();
    }
    

    

}
