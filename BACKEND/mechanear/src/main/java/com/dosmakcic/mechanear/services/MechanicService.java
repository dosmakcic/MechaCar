package com.dosmakcic.mechanear.services;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import com.dosmakcic.mechanear.models.Mechanic;
import com.dosmakcic.mechanear.repositories.MechanicRepository;
import org.springframework.stereotype.Service;


@Service
public class MechanicService {

    @Autowired
    private MechanicRepository mechanicRepository;
    
    public  List<Mechanic> getAllMechanics(){
       return mechanicRepository.findAll();
    }

    public Optional<Mechanic> getMechanicById(Long id) {
        return mechanicRepository.findById(id);
    }

    public Mechanic saveMechanic(Mechanic mechanic) {
        return mechanicRepository.save(mechanic);
    }

}
