package com.dosmakcic.mechanear.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.dosmakcic.mechanear.models.Driver;
import java.util.List;
import java.util.Optional;



@Repository
public interface DriverRepository extends JpaRepository<Driver,Long> {

    Optional<Driver>  findByEmail(String email);

}
