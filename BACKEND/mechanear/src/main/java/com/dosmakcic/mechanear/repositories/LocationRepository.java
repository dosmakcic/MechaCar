package com.dosmakcic.mechanear.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.dosmakcic.mechanear.models.Location;
import java.util.List;

@Repository
public interface LocationRepository extends JpaRepository<Location,Long> {
    List<Location> findByCityContainingIgnoreCase(String cityName);
}
