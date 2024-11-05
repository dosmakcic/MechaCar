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
 

 public Optional<Driver> getDriverById(Long id) {
    return driverRepository.findById(id);
}

public Driver saveDriver(Driver driver) {
    return driverRepository.save(driver);
}




}
