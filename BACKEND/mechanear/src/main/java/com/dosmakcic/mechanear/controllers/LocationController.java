package com.dosmakcic.mechanear.controllers;

import com.dosmakcic.mechanear.models.Location;
import com.dosmakcic.mechanear.repositories.LocationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/locations")
@CrossOrigin
public class LocationController {

    @Autowired
    private LocationRepository locationRepository;

    @GetMapping
    public List<Location> getAllLocations() {
        return locationRepository.findAll();
    }

    @GetMapping("/{id}")
    public Location getLocationById(@PathVariable Long id) {
        return locationRepository.findById(id).orElse(null);
    }

    @GetMapping("/search")
    public List<Location> searchLocations(@RequestParam String cityName) {
        return locationRepository.findByCityContainingIgnoreCase(cityName);
    }
}
