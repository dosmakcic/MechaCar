package com.dosmakcic.mechanear.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.dosmakcic.mechanear.models.Mechanic;

public interface MechanicRepository extends JpaRepository<Mechanic,Long>{
   
    Optional<Mechanic> findByEmail(String email);
}
