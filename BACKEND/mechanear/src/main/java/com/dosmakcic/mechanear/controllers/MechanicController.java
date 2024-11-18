package com.dosmakcic.mechanear.controllers;

import org.springframework.web.bind.annotation.*;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;

import com.dosmakcic.mechanear.repositories.LocationRepository;
import com.dosmakcic.mechanear.services.MechanicService;
import com.dosmakcic.mechanear.models.*;


@RestController
@RequestMapping("/mechanics")
@CrossOrigin
public class MechanicController {
    @Autowired
    private MechanicService mechanicService;

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


    @GetMapping("/{id}")
    public Mechanic getMechanic(@PathVariable Long id) {
        return mechanicService.getMechanicById(id).orElse(null);
    }

    @GetMapping
    public List<Mechanic> getallMechanics() {
        return mechanicService.getAllMechanics();
    }
    

}
