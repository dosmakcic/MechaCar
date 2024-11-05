package com.dosmakcic.mechanear.models;


import jakarta.persistence.*;
import java.util.List;


@Entity
public class Mechanic {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String name;

    private String email;

    private String password;

    private String city;

    @ManyToMany(mappedBy = "selectedMechanics")
    private List<Driver> chosenbyDrivers;

}
