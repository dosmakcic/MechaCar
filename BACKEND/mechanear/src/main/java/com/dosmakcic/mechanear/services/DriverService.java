package com.dosmakcic.mechanear.services;

import java.util.*;

import com.dosmakcic.mechanear.models.Driver;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import com.dosmakcic.mechanear.repositories.DriverRepository;


@Service
public class DriverService {

 @Autowired
 private DriverRepository driverRepository;
 

 public List<Driver> getAllDrivers() {
    return driverRepository.findAll();
 }

 public Optional<Driver> getDriverById(Long id) {
    return driverRepository.findById(id);
}
public boolean emailExists(String email) {
    return driverRepository.findByEmail(email).isPresent();
}


public Driver saveDriver(Driver driver) {
    return driverRepository.save(driver);
}




}
