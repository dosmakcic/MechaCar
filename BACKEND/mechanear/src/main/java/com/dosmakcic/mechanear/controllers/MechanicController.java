package com.dosmakcic.mechanear.controllers;

import org.springframework.web.bind.annotation.*;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.dosmakcic.mechanear.repositories.LocationRepository;
import com.dosmakcic.mechanear.services.MechanicService;
import com.dosmakcic.mechanear.models.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
@RequestMapping("/mechanics")
@CrossOrigin
public class MechanicController {
    @Autowired
    private MechanicService mechanicService;

     @Autowired
    private LocationRepository locationRepository;

    @PostMapping("/register")
    public Mechanic registerMechanic(@RequestBody Mechanic mechanic) {
        if (mechanic.getLocation() != null) {
            Location location = locationRepository.findById(mechanic.getLocation().getId()).orElse(null);
            mechanic.setLocation(location);
        }
        return mechanicService.saveMechanic(mechanic);
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
