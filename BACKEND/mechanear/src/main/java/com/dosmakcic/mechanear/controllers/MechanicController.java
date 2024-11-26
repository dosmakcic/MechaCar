package com.dosmakcic.mechanear.controllers;

import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.dosmakcic.mechanear.repositories.LocationRepository;
import com.dosmakcic.mechanear.services.*;
import com.dosmakcic.mechanear.models.*;



@RestController
@RequestMapping("/mechanics")
@CrossOrigin
public class MechanicController {
    @Autowired
    private MechanicService mechanicService;

    @Autowired
    private DriverService driverService;

     @Autowired
    private LocationRepository locationRepository;

    @PostMapping("/register")
    public ResponseEntity<String> registerMechanic(@RequestBody Mechanic mechanic) {
        if(mechanicService.emailExists(mechanic.getEmail())){
            return ResponseEntity.status(409).body("Email already exists");
        }
        if (mechanic.getLocation() != null) {
            Location location = locationRepository.findById(mechanic.getLocation().getId()).orElse(null);
            mechanic.setLocation(location);
        }
        mechanicService.saveMechanic(mechanic);
        return ResponseEntity.ok("Mechanic registered successfully");
    }

    @PostMapping("/request")
    public ResponseEntity<String> requestByDriver(@RequestBody Map<String,Long> request) {
        Long driverid=request.get("driverId");
        Long mechanicId= request.get("mechanicId");

        Optional<Mechanic> optionalMechanic= mechanicService.getMechanicById(mechanicId);

        if(optionalMechanic==null){
            ResponseEntity.status(404).body("Mechanic not found");
        }

        Optional<Driver> optionalDriver= driverService.getDriverById(driverid);

        if(optionalDriver==null){
            ResponseEntity.status(404).body("Driver not found");
        }
        
        Mechanic mechanic = optionalMechanic.get();
        Driver driver = optionalDriver.get();

        if (!mechanic.getChosenByDrivers().contains(driver)) {
        mechanic.getChosenByDrivers().add(driver);
        mechanicService.saveMechanic(mechanic);
        return ResponseEntity.ok("Request sent successfully");
    } else {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Driver already requested this mechanic");
    }
       
    }
    
    @GetMapping("/{id}")
    public Mechanic getMechanic(@PathVariable Long id) {
        return mechanicService.getMechanicById(id).orElse(null);
    }

    @GetMapping
    public List<Mechanic> getallMechanics() {
        return mechanicService.getAllMechanics();
    }
    

}
