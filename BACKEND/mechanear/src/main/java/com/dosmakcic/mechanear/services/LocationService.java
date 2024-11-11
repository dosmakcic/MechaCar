package com.dosmakcic.mechanear.services;

import com.dosmakcic.mechanear.models.Location;
import com.dosmakcic.mechanear.repositories.LocationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

@Service
public class LocationService {

    @Autowired
    private LocationRepository locationRepository;

    @PostConstruct
    public void initDatabase() {
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(getClass().getResourceAsStream("/hr-cities.csv"), StandardCharsets.UTF_8))) {
            
            String line;
            List<Location> locations = new ArrayList<>();
            reader.readLine(); 
            
            while ((line = reader.readLine()) != null) {
                String[] fields = line.split(";");
                int count=0;
                
                Long id = Long.parseLong(fields[4]);
                String city = fields[0];
                String country = fields[3];
                
                
                double latitude = Double.parseDouble(fields[1].replace(",", "."));
                double longitude = Double.parseDouble(fields[2].replace(",", "."));

                Location location = new Location(id, city, country, latitude, longitude);
                
                locations.add(location);
                

                
            }
           
                locationRepository.saveAll(locations);
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Location> getAllLocations() {
        return locationRepository.findAll(); // Ovo vraća sve lokacije iz baze
    }
}

