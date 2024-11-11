package com.dosmakcic.mechanear.models;


import jakarta.persistence.*;
import java.util.List;
import com.dosmakcic.mechanear.models.Location;


@Entity
public class Mechanic {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String name;

    private String email ;

    private String password;

    @ManyToOne
    @JoinColumn(name = "location_id") 
    private Location location;

    @ManyToMany(mappedBy = "selectedMechanics")
    private List<Driver> chosenbyDrivers;
    

    public Mechanic() {
    }

    public Mechanic(String name, Location location) {
        this.name = name;
        this.location = location;
    }


}
