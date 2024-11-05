package com.dosmakcic.mechanear.controllers;

import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import com.dosmakcic.mechanear.models.Mechanic;
import com.dosmakcic.mechanear.services.MechanicService;

@RestController
@RequestMapping("/mechanics")
public class MechanicController {
    @Autowired
    private MechanicService mechanicService;

    @PostMapping("/register")
    public Mechanic registerMechanic(@RequestBody Mechanic mechanic) {
        return mechanicService.saveMechanic(mechanic);
    }

    @GetMapping("/{id}")
    public Mechanic getMechanic(@PathVariable Long id) {
        return mechanicService.getMechanicById(id).orElse(null);
    }

}
