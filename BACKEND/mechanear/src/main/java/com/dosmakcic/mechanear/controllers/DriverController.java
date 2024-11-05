package com.dosmakcic.mechanear.controllers;

import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;

import com.dosmakcic.mechanear.models.Driver;
import com.dosmakcic.mechanear.services.DriverService;


@RestController
@RequestMapping("/driver")
public class DriverController {

    @Autowired
    private DriverService driverService;

    @PostMapping("/register")
    public Driver registerDriver(@RequestBody Driver driver) {
        return driverService.saveDriver(driver);
    }

    @GetMapping("/{id}")
    public Driver getDriver(@PathVariable Long id) {
        return driverService.getDriverById(id).orElse(null);
    }

    

}
